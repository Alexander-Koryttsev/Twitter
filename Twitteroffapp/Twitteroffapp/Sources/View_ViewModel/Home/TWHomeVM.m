//
//  TWHomeVM.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWHomeVM.h"
#import "TWViewModel_Protected.h"
#import "TWUser.h"
#import "TWCoreDataUserTimelineDataSource.h"


@interface TWHomeVM ()

@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userID;

@end


@implementation TWHomeVM

- (id)init {
    self = [super init];
    if (self) {
        self.userName = CoreService.user.formattedScreenName;
        self.userID = CoreService.user.userID;
    }
    
    return self;
}

- (TWTRUserTimelineDataSource *)userTimeLineDataSource {
    return [[TWCoreDataUserTimelineDataSource alloc] initWithScreenName:CoreService.user.screenName
                                                              APIClient:CoreService.api];
}


@end
