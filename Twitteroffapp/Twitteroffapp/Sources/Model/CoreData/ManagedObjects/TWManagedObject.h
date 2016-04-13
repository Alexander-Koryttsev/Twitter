//
//  TWManagedObject.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/10/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface TWManagedObject : NSManagedObject

+ (NSString *)entityName;
+ (void)deleteAll;

@end
