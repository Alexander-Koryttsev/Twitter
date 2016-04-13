//
//  TWCoreService.m
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWCoreService.h"
#import "TWCommon.h"
#import "TWCoreDataUserTimelineDataSource.h"

#import "TWUser.h"
#import "TWTweet.h"

@import TwitterKit;
@import Fabric;
#import "Reachability.h"
#import <MagicalRecord/MagicalRecord.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


#define MR_SHORTHAND
#define TwitterInst [Twitter sharedInstance]


@interface TWCoreService ()

@property (nonatomic, strong) Reachability * reachability;

@property (nonatomic, strong) TWTRSession * session;
@property (nonatomic, strong) TWTRAPIClient * api;
@property (nonatomic, strong) TWUser * user;
@property (nonatomic, assign) BOOL isOnline;

@end


@implementation TWCoreService

SHARED_SINGLETON(TWCoreService)

- (id)init {
    self = [super init];
    if (self) {
        [TwitterInst startWithConsumerKey:@"XxjR76Wm39NNhMPLbI4UnU3Oa"
                           consumerSecret:@"qiAPO4lcPamkDkXiTROan3uAwn7xpadD7b95XeJJUJLJrFRyZW"];
        [Fabric with:@[[Twitter class]]];
        
        [MagicalRecord setupCoreDataStack];
        [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
        
        self.reachability = [Reachability reachabilityWithHostName:@"www.twitter.com"];
        SELF_WEAK_DECLARATION;
        self.reachability.reachableBlock = ^(Reachability* r){
            selfWeak.isOnline = YES;
        };
        self.reachability.unreachableBlock = ^(Reachability* r){
            selfWeak.isOnline = NO;
        };
        [self.reachability startNotifier];
        
    }
    
    return self;
}

- (BOOL)autoSignIn {
    self.session = [TwitterInst sessionStore].session;
    if (!self.session) { return NO; }
    
    NSString * userID = self.session.userID;
    if (userID) {
        self.user = [TWUser MR_findFirstByAttribute:@"userID" withValue:userID];
    }
    
    if (!self.user) { return NO; }
    
    self.api = [TWTRAPIClient clientWithCurrentUser];
    if (!self.api) { return NO; }
    
    return YES;
}

- (void)signInWithCompletion:(void (^)(BOOL success, NSError * error))completion {
    [TwitterInst logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        if (session) {
            self.session = session;
            self.api = [TWTRAPIClient clientWithCurrentUser];
            [self.api loadUserWithID:self.session.userID
                          completion:^(TWTRUser * _Nullable user, NSError * _Nullable error) {
                              if (user) {
                                  self.user = [TWUser MR_importFromObject:user];
                                  [self.user.managedObjectContext MR_saveToPersistentStoreAndWait];
                              }
                              if (completion) {
                                  completion(user != nil && self.user != nil, error);
                              }
                              
                          }];
            NSLog(@"signed in as %@", [session userName]);
        } else {
            if (completion) {
                completion(NO, error);
            }
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
}

- (void)signOut {
    [TwitterInst.sessionStore logOutUserID:self.session.userID];
    self.user = nil;
    self.api = nil;
    self.session = nil;
    [TWUser deleteAll];
    [TWTweet deleteAll];
}
@end


@implementation TWCoreService (KiwiHelper)

+ (void)resetSingleton {
    _sharedSingleton = nil;
    _sharedSingleton = [self new];
}

@end
