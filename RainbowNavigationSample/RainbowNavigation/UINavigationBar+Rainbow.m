//
//  UINavigationBar+Rainbow.m
//  RainbowNavigationSample
//
//  Created by eony on 2016/12/30.
//  Copyright © 2016年 danis. All rights reserved.
//

#import "UINavigationBar+Rainbow.h"
#import <objc/runtime.h>

NSString *const kBackgroundViewKey = @"kBackgroundViewKey";
NSString *const kStatusBarMaskKey = @"kStatusBarMaskKey";

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *statusBarMask;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation UINavigationBar (Rainbow)

- (void)df_setStatusBarMaskColor:(UIColor *)color {
    if (self.statusBarMask == nil) {
        CGFloat statusHeight = [UIApplication sharedApplication].statusBarHidden ? 0 : [UIApplication sharedApplication].statusBarFrame.size.height;
        self.statusBarMask = [[UIView alloc] initWithFrame:CGRectMake(0, -statusHeight, [UIScreen mainScreen].bounds.size.width, statusHeight)];
        self.statusBarMask.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIView *tempBackgroundView = self.backgroundView;
        if (tempBackgroundView) {
            [self insertSubview:self.statusBarMask aboveSubview:tempBackgroundView];
        } else {
            [self insertSubview:self.statusBarMask atIndex:0];
        }
    }
    self.statusBarMask.backgroundColor = color;
}

- (void)df_setBackgroundColor:(UIColor *)color {
    if (nil == self.backgroundView) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
        self.shadowImage = [[UIImage alloc] init];
        CGFloat statusHeight = [UIApplication sharedApplication].statusBarHidden ? 0 : [UIApplication sharedApplication].statusBarFrame.size.height;
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusHeight, [UIScreen mainScreen].bounds.size.width, statusHeight + self.frame.size.height)];
        self.backgroundView.userInteractionEnabled = false;
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)df_reset {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &kBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kBackgroundViewKey);
}

- (void)setStatusBarMask:(UIView *)statusBarMask {
    objc_setAssociatedObject(self, &kStatusBarMaskKey, statusBarMask, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)statusBarMask {
    return (UIView *)objc_getAssociatedObject(self, &kStatusBarMaskKey);
}

@end
