//
//  UIButton+Layout.m
//  Touyanshe
//
//  Created by hsuyelin on 2017/6/2.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "UIButton+Layout.h"
#import <objc/runtime.h>

@implementation UIButton (Layout)

#pragma mark - add association
static const char *titleRectKey = "AY_titleRectKey";
- (CGRect)titleRect
{
    return [objc_getAssociatedObject(self, titleRectKey) CGRectValue];
}

- (void)setTitleRect:(CGRect)rect
{
    objc_setAssociatedObject(self, titleRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

static const char *imageRectKey = "AY_imageRectKey";
- (CGRect)imageRect
{
    NSValue *rectValue = objc_getAssociatedObject(self, imageRectKey);
    return [rectValue CGRectValue];
}

- (void)setImageRect:(CGRect)rect
{
    objc_setAssociatedObject(self, imageRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - replace method
+ (void)load
{
    
    MethodSwizzle(self, @selector(titleRectForContentRect:), @selector(override_titleRectForContentRect:));
    MethodSwizzle(self, @selector(imageRectForContentRect:), @selector(override_imageRectForContentRect:));
}

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod = class_getInstanceMethod(c, overrideSEL);
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(c, overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

- (CGRect)override_titleRectForContentRect:(CGRect)contentRect
{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    
    return [self override_titleRectForContentRect:contentRect];
}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect
{
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    
    return [self override_imageRectForContentRect:contentRect];
}

@end
