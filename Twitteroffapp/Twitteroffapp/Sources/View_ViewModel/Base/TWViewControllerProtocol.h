//
//  TWViewControllerProtocol.h
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TWViewControllerProtocol <NSObject>

+ (instancetype)createFromStoryboard;
- (void)showError:(NSError *)error;

@end
