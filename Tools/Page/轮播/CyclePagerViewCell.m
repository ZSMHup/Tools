//
//  CyclePagerViewCell.m
//  Tools
//
//  Created by 张书孟 on 2017/10/16.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "CyclePagerViewCell.h"

@interface CyclePagerViewCell ()

@property (nonatomic,weak) UIImageView *imgView;

@end

@implementation CyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addImgView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addImgView];
    }
    return self;
}


- (void)addImgView {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    _imgView = imgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imgView.frame = self.bounds;
}

@end
