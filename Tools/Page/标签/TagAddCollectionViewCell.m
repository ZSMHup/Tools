//
//  TagAddCollectionViewCell.m
//  Tools
//
//  Created by 张书孟 on 2018/3/6.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "TagAddCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface TagAddCollectionViewCell ()

@property (nonatomic, strong) UIButton *contentBtn;

@end

@implementation TagAddCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.borderWidth = 1.0;
        self.contentView.layer.borderColor = [UIColor greenColor].CGColor;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self addContentBtn];
}

- (void)addContentBtn
{
    if (!_contentBtn) {
        _contentBtn = [[UIButton alloc] init];
        _contentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_contentBtn addTarget:self action:@selector(contentBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_contentBtn];
        [_contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10.0);
            make.top.equalTo(self.contentView.mas_top).offset(5.0);
            make.right.equalTo(self.contentView.mas_right).offset(-10.0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0);
        }];
    }
}

- (void)setContentString:(NSString *)contentString
{
    _contentString = contentString;
    [self.contentBtn setTitle:contentString forState:(UIControlStateNormal)];
}

- (void)contentBtnAction
{
    if (_addBtnActionBlock) {
        _addBtnActionBlock();
    }
}


@end
