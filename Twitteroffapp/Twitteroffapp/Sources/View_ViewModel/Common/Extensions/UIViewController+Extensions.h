//
//  UIViewController+Extensions.h
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extensions)

+ (instancetype)createFromStoryboard;
- (void)showError:(NSError *)error;

@end
