//
//  SBCityPickerController.m
//  mars选择城市动画
//
//  Created by 罗壮燊 on 2017/2/4.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "SBCityPickerController.h"
#import "ViewController.h"

#import "SBTableViewCell.h"
#import "SBCustomTransition.h"


@interface SBCityPickerController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray *citys;

@end

@implementation SBCityPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.citys = @[@"北京",@"上海",@"南京",@"厦门",@"深圳",@"广州",];
    
    
    self.navigationController.delegate = self;
    
    
}

/** 返回转场动画实例*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[SBPushTransition alloc] init];
    }else if (operation == UINavigationControllerOperationPop){
        return [[SBPopTransition alloc] init];
    }
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.citys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (cell == nil) {
        cell = [[SBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = self.citys[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.frame = cell.bounds;
    cell.imageView.image = [UIImage imageNamed:self.citys[indexPath.row]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *city = [[ViewController alloc] init];
    city.image = [UIImage imageNamed:self.citys[indexPath.row]];
    [self.navigationController pushViewController:city animated:YES];
}




@end
