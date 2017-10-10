//
//  NSString+URLEncode.m
//  Touyanshe
//
//  Created by hsuyelin on 2017/5/9.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)
+ (NSString *)URLEncodeString:(NSString *)unencodedString
{
    return  [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
}

+ (NSString *)URLDecodeString:(NSString*)encodedString;
{
    return  [encodedString stringByRemovingPercentEncoding];
}

    
@end
