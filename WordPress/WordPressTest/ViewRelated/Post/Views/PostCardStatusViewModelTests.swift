
@testable import WordPress

import Nimble

private typealias ButtonGroups = PostCardStatusViewModel.ButtonGroups

class PostCardStatusViewModelTests: XCTestCase {
    private var contextManager: TestContextManager!
    private var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        contextManager = TestContextManager()
        context = contextManager.newDerivedContext()
    }

    override func tearDown() {
        context = nil
        contextManager = nil
        super.tearDown()
    }

    func testExpectedButtonGroupsForVariousPostAttributeCombinations() {
        // Arrange
        print(String(describing: PostCardStatusViewModel.Button.edit))

        let expectations: [(String, Post, ButtonGroups)] = [
            (
                "Draft with remote",
                PostBuilder(context).drafted().withRemote().build(),
                ButtonGroups(primary: [.edit, .view, .more], secondary: [.publish, .trash])
            ),
            (
                "Draft that was not uploaded to the server",
                PostBuilder(context).drafted().with(remoteStatus: .failed).build(),
                ButtonGroups(primary: [.edit, .publish, .trash], secondary: [])
            ),
            (
                "Local published draft with confirmed auto-upload",
                PostBuilder(context).published().with(remoteStatus: .failed).confirmedAutoUpload().build(),
                ButtonGroups(primary: [.edit, .cancelAutoUpload, .more], secondary: [.moveToDraft, .trash])
            ),
            (
                "Local published draft with canceled auto-upload",
                PostBuilder(context).published().with(remoteStatus: .failed).build(),
                ButtonGroups(primary: [.edit, .publish, .more], secondary: [.moveToDraft, .trash])
            ),
            (
                "Published post",
                PostBuilder(context).published().withRemote().build(),
                ButtonGroups(primary: [.edit, .view, .more], secondary: [.stats, .moveToDraft, .trash])
            )
        ]

        // Act and Assert
        expectations.forEach { scenario, post, expectedButtonGroups in
            let viewModel = PostCardStatusViewModel(post: post)

            expect({
                guard viewModel.buttonGroups == expectedButtonGroups else {
                    let reason = "The scenario \"\(scenario)\" failed. "
                        + " Expected buttonGroups to be: \(expectedButtonGroups.prettifiedDescription)."
                        + " Actual: \(viewModel.buttonGroups.prettifiedDescription)"

                    return .failed(reason: reason)
                }

                return .succeeded
            }).to(succeed())
        }
    }
}

private extension ButtonGroups {
    var prettifiedDescription: String {
        return "{ primary: \(primary.prettifiedDescription), secondary: \(secondary.prettifiedDescription) }"
    }
}

private extension Array where Element == PostCardStatusViewModel.Button {
    var prettifiedDescription: String {
        return "[" + map { String(describing: $0) }.joined(separator: ", ") + "]"
    }
}
