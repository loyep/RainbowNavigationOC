//
//  RainbowDragPop.m
//  RainbowNavigationSample
//
//  Created by eony on 2016/12/30.
//  Copyright © 2016年 danis. All rights reserved.
//

#import "RainbowDragPop.h"
#import "RainbowPopAnimator.h"

@implementation RainbowDragPop


- (void)setCompletionSpeed:(CGFloat)completionSpeed {
    self.completionSpeed = completionSpeed;
}

- (CGFloat)completionSpeed {
    return MAX((CGFloat)0.5, 1 - self.percentComplete);
}

- (void)setNavigationController:(UINavigationController *)navigationController {
    _navigationController = navigationController;
    UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.edges = UIRectEdgeLeft;
    [navigationController.view addGestureRecognizer:panGesture];
}

- (void)handlePan:(UIScreenEdgePanGestureRecognizer *)panGesture {
    CGPoint offset = [panGesture translationInView:panGesture.view];
    //    let offset = panGesture.translation(in: panGesture.view)
    CGPoint velocity = [panGesture velocityInView:panGesture.view];
    //    let velocity = panGesture.velocity(in: panGesture.view)
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            if (self.popAnimator.animating == false) {
                self.interacting = true;
                if (velocity.x > 0 && self.navigationController.viewControllers.count > 0) {
                    [self.navigationController popViewControllerAnimated:true];
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (self.interacting) {
                CGFloat progress = offset.x / panGesture.view.bounds.size.width;
                progress = MAX(progress, 0);
                [self updateInteractiveTransition:progress];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            if (self.interacting) {
                if ([panGesture velocityInView:panGesture.view].x > 0) {
                    [self finishInteractiveTransition];
                } else {
                    [self cancelInteractiveTransition];
                }
                self.interacting = false;
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled: {
            if (self.interacting) {
                [self cancelInteractiveTransition];
                self.interacting = false;
            }
        }
            break;
        default:
            break;
    }
}

@end
