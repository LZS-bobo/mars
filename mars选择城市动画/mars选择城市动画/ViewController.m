//
//  ViewController.m
//  mars选择城市动画
//
//  Created by 罗壮燊 on 2017/2/4.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = self.view.frame;
    imageView.image = self.image;
    imageView.clipsToBounds = YES;
    imageView.layer.masksToBounds = YES;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBtn setTitle:@"选择" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 20, 60, 40);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageView];
    [self.view addSubview:backBtn];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
