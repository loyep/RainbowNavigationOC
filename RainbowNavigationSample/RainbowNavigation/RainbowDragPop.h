//
//  RainbowDragPop.h
//  RainbowNavigationSample
//
//  Created by eony on 2016/12/30.
//  Copyright © 2016年 danis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RainbowPopAnimator.h"

@interface RainbowDragPop : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign) BOOL interacting;

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, assign) CGFloat completionSpeed;
@property (nonatomic, assign) RainbowPopAnimator *popAnimator;



@end
