//
//  NSString+AttributedTools.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/24.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributedTools)

/**
 设置富文本样式
 
 @param lineSpacing 行高
 @param textcolor 字体颜色
 @param font 字体
 @return 富文本样式
 */
- (NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing firstLineHeadIndent:(CGFloat)firstLineHeadIndent textColor:(UIColor *)textcolor textFont:(UIFont *)font;

/**
 计算富文本高度
 
 @param lineSpeace 行高
 @param font 字体
 @param width 宽度
 @return 副文本高度
 */
- (CGFloat)heightParagraphSpeace:(CGFloat)lineSpeace font:(UIFont*)font width:(CGFloat)width;

@end
