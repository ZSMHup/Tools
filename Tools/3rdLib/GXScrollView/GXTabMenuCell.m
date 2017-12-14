//
//  GXTabMenuCell.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXTabMenuCell.h"

#import "GXConfigConst.h"

#import <Masonry/Masonry.h>

@interface GXTabMenuCell ()

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *badgeImageView;

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

- (void)gx_addSubviews
{
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.userInteractionEnabled = NO;
    
    _badgeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_badge"]];
    _badgeImageView.hidden = YES;
    [_titleButton addSubview:_badgeImageView];
    [_badgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleButton.titleLabel.mas_right);
        make.bottom.equalTo(_titleButton.titleLabel.mas_top);
    }];
    
    _titleButton.titleLabel.font = gx_kTabMenuTitleFont;
    [_titleButton setTitleColor:gx_kTabMenuTitleNormalColor forState:UIControlStateNormal];
    [_titleButton setTitleColor:gx_kTabMenuTitleSelectedColor forState:UIControlStateSelected];
    [self.contentView addSubview:_titleButton];
}

- (void)setTabMenuTitleNormalColor:(UIColor *)tabMenuTitleNormalColor
{
    [_titleButton setTitleColor:tabMenuTitleNormalColor forState:UIControlStateNormal];
}

- (void)setTabMenuTitleSelectedColor:(UIColor *)tabMenuTitleSelectedColor
{
    [_titleButton setTitleColor:tabMenuTitleSelectedColor forState:UIControlStateSelected];
}

- (void)setLineHidden:(BOOL)lineHidden
{
    if (!lineHidden) {
        CALayer *vLine = [[CALayer alloc] init];
        vLine.frame = CGRectMake(-0.5, 12, 0.5, gx_kTabMenuHeight - 24);
        vLine.backgroundColor = [UIColor grayColor].CGColor;
        [self.contentView.layer addSublayer:vLine];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleButton setTitle:title forState:UIControlStateNormal];
}

- (void)setChecked:(BOOL)checked
{
    _titleButton.selected = checked;
}

- (void)setShowBadge:(BOOL)showBadge
{
    _showBadge = showBadge;
    _badgeImageView.hidden = !showBadge;
}

@end
