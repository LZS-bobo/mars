//
//  SBCustomTransition.m
//  mars选择城市动画
//
//  Created by 罗壮燊 on 2017/2/6.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "SBCustomTransition.h"


typedef NS_ENUM(NSUInteger, SBDirection) {
    SBDirectionLeft,
    SBDirectionRight
};

#pragma mark - Convert Degrees to Radian
double radianFromDegree(float degrees) {
    return (degrees / 180) * M_PI;
}

void animation(UIView *view, SBDirection direction, BOOL isPush)
{
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 0.5;
    BOOL isLeft = (direction == SBDirectionLeft);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/ 500;
    if (isPush) {
        transform.m43 = isLeft ? 1000:0;
    } else {
        transform.m43 = isLeft ? 0:1000;
    }
    
    CAKeyframeAnimation *anim_3d =  [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D begin = CATransform3DRotate(transform, radianFromDegree(0), 0, 1, 0);
    CATransform3D middle = CATransform3DRotate(transform, radianFromDegree(isLeft ? 25:-25), 0, 1, 0);
    middle.m43 = 0;
    
    CATransform3D end = CATransform3DRotate(transform, radianFromDegree(isLeft ? 10:0), 0, 1, 0);
    
    if (isPush) {
        end.m43 = isLeft ? -1000:0;
    } else {
        end.m43 = isLeft ? 0:-1000;
    }
    
    
    anim_3d.values = @[[NSValue valueWithCATransform3D: begin],[NSValue valueWithCATransform3D:middle] ,[NSValue valueWithCATransform3D:end]];
    
    
    CAKeyframeAnimation *anim_move =  [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim_move.values = @[@(0),@(isLeft ? -50:50),@(isLeft ? -20:0)];
    
    CAKeyframeAnimation *anim_scale =  [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim_scale.values = @[@(1),@(0.6),@(isLeft ? 0.8:1)];
    
    animaGroup.animations = @[anim_3d, anim_move, anim_scale];
    [view.layer addAnimation:animaGroup forKey:nil];
}


@implementation SBPushTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [containerView addSubview:toVC.view];
    
    fromVC.view.layer.position = CGPointMake(0, fromVC.view.frame.size.height/2.0f);
    fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.layer.position = CGPointMake(toVC.view.frame.size.width, toVC.view.frame.size.height/2.0f);
    toVC.view.layer.anchorPoint = CGPointMake(1, 0.5);
    
    
    //添加动画
    animation(fromVC.view, SBDirectionLeft, YES);
    animation(toVC.view, SBDirectionRight, YES);
    
    [self performSelector:@selector(finishAnim:) withObject:transitionContext afterDelay:0.5];
    
}

- (void)finishAnim:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}


@end

//pop
@implementation SBPopTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect frame = [transitionContext finalFrameForViewController:toVC];
    
    [containerView addSubview:toVC.view];
    
    
    fromVC.view.layer.position = CGPointMake(frame.size.width, frame.size.height/2.0f);
    fromVC.view.layer.anchorPoint = CGPointMake(1, 0.5);
    
    toVC.view.frame = frame;
    toVC.view.layer.position = CGPointMake(0, frame.size.height/2.0f);
    toVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    
    animation(fromVC.view, SBDirectionRight, NO);
    animation(toVC.view, SBDirectionLeft, NO);
    
    [self performSelector:@selector(finishAnim:) withObject:transitionContext afterDelay:0.5];
    
}


- (void)finishAnim:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

@end
