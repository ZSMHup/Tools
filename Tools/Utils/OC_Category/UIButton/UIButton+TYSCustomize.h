//
//  UIButton+TYSCustomize.h
//  Touyanshe
//
//  Created by hsuyelin on 2017/5/10.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TYSCustomize)

/**
 快速设置按钮内容属性

 @param title 按钮内容
 @param titleColor 按钮内容颜色
 @param fontName 按钮内容字体名称
 @param fontSize 按钮内容字体大小
 @param alignment 按钮内容对齐方式
 */
- (void)buttonWithTitle:(NSString *)title
             titleColor:(UIColor *)titleColor
               fontName:(NSString *)fontName
               fontSize:(CGFloat)fontSize
              alignment:(NSTextAlignment)alignment;


/**
 快速设置按钮基本属性

 @param backgroundColor 背景颜色
 @param backgroundImage 背景图片
 @param unSelectedImage 未选中时的图片
 @param highlightedImage 高亮时的图片
 @param selectdImage 选中时的图片
 @param borderWidth 边界宽度
 @param borderColor 边界颜色
 @param cornerRadius 边界弧度
 */
- (void)buttonWithBackgroundColor:(UIColor *)backgroundColor
                  backgroundImage:(UIImage *)backgroundImage
                   unSelectdImage:(UIImage *)unSelectedImage
                 highlightedImage:(UIImage *)highlightedImage
                     selectdImage:(UIImage *)selectdImage
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius;


/**
 设置扁平化按钮
 
 @param borderColor 边界颜色
 @param borderWidth 边界宽度
@param cornerRadius 圆角弧度
 */
- (void)flatWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

/**
 设置渐变色按钮，渐变色固定，字体默认为16.0，居中显示, 弧度2.0
 
 @param title 按钮文字
 */
- (void)gradientButtonWithTitle:(NSString *)title;

/**
 设置渐变色按钮，渐变色固定，字体默认为16.0，居中显示, 弧度2.0

 @param title 按钮文字
 @param bounds 按钮的bounds
 */
- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds;

/**
 设置渐变色按钮，渐变色固定，字体默认为16.0，居中显示

 @param title 按钮文字
 @param bounds 按钮bounds
 @param cornerRadius 按钮圆角弧度
 */
- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius;

/**
 设置渐变色按钮，渐变色固定，，居中显示
 
 @param image 按钮图片
 @param bounds 按钮bounds
 @param cornerRadius 按钮圆角弧度
 */
- (void)gradientButtonWithImage:(NSString *)image bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius;

/**
 设置渐变色按钮，渐变色固定，，居中显示
 
 @param title 按钮文字
 @param bounds 按钮bounds
 @param cornerRadius 按钮圆角弧度
 @param font 按钮字体大小
 */
- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius font:(CGFloat)font;

/**
 设置渐变色按钮，居中显示
 
 @param title 按钮文字
 @param bounds 按钮bounds
 @param cornerRadius 按钮圆角弧度
 @param fontName 按钮字体名字
 @param font 按钮字体大小
 @param colors 按钮背景渐变颜色数组
 */
- (void)gradientButtonWithTitle:(NSString *)title bounds:(CGRect)bounds cornerRadius:(CGFloat)cornerRadius fontName:(NSString *)fontName font:(CGFloat)font colors:(NSArray *)colors;
/**
 快速设置按钮内容属性
 
 @param title 按钮内容
 @param image 按钮图片
 @param titleColor 按钮内容颜色
 @param fontName 按钮内容字体名称
 @param fontSize 按钮内容字体大小
 @param alignment 按钮内容对齐方式
 */
- (void)buttonWithTitle:(NSString *)title
                  iamge:(NSString *)image
             titleColor:(UIColor *)titleColor
               fontName:(NSString *)fontName
               fontSize:(CGFloat)fontSize
              alignment:(NSTextAlignment)alignment
              addTarget:(id)addTarget
                 action:(SEL)action
                 events:(UIControlEvents)events;



@end
