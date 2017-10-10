//
//  NSString+TimeDifference.m
//  Touyanshe
//
//  Created by 张书孟 on 2017/7/27.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "NSString+TimeDifference.h"

@implementation NSString (TimeDifference)

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:startTime];
    NSDate *date2 = [formatter dateFromString:endTime];
    // 3.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 4.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    NSString *str;
    if (cmps.year != 0) {
        str = [startTime substringWithRange:NSMakeRange(0, 16)];
    } else if (cmps.month != 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld月前",cmps.month];
    } else if (cmps.day != 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld天前",cmps.day];
    } else if (cmps.hour != 0 && cmps.day == 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld小时前",cmps.hour];
    } else if (cmps.minute != 0 && cmps.hour == 0 && cmps.day == 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
    } else if (cmps.second != 0 && cmps.minute == 0 && cmps.hour == 0 && cmps.day == 0 && cmps.month == 0 && cmps.year == 0) {
        str = @"刚刚";
    }
    return str;
}

+ (NSString *)dateDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:startTime];
    NSDate *date2 = [formatter dateFromString:endTime];
    // 3.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 4.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    NSString *str;
    if (cmps.year != 0) {
        str = [startTime substringWithRange:NSMakeRange(0, 16)];
    } else if (cmps.month != 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld月前",cmps.month];
    } else if (cmps.day != 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld天前",cmps.day];
    } else if (cmps.hour != 0 && cmps.day == 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"%ld:%ld:%ld",cmps.hour,cmps.minute,cmps.second];
    } else if (cmps.minute != 0 && cmps.hour == 0 && cmps.day == 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"00:%ld:%ld",cmps.minute,cmps.second];
    } else if (cmps.second != 0 && cmps.minute == 0 && cmps.hour == 0 && cmps.day == 0 && cmps.month == 0 && cmps.year == 0) {
        str = [NSString stringWithFormat:@"00:00:%ld",cmps.second];
    }
    return str;
}

@end
