//
//  NSString+StringUtils.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/17.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "NSString+StringUtils.h"

@implementation NSString (StringUtils)

- (NSString *)replaceSpaceOfHeadTail
{
    NSMutableString *string = [[NSMutableString alloc] init];
    [string setString:self];
    CFStringTrimWhitespace((CFMutableStringRef)string);
    return string;
}

- (NSString *)replaceUnicode
{
    NSStringEncoding strEncode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_2312_80);
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:strEncode];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}


- (NSString *)cacheDic
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [path stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)docDic
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [path stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)tmpDic
{
    NSString *path = NSTemporaryDirectory();
    
    return [path stringByAppendingPathComponent:self.lastPathComponent];
}

@end
