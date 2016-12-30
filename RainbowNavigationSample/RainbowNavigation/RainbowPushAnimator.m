//
//  RainbowPushAnimator.m
//  RainbowNavigationSample
//
//  Created by eony on 2016/12/30.
//  Copyright © 2016年 danis. All rights reserved.
//

#import "RainbowPushAnimator.h"
#import "RainbowColorSource.h"
#import "UINavigationBar+Rainbow.h"

@implementation RainbowPushAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //    if ([fromVC conformsToProtocol:@protocol(RainbowColorSource)] && [toVC conformsToProtocol:@protocol(RainbowColorSource)]) {
    //        UIColor *fromColorSource = [((UIViewController *<RainbowColorSource>)fromVC) ]
    //    }
    id<RainbowColorSource> fromColorSource = (id<RainbowColorSource>)fromVC;
    id<RainbowColorSource> toColorSource = (id<RainbowColorSource>)toVC;
    
    UIColor *nextColor = [UIColor clearColor];
    if ([fromColorSource respondsToSelector:@selector(navigationBarOutColor)]) {
        nextColor = [fromColorSource navigationBarOutColor];
    }
    
    if ([toColorSource respondsToSelector:@selector(navigationBarInColor)]) {
        nextColor = [toColorSource navigationBarInColor];
    }
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *shadowMask = [[UIView alloc] initWithFrame:containerView.bounds];
    shadowMask.backgroundColor = [UIColor blackColor];
    shadowMask.alpha = 0.f;

    [containerView addSubview:shadowMask];
    [containerView addSubview:toVC.view];

    
    CGRect originFromFrame = fromVC.view.frame;
    CGRect finalToFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalToFrame, finalToFrame.size.width, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.frame = CGRectOffset(fromVC.view.frame, fromVC.view.frame.size.width, 0);
        toVC.view.frame = finalToFrame;
        CGRect finalFromFrame = CGRectOffset(originFromFrame, - originFromFrame.size.width / 2, 0);
        fromVC.view.frame = finalFromFrame;
        shadowMask.alpha = 0.3f;
        
        UIColor *navigationColor = nextColor;
        if (navigationColor) {
            [fromVC.navigationController.navigationBar df_setBackgroundColor:navigationColor];
        }
    } completion:^(BOOL finished) {
        fromVC.view.frame = originFromFrame;
        [shadowMask removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
