//
//  UIButton+Alignment.m
//  LCUIKitExample
//
//  Created by 张书孟 on 2017/10/10.
//  Copyright © 2017年 jiangliancheng. All rights reserved.
//

#import "UIButton+Alignment.h"

@implementation UIButton (Alignment)

- (void)titleImageHorizontalAlignmentWithSpace:(float)space;
{
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width+space, 0, -titleSize.width - space)];
}

- (void)imageTitleHorizontalAlignmentWithSpace:(float)space;
{
    [self resetEdgeInsets];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, space, 0, -space)];
    [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, space)];
}

- (void)titleImageVerticalAlignmentWithSpace:(float)space;
{
    [self verticalAlignmentWithTitleTop:YES space:space];
}

- (void)imageTitleVerticalAlignmentWithSpace:(float)space;
{
    [self verticalAlignmentWithTitleTop:NO space:space];
}

- (void)verticalAlignmentWithTitleTop:(BOOL)isTop space:(float)space ;
{
    [self resetEdgeInsets];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    float halfWidth = (titleSize.width + imageSize.width)/2;
    float halfHeight = (titleSize.height + imageSize.height)/2;
    
    float topInset = MIN(halfHeight, titleSize.height);
    float leftInset = (titleSize.width - imageSize.width)>0?(titleSize.width - imageSize.width)/2:0;
    float bottomInset = (titleSize.height - imageSize.height)>0?(titleSize.height - imageSize.height)/2:0;
    float rightInset = MIN(halfWidth, titleSize.width);
    
    if (isTop) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(-halfHeight-space, - halfWidth, halfHeight+space, halfWidth)];
        [self setContentEdgeInsets:UIEdgeInsetsMake(topInset+space, leftInset, -bottomInset, -rightInset)];
    } else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(halfHeight+space, - halfWidth, -halfHeight-space, halfWidth)];
        [self setContentEdgeInsets:UIEdgeInsetsMake(-bottomInset, leftInset, topInset+space, -rightInset)];
    }
}

- (void)resetEdgeInsets
{
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];
}

@end
