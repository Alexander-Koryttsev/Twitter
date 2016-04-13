//
//  TWUser.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/9/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWUser.h"
#import "TWTweet.h"


@implementation TWUser

@dynamic isVerified;
@dynamic isProtected;
@dynamic profileURL;

- (BOOL)isVerified {
    return self.isVerifiedNumber.boolValue;
}

- (void)setIsVerified:(BOOL)isVerified {
    self.isVerifiedNumber = @(isVerified);
}


- (BOOL)isProtected {
    return self.isProtectedNumber.boolValue;
}

- (void)setIsProtected:(BOOL)isProtected {
    self.isProtectedNumber = @(isProtected);
}


- (NSURL *)profileURL {
    return [NSURL URLWithString:self.profileURLString];
}

- (void)setProfileURL:(NSURL *)profileURL {
    self.profileURLString = profileURL.absoluteString;
}

- (void)setProfileURLString:(NSString *)profileURLString {
    if ([profileURLString isKindOfClass:[NSURL class]]) {
        profileURLString = [(NSURL *)profileURLString absoluteString];
    }
    
    [self setPrimitiveValue:profileURLString forKey:@"profileURLString"];
}

@end
