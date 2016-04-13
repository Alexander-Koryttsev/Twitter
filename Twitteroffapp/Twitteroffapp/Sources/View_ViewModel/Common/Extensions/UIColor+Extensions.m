//
//  UIColor+Extensions.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/12/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)colorWithRedInt:(UInt8)red green:(UInt8)green blue:(UInt8)blue alpha:(CGFloat)alpha {
    return [self colorWithRed:(CGFloat)red/255.0 green:(CGFloat)green/255.0 blue:(CGFloat)blue/255.0 alpha:alpha];
}

+ (UIColor *)twitterColor {
    return [self twitterColorWithAlpha:1];
}

+ (UIColor *)twitterColorWithAlpha:(CGFloat)alpha {
    return [self colorWithRedInt:85 green:172 blue:238 alpha:alpha];
}

@end
