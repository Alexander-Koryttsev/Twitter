//
//  TWUser.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/9/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWManagedObject.h"

@class TWTweet;


NS_ASSUME_NONNULL_BEGIN

@interface TWUser : TWManagedObject

@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, assign) BOOL isProtected;
@property (nullable, nonatomic, retain) NSURL *profileURL;

@end

NS_ASSUME_NONNULL_END

#import "TWUser+CoreDataProperties.h"
