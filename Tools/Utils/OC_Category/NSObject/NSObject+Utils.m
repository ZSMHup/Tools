//
//  NSObject+Utils.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/11.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "NSObject+Utils.h"
#import <math.h>

@implementation NSObject (Utils)

+ (CGSize)sizeForString:(NSString *)string fontSize:(CGFloat)fontSize
{
    if (IOS8_OR_LATER) {
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:style};
        CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenWidth, CGFLOAT_MAX) options:opts attributes:attributes context:nil];
        return rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        return [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(kScreenWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
}

+ (CGFloat)widthForString:(NSString *)string fontSize:(CGFloat)fontSize
{
    return ceil([self sizeForString:string fontSize:fontSize].width);
}

+ (CGFloat)heightForString:(NSString *)string fontSize:(CGFloat)fontSize
{
    return ceil([self sizeForString:string fontSize:fontSize].height);
}

@end
