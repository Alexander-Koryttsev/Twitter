//
//  TWButton.m
//  Twitteroffapp
//
//  Created by Alexander Koryttsev on 4/12/16.
//  Copyright © 2016 Alexander Koryttsev. All rights reserved.
//

#import "TWButton.h"
#import "UIColor+Extensions.h"


@implementation TWButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor twitterColor];
    self.tintColor = [UIColor whiteColor];
    self.imageView.highlightedImage = self.imageView.image;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = [UIColor twitterColorWithAlpha:highlighted ? 0.5 : 1 ];
}

@end
