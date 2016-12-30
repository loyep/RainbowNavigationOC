//
//  SRainbowNavigation.m
//  RainbowNavigationSample
//
//  Created by eony on 2016/12/30.
//  Copyright © 2016年 danis. All rights reserved.
//

#import "SRainbowNavigation.h"
#import "RainbowPopAnimator.h"
#import "RainbowDragPop.h"
#import "RainbowPushAnimator.h"

@interface SRainbowNavigation ()

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic) RainbowPushAnimator *pushAnimator;
@property (nonatomic) RainbowPopAnimator *popAnimator;
@property (nonatomic) RainbowDragPop *dragPop;

@end

@implementation SRainbowNavigation
@synthesize dragPop;
@synthesize pushAnimator;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dragPop.popAnimator = self.popAnimator;
    }
    return self;
}

- (void)wireToNavigationController:(UINavigationController *)nc {
    self.navigationController = nc;
    self.dragPop.navigationController = nc;
    self.navigationController.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return self.popAnimator;
    }
    return self.pushAnimator;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.dragPop.interacting ? self.dragPop : nil;
}

@end
