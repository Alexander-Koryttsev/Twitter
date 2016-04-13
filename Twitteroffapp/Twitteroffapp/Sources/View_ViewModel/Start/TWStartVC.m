//
//  TWStartVC.m
//  Twitter
//
//  Created by Alexander Koryttsev on 4/8/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWStartVC.h"
#import "TWHomeVC.h"
#import "TWCommon.h"
#import "TWGUICommon.h"
#import "TWStartVM.h"


@interface TWStartVC ()

@property (strong, nonatomic) IBOutlet UILabel *hiLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *hiLabelConstraintTopSpace;
@property (strong, nonatomic) IBOutlet UIView *signInButtonContainer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *developedForLabel;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoConstraintCenterY;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;

@property (strong, nonatomic) TWStartVM * viewModel;

@end


@implementation TWStartVC

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor twitterColor]];
    
    self.hiLabel.text = NSLocalizedString(@"hiMessage", nil);
    [self.signInButton setTitle:NSLocalizedString(@"signInWithTwitter", nil) forState:UIControlStateNormal];
    self.developedForLabel.text = NSLocalizedString(@"special", nil);

    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.logoConstraintCenterY.active = NO;
        [UIView animateWithDuration:1.5
                         animations:^{
                             self.hiLabel.alpha = 1;
                             [self.view layoutIfNeeded];
                         }];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - RAC

- (void)bindViewModel {
    self.viewModel = [TWStartVM new];
    [self.viewModel.autoSignInSignal subscribeNext:^(id x) {
        [self showHomeAnimated:NO];
    }];

    self.signInButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        [SVProgressHUD show];
        [self.viewModel.signInSignal subscribeError:^(NSError *error) {
            [self showError:error];
            [SVProgressHUD dismiss];
        } completed:^{
            [self showHomeAnimated:YES];
            [SVProgressHUD dismiss];
        }];
        return [RACSignal empty];
    }];
}

#pragma mark - Actions

- (void)showHomeAnimated:(BOOL)animated {
    TWHomeVC * homeVC = [TWHomeVC createFromStoryboard];
    [self.navigationController pushViewController:homeVC animated:animated];
}

#pragma mark - Segues

- (IBAction)signOutSegue:(UIStoryboardSegue *)segue {
    [self.viewModel signOut];
}

@end
