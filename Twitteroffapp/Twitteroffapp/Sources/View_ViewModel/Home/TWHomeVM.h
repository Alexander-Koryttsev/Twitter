//
//  TWHomeVM.h
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/11/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWViewModel.h"

@class TWTRUserTimelineDataSource;


@interface TWHomeVM : TWViewModel;

@property (nonatomic, strong, readonly) NSString * userName;
@property (nonatomic, strong, readonly) NSString * userID;

- (TWTRUserTimelineDataSource *)userTimeLineDataSource;

@end
