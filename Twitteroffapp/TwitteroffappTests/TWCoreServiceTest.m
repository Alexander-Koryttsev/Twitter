//
//  TWCoreServiceTest.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/12/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

// Run tests only when you already signed through Twitteroffapp at least one time and Twitter system settings allows Twitteroffapp to use account settings

#import "TWCoreService.h"
#import <MagicalRecord/MagicalRecord.h>
#import "TWUser.h"
#import "TWTweet.h"
#import "TWCoreDataUserTimelineDataSource.h"
#import "Kiwi.h"


@interface TWCoreService (KiwiHelper)

@property (nonatomic, strong) id session;

//It's like 'soft' sign out
+ (void)resetSingleton;

@end


SPEC_BEGIN(CoreServiceTest)

describe(@"Singleton", ^{
    it(@"Protection", ^{
        CoreService;
        [[theBlock(^{
            [TWCoreService alloc];
        }) should] raise];
    });
    
    it(@"Reset", ^{
        [TWCoreService resetSingleton];
        [[CoreService should] beNonNil];
    });
});

describe(@"Authentication", ^{
    it(@"General sign in", ^{
        __block BOOL futureSuccess = NO;
        [CoreService signInWithCompletion:^(BOOL success, NSError *error) {
            [[theValue([TWUser MR_countOfEntities]) shouldNot] beZero];
            [[theValue(CoreService.user) shouldNot] beNil];
            [[theValue(CoreService.api) shouldNot] beNil];
            [[theValue(CoreService.session) shouldNot] beNil];
            [[theValue(CoreService.reachability) shouldNot] beNil];
            futureSuccess = success;
        }];
        
        [[expectFutureValue(theValue(futureSuccess)) shouldEventuallyBeforeTimingOutAfter(5.0)] beYes];
    });
    
    it(@"Auto sign in", ^{
        [TWCoreService resetSingleton];
        BOOL signedIn = [CoreService autoSignIn];
        [[theValue(signedIn) should] beYes];
        [[theValue(CoreService.user) shouldNot] beNil];
        [[theValue(CoreService.api) shouldNot] beNil];
        [[theValue(CoreService.session) shouldNot] beNil];
        [[theValue(CoreService.reachability) shouldNot] beNil];
    });
});

describe(@"Tweets", ^{
    it(@"Fetch", ^{
        
        [TWTweet deleteAll];
        [[theValue([TWTweet MR_countOfEntities]) should] beZero];
        
        TWCoreDataUserTimelineDataSource * dataSource = [[TWCoreDataUserTimelineDataSource alloc] initWithScreenName:CoreService.user.screenName
                                                           APIClient:CoreService.api];
        [[theValue(dataSource) shouldNot] beNil];
        __block NSInteger count = 0;
        [dataSource loadPreviousTweetsBeforePosition:nil
                                          completion:^(NSArray<TWTRTweet *> * _Nullable tweets, TWTRTimelineCursor * _Nullable cursor, NSError * _Nullable error) {
                                              NSLog(@"loaded tweets count %lu", [tweets count]);
                                              count = [TWTweet MR_countOfEntities];
                                          }];
        [[expectFutureValue(theValue(count)) shouldEventuallyBeforeTimingOutAfter(5.0)] beGreaterThan:theValue(0)];
        
    });
});

describe(@"Sign out", ^{
    it(@"Sign out", ^{
        [CoreService signOut];
        [[(id)CoreService.user should] beNil];
        [[(id)CoreService.api should] beNil];
        [[(id)CoreService.session should] beNil];
        [[theValue([TWUser MR_countOfEntities]) should] beZero];
        [[theValue([TWTweet MR_countOfEntities]) should] beZero];
    });
});

SPEC_END


