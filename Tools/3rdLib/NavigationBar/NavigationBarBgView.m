//
//  NavigationBarBgView.m
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "NavigationBarBgView.h"

#define kNavigationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.f)
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface NavigationBarBgView ()

@end

@implementation NavigationBarBgView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavigationBarHeight)];
    navView.backgroundColor = self.bgColor ? : [UIColor orangeColor];
    [self addSubview:navView];
}



@end
