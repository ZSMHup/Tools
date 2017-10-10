//
//  NSString+URLEncode.h
//  Touyanshe
//
//  Created by hsuyelin on 2017/5/9.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)

+ (NSString *)URLEncodeString:(NSString *)unencodedString;
+ (NSString *)URLDecodeString:(NSString*)encodedString;

@end
