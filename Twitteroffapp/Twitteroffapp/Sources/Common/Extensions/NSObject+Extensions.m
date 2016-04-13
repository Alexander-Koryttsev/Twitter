//
//  NSObject+Extensions.m
//  WMF Merchant
//
//  Created by Alexander Koryttsev on 1/27/16.
//  Copyright © 2016 INNOMOS GmbH. All rights reserved.
//

#import "NSObject+Extensions.h"

@implementation NSObject (Extensions)

+ (NSString *)classString {
    return NSStringFromClass(self.class);
}

- (NSString *)classString {
    return self.class.classString;
}

@end
