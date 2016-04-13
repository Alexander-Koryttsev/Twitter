//
//  TWTweet.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/9/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWManagedObject.h"

@class TWUser;
@class TWTRTweet;

NS_ASSUME_NONNULL_BEGIN

@interface TWTweet : TWManagedObject

@property (nonatomic, assign) long long likeCount;
@property (nonatomic, assign) long long retweetCount;
@property (nonatomic, assign) BOOL isLiked;
@property (nonatomic, assign) BOOL isRetweeted;
@property (nonatomic, assign) BOOL isRetweet;
@property (nullable, nonatomic, retain) NSURL *permalink;

- (void)fillAttributesFromTweet:(TWTRTweet *)tweet;

@end

NS_ASSUME_NONNULL_END

#import "TWTweet+CoreDataProperties.h"
