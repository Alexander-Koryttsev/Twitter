//
//  NSArray+CoreData.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/12/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray<ObjectType> (CoreData)

//Call only from main thread
- (NSArray <ObjectType> *)mainThreadObjects;

@end
