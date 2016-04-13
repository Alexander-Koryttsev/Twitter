//
//  UIViewController+Extensions.m
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "UIViewController+Extensions.h"
#import "TWCommon.h"


@implementation UIViewController (Extensions)

+ (instancetype)createFromStoryboard {
    return [[UIStoryboard storyboardWithName:[self classString] bundle:nil] instantiateInitialViewController];
}

- (void)showError:(NSError *)error {
    if (!error) { return; }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", nil)
                                                     message:[error localizedDescription]
                                                    delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"ok", nil)
                                           otherButtonTitles:nil];
    [alert show];
}

@end
