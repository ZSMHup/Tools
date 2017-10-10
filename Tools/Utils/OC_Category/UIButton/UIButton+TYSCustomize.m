//
//  UIButton+TYSCustomize.m
//  Touyanshe
//
//  Created by hsuyelin on 2017/5/10.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "UIButton+TYSCustomize.h"

@implementation UIButton (TYSCustomize)

- (void)buttonWithTitle:(NSString *)title
             titleColor:(UIColor *)titleColor
               fontName:(NSString *)fontName
               fontSize:(CGFloat)fontSize
              alignment:(NSTextAlignment)alignment
{
    if (title && title.length > 0) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    
    if (titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (fontName && fontName.length > 0 && fontSize && fontSize > 0) {
        self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    }
    
    if (!fontName && fontSize && fontSize > 0) {
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (alignment) {
        self.titleLabel.textAlignment = alignment;
    }
}

- (void)buttonWithBackgroundColor:(UIColor *)backgroundColor
                  backgroundImage:(UIImage *)backgroundImage
                   unSelectdImage:(UIImage *)unSelectedImage
                 highlightedImage:(UIImage *)highlightedImage
                     selectdImage:(UIImage *)selectdImage
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius

{
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    }
    
    if (backgroundImage) {
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    
    if (unSelectedImage) {
        [self setImage:unSelectedImage forState:UIControlStateNormal];
    }
    
    if (highlightedImage) {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    if (selectdImage) {
        [self setImage:selectdImage forState:UIControlStateSelected];
    }
    
    if (borderWidth && borderWidth > 0) {
        self.layer.borderWidth = borderWidth;
    }
    
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    
    if (cornerRadius && cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
    }
    
    
}

- (void)flatWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    if (cornerRadius && cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
    }
}

- (void)gradientButtonWithTitle:(NSString *)title
{
    [self gradientButtonWithTitle:title bounds:CGRectMake(0, 0, kScreenWidth - 60, AdaptH(50))];
}

- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds
{
    [self gradientButtonWithTitle:title bounds:bounds cornerRadius:2.0];
}

- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius
{
    [self setBackgroundImage:[UIImage gradientImageWithBounds:bounds colors:@[[UIColor colorWithHexString:@"#F42137"], [UIColor colorWithHexString:@"#FB5727"]] cornerRadius:cornerRadius gradientStyle:UIGradientStyleLeftToRight] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius font:(CGFloat)font {
    
    [self setBackgroundImage:[UIImage gradientImageWithBounds:bounds colors:@[[UIColor colorWithHexString:@"#F21D30"], [UIColor colorWithHexString:@"#FB4C23"]] cornerRadius:cornerRadius gradientStyle:UIGradientStyleLeftToRight] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:font];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius fontName:(NSString *)fontName font:(CGFloat)font colors:(NSArray *)colors {
    
    [self setBackgroundImage:[UIImage gradientImageWithBounds:bounds colors:colors cornerRadius:cornerRadius gradientStyle:UIGradientStyleLeftToRight] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:fontName size:font];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)gradientButtonWithImage:(NSString *)image bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius {
    [self setBackgroundImage:[UIImage gradientImageWithBounds:bounds colors:@[[UIColor colorWithHexString:@"#F21D30"], [UIColor colorWithHexString:@"#FB4C23"]] cornerRadius:cornerRadius gradientStyle:UIGradientStyleTopToBottom] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
}



- (void)buttonWithTitle:(NSString *)title
                  iamge:(NSString *)image
             titleColor:(UIColor *)titleColor
               fontName:(NSString *)fontName
               fontSize:(CGFloat)fontSize
              alignment:(NSTextAlignment)alignment
              addTarget:(id)addTarget
                 action:(SEL)action
                 events:(UIControlEvents)events {
    
    if (title && title.length > 0) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    
    if (image) {
        [self setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    }
    
    if (titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    if (fontName && fontName.length > 0 && fontSize && fontSize > 0) {
        self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    }
    
    if (!fontName && fontSize && fontSize > 0) {
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (alignment) {
        self.titleLabel.textAlignment = alignment;
    }
    if (addTarget) {
        [self addTarget:addTarget action:action forControlEvents:events];
    }

}

@end
