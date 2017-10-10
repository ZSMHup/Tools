//
//  UIButton+Alignment.h
//  LCUIKitExample
//
//  Created by 张书孟 on 2017/10/10.
//  Copyright © 2017年 jiangliancheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Alignment)

/**
 左文右图
 @param space 图片和文字间距
 */
- (void)titleImageHorizontalAlignmentWithSpace:(float)space;
/**
 左图右文
 @param space 图片和文字间距
 */
- (void)imageTitleHorizontalAlignmentWithSpace:(float)space;
/**
 上文下图
 @param space 图片和文字间距
 */
- (void)titleImageVerticalAlignmentWithSpace:(float)space;
/**
 上图下文
 @param space 图片和文字间距
 */
- (void)imageTitleVerticalAlignmentWithSpace:(float)space;

@end
