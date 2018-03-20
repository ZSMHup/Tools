//
//  HeaderView.m
//  Tools
//
//  Created by 张书孟 on 2018/3/13.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "HeaderView.h"
#import <Masonry/Masonry.h>

@implementation HeaderView


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSoubViews];
    }
    return self;
}

- (void)addSoubViews {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"1223456864563";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

@end
