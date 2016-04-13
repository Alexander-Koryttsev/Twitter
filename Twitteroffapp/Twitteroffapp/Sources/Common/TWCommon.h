//
//  TWCommon.h
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#ifndef TWCommon_h
#define TWCommon_h

#import "TWAppDelegate.h"
#import "NSObject+Extensions.h"
#import "NSError+Extensions.h"

#define App                 [NSApplication sharedApplication]
#define AppDelegate         ((TWAppDelegate *)[App delegate])
#define UserDefaults        [NSUserDefaults standardUserDefaults]
#define NotificationCenter  [NSNotificationCenter defaultCenter]

#define SELF_WEAK_DECLARATION __weak typeof(self) selfWeak = self


#define SHARED_SINGLETON(__Class__) static __Class__ * _sharedSingleton = nil;\
\
+ (__Class__ *)sharedSingleton {\
static dispatch_once_t pred = 0;\
dispatch_once(&pred, ^{\
_sharedSingleton = [self new];\
});\
return _sharedSingleton;\
}\
\
+ (id)alloc {\
@synchronized([__Class__ class]) {\
NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");\
return [super alloc];\
}\
}

#endif /* TWCommon_h */
