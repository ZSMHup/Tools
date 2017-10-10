//
//  NSObject+Utils.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/11.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utils)

/**
 计算出文本的尺寸

 @param string 文本内容
 @param fontSize 文本字体大小
 @return 文本尺寸
 */
+ (CGSize)sizeForString:(NSString *)string fontSize:(CGFloat)fontSize;

/**
 计算出文本的宽度

 @param string 文本内容
 @param fontSize 文本字体大小
 @return 文本宽度
 */
+ (CGFloat)widthForString:(NSString *)string fontSize:(CGFloat)fontSize;

/**
 计算出文本的高度

 @param string 文本内容
 @param fontSize 文本字体大小
 @return 文本高度
 */
+ (CGFloat)heightForString:(NSString *)string fontSize:(CGFloat)fontSize;

@end
