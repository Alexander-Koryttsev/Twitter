//
//  NSArray+CoreData.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/12/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "NSArray+CoreData.h"

#import <MagicalRecord/MagicalRecord.h>


@implementation NSArray (CoreData)

- (NSArray *)mainThreadObjects {
    NSAssert([NSThread isMainThread], @"Should be main thread");
    NSManagedObjectContext * mainContext = [NSManagedObjectContext MR_defaultContext];
    NSMutableArray * mainThreadObjects = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mainThreadObjects addObject:[obj MR_inContext:mainContext]];
    }];
    
    return [mainThreadObjects copy];
}

@end
