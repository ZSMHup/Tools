//
//  AlertView.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "AlertView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kKeyWindow [UIApplication sharedApplication].keyWindow

@interface AlertView ()

@property (nonatomic, copy) void(^btnClickBlock)(NSInteger index);

////showAlertView begin
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
////showAlertView end

////show begin
@property (nonatomic, strong) UIImageView *stateImg;
@property (nonatomic, strong) UILabel *label;
////show end

////show begin
////show end

////show begin
////show end


@end

@implementation AlertView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self addShowAlertView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        
    }
    return self;
}

- (void)addShowAlertView {
    [self addBgView];
    [self addContentView];
    [self addContentLabel];
    [self addLeftBtn];
    [self addRightBtn];
}

+ (void)showAlertViewWithTitle:(NSString *)title block:(void(^)(NSInteger index))block {
    AlertView *alV = [[AlertView alloc] init];
    alV.btnClickBlock = block;
    alV.contentLabel.text = title;
    alV.contentView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.25 animations:^{
        alV.contentView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        alV.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    [kKeyWindow addSubview:alV];
}


- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0;
        self.contentView.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)canaelClick:(UIButton *)sender {
    self.btnClickBlock(0);
    [self hide];
}

- (void)ensureClick:(UIButton *)sender {
    self.btnClickBlock(1);
    [self hide];
}


- (void)addBgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView.backgroundColor = [UIColor colorWithRed:46/255.0 green:49/255.0 blue:50 / 255.0 alpha:0.3];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [_bgView addGestureRecognizer:tapGesture];
        [self addSubview:_bgView];
    }
}

- (void)addContentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 150, kScreenHeight/2 - 100, 300, 200)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
    }
}

- (void)addContentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 50)];
        _contentLabel.text = @"123";
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_contentLabel];
    }
}

- (void)addLeftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 50, self.contentView.frame.size.width / 2, 50)];
        [_leftBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_leftBtn addTarget:self action:@selector(canaelClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_leftBtn];
    }
}

- (void)addRightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height - 50, self.contentView.frame.size.width / 2, 50)];
        [_rightBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _rightBtn.backgroundColor = [UIColor redColor];
        [_rightBtn addTarget:self action:@selector(ensureClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_rightBtn];
    }
}


- (void)addStateImg {
    if (!_stateImg) {
        _stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, self.contentView.frame.size.width - 100, 100)];
        _stateImg.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_stateImg];
    }
}

- (void)addLabel {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.contentView.frame.size.width, 100)];
        _label.text = @"1234684fblnjfklbgdl;szkg;sdfkh;dfkhoksfg";
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
}



@end
