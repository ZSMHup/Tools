//
//  UILabel+TYSCustomize.h
//  Touyanshe
//
//  Created by hsuyelin on 2017/5/10.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (TYSCustomize)


/**
 快速设置label属性

 @param backgroudColor 背景颜色，没有设默认为白色
 @param textColor 字体颜色，没有默认为黑色
 @param text 内容
 @param fontName 字体名称，没有默认为系统字体
 @param fontSize 字体大小, 没有默认为15.0
 @param textAlignment 对齐方式
 @param cornerRadius 圆角弧度
 @param borderWidth 边界宽度
 @param borderColor 边界颜色
 */
- (void)LabelWithBackgroundColor:(UIColor *)backgroudColor
                       textColor:(UIColor *)textColor
                            text:(NSString *)text
                        fontName:(NSString *)fontName
                        fontSize:(CGFloat)fontSize
                   textAlignment:(NSTextAlignment)textAlignment
                    cornerRadius:(CGFloat)cornerRadius
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;


/**
 快速设置label内容属性

 @param textColor 字体颜色
 @param text 字体内容
 @param fontName 字体名称
 @param fontSize 字体大小
 @param textAlignment 对齐方式
 */
- (void)LabelWithTextColor:(UIColor *)textColor
                            text:(NSString *)text
                        fontName:(NSString *)fontName
                        fontSize:(CGFloat)fontSize
             textAlignment:(NSTextAlignment)textAlignment;



@end
