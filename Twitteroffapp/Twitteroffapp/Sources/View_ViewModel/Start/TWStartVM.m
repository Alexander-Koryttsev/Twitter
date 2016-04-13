//
//  TWStartVM.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWStartVM.h"
#import "TWViewModel_Protected.h"


@interface TWStartVM ()

@property (nonatomic, strong) RACCommand * signInCommand;
@property (nonatomic, strong) RACSignal * signInSignal;
@property (nonatomic, strong) RACSignal * autoSignInSignal;

@end


@implementation TWStartVM

- (id)init {
    self = [super init];
    if (self) {
        self.signInSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [CoreService signInWithCompletion:^(BOOL success, NSError *error) {
                if (!success || error) {
                    [subscriber sendError:error];
                }
                else {
                    [subscriber sendCompleted];
                }
            }];
            
            return nil;
        }];
        
        self.autoSignInSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if ([CoreService autoSignIn]) {
                [subscriber sendNext:nil];
            }
            [subscriber sendCompleted];
            
            return nil;
        }];
        
        self.signInCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return self.signInSignal;
        }];
    }
    
    return self;
}

- (void)signOut {
    [CoreService signOut];
}


@end
