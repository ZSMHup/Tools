//
//  UIButton+Customize.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/11.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "UIButton+Customize.h"
#import "UIImage+ImageUtils.h"

@implementation UIButton (Customize)

#pragma mark - public
- (void)flatButtonWithTitle:(NSString *)title
{
    [self flatWithTitle:title borderColor:ColorFromHex(@"#ED5720") borderWidth:1.0 cornerRadius:2.0];
}

- (void)gradientButtonWithTitle:(NSString *)title
{
    [self gradientButtonWithTitle:title bounds:CGRectMake(0.f, 0.f, kScreenWidth - 60, AdaptH(50))];
}

- (void)darkButtonWithTitle:(NSString *)title
{
    [self darkButtonWithTitle:title bounds:CGRectMake(0.f, 0.f, kScreenWidth - 60, AdaptH(50))];
}


#pragma mark - private
- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds
{
    [self gradientButtonWithTitle:title bounds:bounds cornerRadius:2.0];
}

- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius
{
    [self setBackgroundImage:[UIImage gradientImageWithBounds:bounds colors:@[[UIColor colorWithHexString:@"#F42137"], [UIColor colorWithHexString:@"#FB5727"]] cornerRadius:cornerRadius gradientStyle:UIGradientStyleLeftToRight] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)darkButtonWithTitle:(NSString *)title bounds:(CGRect)bounds
{
    [self darkButtonWithTitle:title bounds:bounds cornerRadius:2.0];
}

- (void)darkButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius
{
    [self setBackgroundImage:[[UIImage imageWithColor:TYSNavColor] imageAddCornerWithRadius:cornerRadius andSize:bounds.size] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)flatWithTitle:(NSString *)title borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.backgroundColor = [UIColor whiteColor];
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:ColorFromHex(@"#ED5720") forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
