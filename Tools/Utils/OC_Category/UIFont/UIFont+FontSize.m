//
//  UIFont+FontSize.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/6.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "UIFont+FontSize.h"
#import <objc/message.h>

@implementation UIFont (FontSize)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originalM  = class_getClassMethod(self, @selector(systemFontOfSize:));
        Method exchangeM  = class_getClassMethod(self, @selector(tys_systemFontOfSize:));
        
        method_exchangeImplementations(originalM, exchangeM);
        
    });
}

+ (nullable UIFont *)tys_systemFontOfSize:(CGFloat)fontSize
{
    if (IS_IPHONE_5) {
        return [UIFont tys_systemFontOfSize:fontSize / 1.2];
    } else{
        return [UIFont tys_systemFontOfSize:fontSize];
    }
}

@end
