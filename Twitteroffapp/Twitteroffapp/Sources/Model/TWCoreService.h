//
//  TWCoreService.h
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWUser;
@class TWTRAPIClient;
@class TWTRUser;
@class TWTRUserTimelineDataSource;
@class Reachability;
@class RACSignal;


#define CoreService [TWCoreService sharedSingleton]


@interface TWCoreService : NSObject

@property (nonatomic, strong, readonly) TWUser * user;
@property (nonatomic, strong, readonly) TWTRAPIClient * api;
@property (nonatomic, strong, readonly) Reachability * reachability;
@property (nonatomic, assign, readonly) BOOL isOnline;

+ (instancetype)sharedSingleton;

- (BOOL)autoSignIn;
- (void)signInWithCompletion:(void (^)(BOOL success, NSError * error))completion;
- (void)signOut;

@end
