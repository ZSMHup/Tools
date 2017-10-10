//
//  NSString+AttributedTools.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/24.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "NSString+AttributedTools.h"

@implementation NSString (AttributedTools)

- (NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing firstLineHeadIndent:(CGFloat)firstLineHeadIndent textColor:(UIColor *)textcolor textFont:(UIFont *)font
{
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0.0f};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    NSDictionary *attriBute = @{NSForegroundColorAttributeName:textcolor, NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    return attriStr;
}

- (CGFloat)heightParagraphSpeace:(CGFloat)lineSpeace font:(UIFont*)font width:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
