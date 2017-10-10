//
//  NSString+TimeDifference.h
//  Touyanshe
//
//  Created by 张书孟 on 2017/7/27.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeDifference)

/**
 时间差计算

 @param startTime 开始时间
 @param endTime 结束时间（一般为当前时间）
 @return 返回结果
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

+ (NSString *)dateDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

@end
