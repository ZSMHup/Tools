//
//  UIScrollView+Extension.m
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

+ (void)load {
    if (@available(iOS 11.0, *)) {
        [[self appearance] setContentInsetAdjustmentBehavior:(UIScrollViewContentInsetAdjustmentNever)];
    }
}

@end
