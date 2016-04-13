//
//  TWViewModel.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TWViewModel : NSObject

@property (nonatomic, strong, readonly) RACSignal * becameOnlineSignal;

- (BOOL)isOnline;


@end
