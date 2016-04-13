//
//  TWTimelineCursor.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWTimelineCursor.h"

@implementation TWTimelineCursor

@end


TWTimelineCursor * TWTimelineCursorCreate(NSString * minPosition, NSString * maxPosition) {
    TWTimelineCursor * cursor = [TWTimelineCursor new];
    cursor.minPosition = minPosition;
    cursor.maxPosition = maxPosition;
    return cursor;
}
