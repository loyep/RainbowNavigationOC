//
//  UINavigationBar+Rainbow.h
//  RainbowNavigationSample
//
//  Created by eony on 2016/12/30.
//  Copyright © 2016年 danis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Rainbow)

@property (nonatomic, strong) UIColor *dfStatusBarMaskColor;

@property (nonatomic, strong) UIColor *dfBackgroundColor;

- (void)df_reset;

@end
