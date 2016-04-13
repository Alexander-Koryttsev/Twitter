//
//  TWTweet.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/9/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWTweet.h"
#import "TWUser.h"

#import <TwitterKit/TWTRTweet.h>


@implementation TWTweet

@dynamic likeCount;
@dynamic retweetCount;
@dynamic isLiked;
@dynamic isRetweeted;
@dynamic isRetweet;
@dynamic permalink;

- (long long)likeCount {
    return self.likeCountNumber.longLongValue;
}

- (void)setLikeCount:(long long)likeCount {
    self.likeCountNumber = @(likeCount);
}


- (long long)retweetCount {
    return self.retweetCountNumber.longLongValue;
}

- (void)setRetweetCount:(long long)retweetCount {
    self.retweetCountNumber = @(retweetCount);
}


- (BOOL)isLiked {
    return self.isLikedNumber.boolValue;
}

- (void)setIsLiked:(BOOL)isLiked {
    self.isLikedNumber = @(isLiked);
}


- (BOOL)isRetweeted {
    return self.isRetweetedNumber.boolValue;
}

- (void)setIsRetweeted:(BOOL)isRetweeted {
    self.isRetweetedNumber = @(isRetweeted);
}


- (BOOL)isRetweet {
    return self.isRetweetNumber.boolValue;
}

- (void)setIsRetweet:(BOOL)isRetweet {
    self.isRetweetNumber = @(isRetweet);
}


- (NSURL *)permalink {
    return [NSURL URLWithString:self.permalinkString];
}

- (void)setPermalink:(NSURL *)permalink {
    self.permalinkString = permalink.absoluteString;
}

- (void)setPermalinkString:(NSString *)permalinkString {
    if ([permalinkString isKindOfClass:[NSURL class]]) {
        permalinkString = [(NSURL *)permalinkString absoluteString];
    }
    
    [self setPrimitiveValue:permalinkString forKey:@"permalinkString"];
}

//Private getters. No time to investigate it.
- (id)media {
    return nil;
}

- (id)urls {
    return nil;
}

- (id)mediaEntity {
    return nil;
}

- (BOOL)hasMedia {
    return NO;
}
//---

- (void)fillAttributesFromTweet:(TWTRTweet *)tweet {
    self.createdAt = tweet.createdAt;
    self.tweetID = tweet.tweetID;
    self.inReplyToScreenName = tweet.inReplyToScreenName;
    self.inReplyToTweetID = tweet.inReplyToTweetID;
    self.inReplyToUserID = tweet.inReplyToUserID;
    self.isLiked = tweet.isLiked;
    self.isRetweet = tweet.isRetweet;
    self.isRetweeted = tweet.isRetweeted;
    self.languageCode = tweet.languageCode;
    self.likeCount = tweet.likeCount;
    self.permalink = tweet.permalink;
    self.perspectivalUserID = tweet.perspectivalUserID;
    self.retweetCount = tweet.retweetCount;
    self.retweetID = tweet.retweetID;
    self.text = tweet.text;
}

- (TWTweet *)tweetWithLikeToggled {
    self.isLiked = !self.isLiked;
    return self;
}

- (TWTweet *)tweetWithPerspectivalUserID:(NSString *)perspectivalUserID {
    self.perspectivalUserID = perspectivalUserID;
    return self;
}

@end
