//
//  TWHomeVC.m
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWHomeVC.h"
#import "TWHomeVM.h"
#import "TWCommon.h"
#import "TWGUICommon.h"

#import <TwitterKit/TWTRComposerViewController.h>


@interface TWHomeVC () <TWTRComposerViewControllerDelegate>

@property (nonatomic, strong) TWHomeVM * viewModel;

@end


@implementation TWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [TWHomeVM new];
    [self.viewModel.becameOnlineSignal subscribeNext:^(id x) {
        [super refresh];
    }];
    
    self.navigationItem.title = self.viewModel.userName;
    self.dataSource = [self.viewModel userTimeLineDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super refresh];
}

- (void)refresh {
    if (![self.viewModel isOnline]) {
        [self showError:[NSError noInternetError]];
        [self.refreshControl endRefreshing];
        return;
    }
    
    [super refresh];
}

#pragma mark - Actions

- (IBAction)add:(id)sender {
    if (![self.viewModel isOnline]) {
        [self showError:[NSError noInternetError]];
        return;
    }
    
    TWTRComposerViewController * vc = [[TWTRComposerViewController alloc] initWithUserID:self.viewModel.userID];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)signOut:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"signOut", nil)
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [self performSegueWithIdentifier:@"SignOut"
                                                                                    sender:nil];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Composer Delegate

- (void)composerDidSucceed:(TWTRComposerViewController *)controller withTweet:(TWTRTweet *)tweet {
    [self refresh];
}

- (void)composerDidFail:(TWTRComposerViewController *)controller withError:(NSError *)error {
    [self showError:error];
}

@end
