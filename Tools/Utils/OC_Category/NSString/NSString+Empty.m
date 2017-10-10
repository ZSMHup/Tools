//
//  NSString+Empty.m
//  Touyanshe
//
//  Created by 高翔 on 2017/7/25.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

- (BOOL)tys_isEmpty
{
    if (!self) {
        return YES;
    }
    else {
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        }
        else {
            return NO;
        }
    }
}

@end
