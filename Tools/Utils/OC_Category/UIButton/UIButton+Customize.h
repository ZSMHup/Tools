//
//  UIButton+Customize.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/11.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Customize)

/**
 设置扁平化按钮, 边框颜色固定，字体默认为16，居中显示，弧度为2.0
 
 @param title 按钮文字
 */
- (void)flatButtonWithTitle:(NSString *)title;

/**
 设置渐变色按钮，渐变色固定，字体默认为16.0，居中显示, 弧度2.0
 
 @param title 按钮文字
 */
- (void)gradientButtonWithTitle:(NSString *)title;

/**
 设置深颜色按钮，字体默认为16.0，居中显示，弧度为2.0

 @param title 按钮文字
 */
- (void)darkButtonWithTitle:(NSString *)title;

@end
