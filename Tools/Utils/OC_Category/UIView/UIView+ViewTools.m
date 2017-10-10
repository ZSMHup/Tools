//
//  UIView+ViewTools.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/25.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "UIView+ViewTools.h"

@implementation UIView (ViewTools)

#pragma mark - public
- (void)dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity
{
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
}

@end
