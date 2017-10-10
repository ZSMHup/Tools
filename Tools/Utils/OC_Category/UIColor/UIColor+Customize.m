//
//  UIColor+Customize.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/11.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "UIColor+Customize.h"

@implementation UIColor (Customize)

+ (UIColor *)blackColorWithAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:alpha];
}

+ (UIColor *)whiteColorWithAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:alpha];
}

+ (UIColor *)tys_globalColor
{
    return [UIColor colorWithHexString:@"#D31516"];
}
+ (UIColor *)tys_lineColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
}

+ (UIColor *)tys_lightTextColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

+ (UIColor *)tys_darkTextColor
{
    return [UIColor colorWithHexString:@"#000000"];
}

+ (UIColor *)tys_lightGrayColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

+ (UIColor *)tys_borderColor
{
    return [UIColor colorWithHexString:@"#979797"];
}

@end
