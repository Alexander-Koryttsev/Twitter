//
//  TWViewModel.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWViewModel_Protected.h"

#import "Reachability.h"


@interface TWViewModel ()

@property (nonatomic, strong) RACSignal * becameOnlineSignal;

@end


@implementation TWViewModel

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (RACSignal *)becameOnlineSignal {
    if (!_becameOnlineSignal) {
        _becameOnlineSignal = [[RACObserve(CoreService, isOnline) distinctUntilChanged] filter:^BOOL(id value) {
            return [value boolValue];
        }];
    }
    
    return _becameOnlineSignal;
}

- (BOOL)isOnline {
    return [CoreService.reachability isReachable];
}

@end
