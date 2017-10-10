//
//  NSString+StringUtils.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/17.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringUtils)

/**
 *  去掉首尾空字符串
 */
- (NSString *)replaceSpaceOfHeadTail;
- (NSString *)replaceUnicode;

/**
 获取缓存路径
 
 @return 将当前字符串拼接到cache目录后面
 */
- (NSString *)cacheDic;

/**
 获取document路径
 
 @return 将当前字符串拼接到document目录后面
 */
- (NSString *)docDic;

/**
 获取tmp路径
 
 @return 将当前字符串拼接到tmp目录后面
 */
- (NSString *)tmpDic;

@end
