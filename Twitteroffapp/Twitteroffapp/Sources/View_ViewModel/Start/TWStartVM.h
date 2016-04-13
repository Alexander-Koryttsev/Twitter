//
//  TWStartVM.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWViewModel.h"


@interface TWStartVM : TWViewModel

@property (nonatomic, strong, readonly) RACCommand * signInCommand;
@property (nonatomic, strong, readonly) RACSignal * signInSignal;
@property (nonatomic, strong, readonly) RACSignal * autoSignInSignal;

- (void)signOut;

@end
