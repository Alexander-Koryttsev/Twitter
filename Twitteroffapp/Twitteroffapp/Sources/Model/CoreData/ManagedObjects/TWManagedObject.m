//
//  TWManagedObject.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/10/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWManagedObject.h"
#import "NSObject+Extensions.h"
#import <MagicalRecord/MagicalRecord.h>


@implementation TWManagedObject

+ (NSString *)entityName {
    return [[self classString] substringFromIndex:2];
}


+ (void)deleteAll {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        [[self MR_findAllInContext:localContext] enumerateObjectsUsingBlock:^(__kindof NSManagedObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj MR_deleteEntityInContext:localContext];
        }];
    }];
}

@end
