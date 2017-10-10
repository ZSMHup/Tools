//
//  UILabel+TYSCustomize.m
//  Touyanshe
//
//  Created by hsuyelin on 2017/5/10.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "UILabel+TYSCustomize.h"

@implementation UILabel (TYSCustomize)

- (void)LabelWithBackgroundColor:(UIColor *)backgroudColor
                       textColor:(UIColor *)textColor
                            text:(NSString *)text
                        fontName:(NSString *)fontName
                        fontSize:(CGFloat)fontSize
                   textAlignment:(NSTextAlignment)textAlignment
                    cornerRadius:(CGFloat)cornerRadius
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor
{
    if (backgroudColor) {
        self.backgroundColor = backgroudColor;
    }
    
    if (textColor) {
        self.textColor = textColor;
    } else{
        self.textColor = [UIColor blackColor];
    }
    
    if (text && text.length > 0) {
        self.text = text;
    }
    
    if (fontName && fontName.length > 0 && fontSize && fontSize > 0) {
        self.font = [UIFont fontWithName:fontName size:fontSize];
    }
    
    if (!fontName && fontSize && fontSize > 0) {
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if(!fontName && !fontSize)
    {
        self.font = [UIFont systemFontOfSize:15.0];
    }
    
    if (textAlignment) {
        self.textAlignment = textAlignment;
    }
    
    if (cornerRadius) {
        self.layer.cornerRadius = cornerRadius;
    }
    
    if (borderWidth && borderColor) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.CGColor;
    }
    
    [self adjustsFontSizeToFitWidth];
}

- (void)LabelWithTextColor:(UIColor *)textColor
                      text:(NSString *)text
                  fontName:(NSString *)fontName
                  fontSize:(CGFloat)fontSize
             textAlignment:(NSTextAlignment)textAlignment
{
    if (textColor) {
        self.textColor = textColor;
    } else{
        self.textColor = [UIColor blackColor];
    }
    
    if (text && text.length > 0) {
        self.text = text;
    }
    
    if (fontName && fontName.length > 0 && fontSize && fontSize > 0) {
        self.font = [UIFont fontWithName:fontName size:fontSize];
    }
    
    if (!fontName && fontSize && fontSize > 0) {
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if(!fontName && !fontSize)
    {
        self.font = [UIFont systemFontOfSize:15.0];
    }
    
    if (textAlignment) {
        self.textAlignment = textAlignment;
    }
    
    [self adjustsFontSizeToFitWidth];

}

@end
