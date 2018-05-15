final class LikeAction {
    func execute(with post: ReaderPost, context: NSManagedObjectContext, completion: @escaping () -> Void) {
        if !post.isLiked {
            // Consider a like from the list to be enough to push a page view.
            // Solves a long-standing question from folks who ask 'why do I
            // have more likes than page views?'.
            ReaderHelpers.bumpPageViewForPost(post)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
        let service = ReaderPostService(managedObjectContext: context)
        service.toggleLiked(for: post, success: nil, failure: { (error: Error?) in
            if let anError = error {
                DDLogError("Error (un)liking post: \(anError.localizedDescription)")
            }
        })
    }
}
