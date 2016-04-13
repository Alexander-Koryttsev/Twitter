//
//  TWTweet+CoreDataProperties.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TWTweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWTweet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) NSString *inReplyToScreenName;
@property (nullable, nonatomic, retain) NSString *inReplyToTweetID;
@property (nullable, nonatomic, retain) NSString *inReplyToUserID;
@property (nullable, nonatomic, retain) NSNumber *isLikedNumber;
@property (nullable, nonatomic, retain) NSNumber *isRetweetedNumber;
@property (nullable, nonatomic, retain) NSNumber *isRetweetNumber;
@property (nullable, nonatomic, retain) NSString *languageCode;
@property (nullable, nonatomic, retain) NSNumber *likeCountNumber;
@property (nullable, nonatomic, retain) NSString *permalinkString;
@property (nullable, nonatomic, retain) NSString *perspectivalUserID;
@property (nullable, nonatomic, retain) NSNumber *retweetCountNumber;
@property (nullable, nonatomic, retain) NSString *retweetID;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSString *tweetID;
@property (nullable, nonatomic, retain) TWTweet *retweetedTweet;
@property (nullable, nonatomic, retain) NSSet<TWTweet *> *retweets;
@property (nullable, nonatomic, retain) TWUser *author;

@end

@interface TWTweet (CoreDataGeneratedAccessors)

- (void)addRetweetsObject:(TWTweet *)value;
- (void)removeRetweetsObject:(TWTweet *)value;
- (void)addRetweets:(NSSet<TWTweet *> *)values;
- (void)removeRetweets:(NSSet<TWTweet *> *)values;

@end

NS_ASSUME_NONNULL_END
