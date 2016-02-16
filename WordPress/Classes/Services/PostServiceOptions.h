#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PostServiceResultsOrder) {
    /**
     (default) Request results in descending order. For dates, that means newest to oldest.
     */
    PostServiceResultsOrderDescending = 0,
    /**
     Request results in ascending order. For dates, that means oldest to newest.
     */
    PostServiceResultsOrderAscending
};

typedef NS_ENUM(NSUInteger, PostServiceResultsOrdering) {
    /**
     (default) Order the results by the created time of each post.
     */
    PostServiceResultsOrderingByDate = 0,
    /**
     Order the results by the modified time of each post.
     */
    PostServiceResultsOrderingByModified,
    /**
     Order the results lexicographically by the title of each post.
     */
    PostServiceResultsOrderingByTitle,
    /**
     Order the results by the number of comments for each pot.
     */
    PostServiceResultsOrderingByCommentCount,
    /**
     Order the results by the postID of each post.
     */
    PostServiceResultsOrderingByPostID
};

/**
 @class PostServiceSyncOptions
 @brief A object for passing parameters to the API when requesting specific filtering of posts.
 See each remote API for specifics regarding default values and limits.
 WP.com/REST Jetpack: https://developer.wordpress.com/docs/api/1.1/get/sites/%24site/posts/
 XML-RPC: https://codex.wordpress.org/XML-RPC_WordPress_API/Posts
 */
@interface PostServiceSyncOptions : NSObject

@property (nonatomic, strong) NSArray *statuses;

/**
 The max number of posts to return.
 */
@property (nonatomic, strong) NSNumber *number;

/**
 0-indexed offset for paging requests.
 */
@property (nonatomic, strong) NSNumber *offset;

/**
 The order direction of the results.
 */
@property (nonatomic, assign) PostServiceResultsOrder order;

/**
 The ordering value used when ordering results.
 */
@property (nonatomic, assign) PostServiceResultsOrdering orderBy;

/**
 Specify posts only by the given authorID.
 @attention Not supported in XML-RPC.
 */
@property (nonatomic, strong) NSNumber *authorID;

/**
 A search query used when requesting posts.
 @attention Not supported in XML-RPC.
 */
@property (nonatomic, copy) NSString *search;

@end
