//
//  UIImage+Category.m
//  Tools
//
//  Created by 张书孟 on 2018/5/24.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "UIImage+Category.h"
#import <objc/runtime.h>

@implementation UIImage (Category)

+ (UIImage *)ay_imageNamed:(NSString *)imageName {
    
    return [UIImage ay_imageNamed:imageName];
}

+ (void)load {
    Method m1 = class_getClassMethod([self class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([self class], @selector(ay_imageNamed:));
    method_exchangeImplementations(m1, m2);
}
    
@end
