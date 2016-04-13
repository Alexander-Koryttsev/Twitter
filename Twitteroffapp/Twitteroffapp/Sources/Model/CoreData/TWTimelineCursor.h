//
//  TWTimelineCursor.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWTimelineCursor : NSObject

@property (nonatomic, strong) NSString * minPosition;
@property (nonatomic, strong) NSString * maxPosition;

@end

TWTimelineCursor * TWTimelineCursorCreate(NSString * minPosition, NSString * maxPosition);
