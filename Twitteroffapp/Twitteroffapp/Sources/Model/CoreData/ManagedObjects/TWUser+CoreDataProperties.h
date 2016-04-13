//
//  TWUser+CoreDataProperties.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TWUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *formattedScreenName;
@property (nullable, nonatomic, retain) NSNumber *isProtectedNumber;
@property (nullable, nonatomic, retain) NSNumber *isVerifiedNumber;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *profileImageLargeURL;
@property (nullable, nonatomic, retain) NSString *profileImageMiniURL;
@property (nullable, nonatomic, retain) NSString *profileImageURL;
@property (nullable, nonatomic, retain) NSString *profileURLString;
@property (nullable, nonatomic, retain) NSString *screenName;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSSet<TWTweet *> *tweets;

@end

@interface TWUser (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(TWTweet *)value;
- (void)removeTweetsObject:(TWTweet *)value;
- (void)addTweets:(NSSet<TWTweet *> *)values;
- (void)removeTweets:(NSSet<TWTweet *> *)values;

@end

NS_ASSUME_NONNULL_END
