//
//  TWCoreDataUserTimelineDataSource.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWCoreDataUserTimelineDataSource.h"
#import "TWCommon.h"
#import "TWTimelineCursor.h"
#import "TWCoreService.h"
#import "NSArray+CoreData.h"

#import "TWTweet.h"
#import "TWUser.h"

@import TwitterKit;
#import <MagicalRecord/MagicalRecord.h>
#import "Reachability.h"


@interface TWCoreDataUserTimelineDataSource ()

@property (nonatomic, assign) BOOL firstLoadPerformed;

@end


@implementation TWCoreDataUserTimelineDataSource

- (void)loadPreviousTweetsBeforePosition:(nullable NSString *)position completion:(TWTRLoadTimelineCompletion)completion {
    
    if ((!self.firstLoadPerformed || !CoreService.isOnline) && position == nil) {
        [self loadLocalTweetsWithCompletion:completion];
        self.firstLoadPerformed = YES;
    }
    
    if (CoreService.isOnline) {
        [super loadPreviousTweetsBeforePosition:position
                                     completion:^(NSArray<TWTRTweet *> * _Nullable tweets, TWTRTimelineCursor * _Nullable cursor, NSError * _Nullable error) {
                                         
                                         if (tweets.count) {
                                             __block NSArray * localTweets = nil;
                                             
                                             [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
                                                 localTweets = [self importTweetsFromArray:tweets inContext:localContext];
                                             } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
                                                 completion([localTweets mainThreadObjects], cursor, error);
                                             }];
                                         }
                                         else {
                                             completion(nil, cursor, error);
                                         }
                                     }];
    } else if (position != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil, nil, nil);
        });
    }
}

- (void)loadLocalTweetsWithCompletion:(TWTRLoadTimelineCompletion)completion {
    NSManagedObjectContext * context = [NSManagedObjectContext MR_context];
    [context performBlock:^{
        NSArray <TWTweet *> * tweets = [TWTweet MR_findAllSortedBy:@"createdAt"
                                                         ascending:NO
                                                     withPredicate:[NSPredicate predicateWithFormat:@"author == %@", [CoreService.user MR_inContext:context]]
                                                         inContext:context];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSArray * mainThreadTweets = [tweets mainThreadObjects];
            completion(mainThreadTweets, (id)TWTimelineCursorCreate([mainThreadTweets.lastObject tweetID], nil), nil);
        });
    }];
}

/* 
MagicalRecord has very inflexible and slow import, so I wrote custom import. 
In future is possible to write 'Smart Import' addition to it, with more mapping options 
 (like 'ignore property', 'uniq id' etc) and fast algorithms of relationships mapping and finding existing objects (with one big fetch instead of many small fetches). I already implemented this mechanisms, but it are not integrated to the MagicalRecord ecosystem (You can see it from my Took-Kit project on GitHub. For example, here is my mapper https://github.com/Alexander-Koryttsev/Tool-Kit/blob/master/Tool%20Kit/Sources/Local%20Data/Core%20Data/Commons/TKCoreDataMapper.m )
*/
- (NSArray <TWTweet *> *)importTweetsFromArray:(NSArray <TWTRTweet *> *)remoteTweets
                                     inContext:(NSManagedObjectContext *)context {
    
    TWUser * localUser = [CoreService.user MR_inContext:context];
    
    NSArray <TWTweet *> * localTweets = [TWTweet MR_findAllSortedBy:@"tweetID"
                                                          ascending:YES
                                                      withPredicate:[NSPredicate predicateWithFormat:@"tweetID IN %@", [remoteTweets valueForKey:@"tweetID"]]
                                                          inContext:context];
    NSEnumerator * localTweetsEnumerator = [localTweets objectEnumerator];
    __block TWTweet * localTweet = [localTweetsEnumerator nextObject];
    
    NSArray <TWTRTweet *> * sortedRemoteTweets = [remoteTweets sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tweetID"
                                                                                                                           ascending:YES]]];
    NSMutableArray <TWTweet *> * mappedTweets = [NSMutableArray arrayWithCapacity:remoteTweets.count];
    
    [sortedRemoteTweets enumerateObjectsUsingBlock:^(TWTRTweet * _Nonnull remoteTweet, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TWTweet * tweetToMap = nil;
        BOOL isUpdate = [localTweet.tweetID isEqualToString:remoteTweet.tweetID];
        
        tweetToMap = isUpdate ? localTweet : [TWTweet MR_createEntityInContext:context];
        [tweetToMap fillAttributesFromTweet:remoteTweet];
        tweetToMap.author = localUser;
        
        if (remoteTweet.retweetedTweet) {
            if (!tweetToMap.retweetedTweet) {
                tweetToMap.retweetedTweet = [TWTweet MR_createEntityInContext:context];
            }
            [tweetToMap.retweetedTweet fillAttributesFromTweet:remoteTweet.retweetedTweet];
            tweetToMap.retweetedTweet.author = [TWUser MR_importFromObject:remoteTweet.retweetedTweet.author
                                                                 inContext:context];
        }
        [mappedTweets addObject:tweetToMap];
        
        if (isUpdate) {
            localTweet = [localTweetsEnumerator nextObject];
        }
    }];
    
    return [mappedTweets sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                                                                     ascending:NO]]];
}

@end
