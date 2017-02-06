//
//  SBTableViewCell.m
//  mars选择城市动画
//
//  Created by 罗壮燊 on 2017/2/4.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "SBTableViewCell.h"

@implementation SBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    [self.textLabel sizeToFit];
    self.textLabel.center = self.imageView.center;
    
    [self.contentView insertSubview:self.imageView atIndex:0];
    
}

@end
