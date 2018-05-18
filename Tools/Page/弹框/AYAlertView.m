//
//  AYAlertView.m
//  Tools
//
//  Created by 张书孟 on 2018/5/18.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "AYAlertView.h"
#import <Masonry/Masonry.h>

#define kAlertScreenWidth [UIScreen mainScreen].bounds.size.width
#define kAlertScreenHeight [UIScreen mainScreen].bounds.size.height
#define kAlertKeyWindow [UIApplication sharedApplication].keyWindow

@interface AYAlertView ()

@property (nonatomic, copy) void(^AlertClickBlock)(NSInteger index);

/** 遮罩 */
@property (nonatomic, strong) UIView *maskView;
/** 内容 */
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *leftBtnTitle;
@property (nonatomic, copy) NSString *rightBtnTitle;
// font
@property (nonatomic, copy) UIFont *titleFont;
@property (nonatomic, copy) UIFont *contentFont;
@property (nonatomic, copy) UIFont *leftBtnTitleFont;
@property (nonatomic, copy) UIFont *rightBtnTitleFont;
// color
@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) UIColor *contentLabelColor;
@property (nonatomic, copy) UIColor *leftBtnTitleColor;
@property (nonatomic, copy) UIColor *rightBtnTitleColor;
@property (nonatomic, copy) UIColor *maskViewColor;
@property (nonatomic, copy) UIColor *contentBgColor;
@property (nonatomic, copy) UIColor *leftBtnBgColor;
@property (nonatomic, copy) UIColor *rightBtnBgColor;


@end

@implementation AYAlertView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kAlertScreenWidth, kAlertScreenHeight)];
    if (self) {
        [self addBaseSubViews];
    }
    return self;
}

#pragma mark - public
+ (void)showWithTitle:(NSString *)title
{
    AYAlertView *alertView = [[AYAlertView alloc] init];
    
    [kAlertKeyWindow addSubview:alertView];
}




#pragma mark - event response
- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}

#pragma mark - private

- (void)baseConfig
{
    self.maskViewColor = [UIColor colorWithRed:46 / 255.0 green:49 / 255.0 blue:50 / 255.0 alpha:0.3];
    self.contentBgColor = [UIColor whiteColor];
}

- (void)addBaseSubViews
{
    [self baseConfig];
    [self addMaskView];
    [self addContentView];
    [self addTopView];
    [self addBottomView];
    [self addTitleLabel];
    [self addContentLabel];
}

- (void)addMaskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertScreenWidth, kAlertScreenHeight)];
        _maskView.backgroundColor = self.maskViewColor;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [_maskView addGestureRecognizer:tapGesture];
        [self addSubview:_maskView];
    }
}

- (void)addContentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = self.contentBgColor;
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(kAlertScreenWidth - 150);
            make.height.mas_equalTo(200);
        }];
    }
}

- (void)addTopView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor redColor];
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_contentView);
            make.bottom.equalTo(_contentView.mas_bottom).offset(-50);
        }];
    }
}

- (void)addBottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor blueColor];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_contentView);
            make.height.mas_equalTo(50);
        }];
    }
}



- (void)addTitleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"titletitle";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_topView).offset(5);
            make.right.equalTo(_topView).offset(-5);
        }];
    }
}

- (void)addContentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"_contentLabel_contentLabel_contentLabel_contentLabel_contentLabel";
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView).offset(5);
            make.top.equalTo(_titleLabel).offset(5);
            make.right.equalTo(_topView).offset(-5);
        }];
    }
}

- (void)addLeftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 50, self.contentView.frame.size.width / 2, 50)];
        [_leftBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_leftBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_leftBtn addTarget:self action:@selector(canaelClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_leftBtn];
    }
}

- (void)addRightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height - 50, self.contentView.frame.size.width / 2, 50)];
        [_rightBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _rightBtn.backgroundColor = [UIColor redColor];
        [_rightBtn addTarget:self action:@selector(ensureClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_rightBtn];
    }
}

@end
