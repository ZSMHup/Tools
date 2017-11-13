//
//  NetworkRequestModel.m
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestModel.h"

@implementation NetworkRequestModel
- (BOOL)success
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", self.statusCode];
    return [statusCode isEqualToString:@"00000"] || [statusCode isEqualToString:@"1"];
}

- (NSString *)responseMessage
{
    return self.msg;
}

@end

@implementation PageModel

@end
