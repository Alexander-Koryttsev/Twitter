//
//  NSError+Extensions.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "NSError+Extensions.h"

@implementation NSError (Extensions)

+ (NSError *)noInternetError {
    return [NSError errorWithDomain:@"Twitteroffapp"
                               code:0
                           userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"noInternetMessage", nil)}];
}

@end
