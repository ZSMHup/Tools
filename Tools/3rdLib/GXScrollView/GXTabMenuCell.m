//
//  GXTabMenuCell.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXTabMenuCell.h"

@implementation GXTabMenuModel

@end

const CGFloat GXTabMenuUnderlineHeight = 2.f;
const CGFloat GXTabMenuBackgroundDefaultHeight = 3.f;

@interface GXTabMenuCell ()

@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) CALayer *underline;

@end

@implementation GXTabMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self gx_addSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleButton.frame = self.contentView.bounds;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (_model.deselectDisabled) {
        return;
    }

    _titleButton.selected = selected;

    _backgroundLayer.frame = selected ? self.contentView.bounds : CGRectMake(0, 0, CGRectGetWidth(self.bounds), GXTabMenuBackgroundDefaultHeight);

    CGFloat pointX = selected ? 0 : self.contentView.center.x;
    CGFloat width = selected ? CGRectGetWidth(self.contentView.bounds) : 0.f;
    _underline.frame = CGRectMake(pointX, CGRectGetHeight(self.bounds) - GXTabMenuUnderlineHeight, width, GXTabMenuUnderlineHeight);
}

- (void)gx_addSubviews
{
    _backgroundLayer = [[CALayer alloc] init];
    _backgroundLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), GXTabMenuBackgroundDefaultHeight);
    _backgroundLayer.backgroundColor = [UIColor cyanColor].CGColor;
    [self.contentView.layer addSublayer:_backgroundLayer];

    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.userInteractionEnabled = NO;
    _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.contentView addSubview:_titleButton];

    _underline = [[CALayer alloc] init];
    _underline.frame = CGRectMake(self.contentView.center.x, CGRectGetHeight(self.contentView.bounds) - GXTabMenuUnderlineHeight, 0, GXTabMenuUnderlineHeight);
    _underline.backgroundColor = [UIColor blueColor].CGColor;
    [self.contentView.layer addSublayer:_underline];
}

- (void)setModel:(GXTabMenuModel *)model
{
    _model = model;

    [_titleButton setTitle:model.title forState:UIControlStateNormal];
    [_titleButton setTitleColor:model.titleNormalColor ?: [UIColor blackColor] forState:UIControlStateNormal];
    [_titleButton setTitleColor:model.titleSelectedColor ?: [UIColor blueColor] forState:UIControlStateSelected];
    _backgroundLayer.backgroundColor = model.backgroundLayerColor.CGColor;
    _underline.backgroundColor = model.underlineColor.CGColor;
}

@end

