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

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UILabel *tipsLable;

@property (nonatomic, strong) UIImageView *stateImg;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *tips;

@end

@implementation AlertView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
    }
    return self;
}

+ (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content tips:(NSString *)tips block:(void (^)(NSInteger index))block {
    AlertView *alV = [[AlertView alloc] init];
    alV.btnClickBlock = block;
    alV.content = content;
    alV.title = title;
    alV.tips = tips;
    [alV addTipsShowAlertView];
    
    alV.contentView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.25 animations:^{
        alV.contentView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        alV.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    [kKeyWindow addSubview:alV];
}

- (float)heightForString:(NSString *)value width:(float)width{
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                           context:nil].size;
    return sizeToFit.height;
}

#pragma mark 添加视图

- (void)addTipsShowAlertView {
    [self addBgView];
    [self addContentView];
    [self addTitleLabel];
    [self addContentLabel];
    [self addTipsLable];
    [self addLeftBtn];
    [self addRightBtn];
}

//隐藏
- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    self.btnClickBlock(0);
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

#pragma mark 点击事件

- (void)canaelClick:(UIButton *)sender {
    self.btnClickBlock(0);
    [self hide];
}

- (void)ensureClick:(UIButton *)sender {
    self.btnClickBlock(1);
    [self hide];
}

#pragma mark 懒加载

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
        CGFloat fl = [self heightForString:self.content width:_contentView.frame.size.width-20];
        if (fl > 40.0) {
            CGRect contentSize = _contentView.frame;
            if (!self.tips) {
                contentSize.size.height = fl + 100;
            } else {
                contentSize.size.height = fl + 140;
            }
            _contentView.frame = contentSize;
        }
        CGPoint center = _contentView.center;
        center = self.center;
        _contentView.center = center;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
    }
}

- (void)addTitleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width-20, 50)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.text = self.title;
        if (self.title) {
            [self.contentView addSubview:_titleLabel];
        }
    }
}

- (void)addContentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        if (self.title && self.tips) {
            _contentLabel.frame = CGRectMake(10, self.titleLabel.frame.size.height + 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - self.titleLabel.frame.size.height - 100);
        } else if (self.title) {
            _contentLabel.frame = CGRectMake(10, self.titleLabel.frame.size.height + 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - self.titleLabel.frame.size.height - 60);
        } else if (self.tips) {
            _contentLabel.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 100);
        } else {
            _contentLabel.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 50);
        }
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.text = self.content;
        [self.contentView addSubview:_contentLabel];
    }
}
- (void)addTipsLable {
    if (!_tipsLable) {
        _tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.contentLabel.frame.size.height, self.contentView.frame.size.width - 20, 40)];
        _tipsLable.textColor = [UIColor redColor];
        _tipsLable.textAlignment = NSTextAlignmentCenter;
        _tipsLable.font = [UIFont systemFontOfSize:14];
        _tipsLable.text = self.tips;
        if (self.tips) {
            [self.contentView addSubview:_tipsLable];
        }
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
