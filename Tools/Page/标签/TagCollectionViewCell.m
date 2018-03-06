//
//  TagCollectionViewCell.m
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "TagCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface TagCollectionViewCell ()

@property (nonatomic, strong) UIButton *contentBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation TagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.borderWidth = 1.0;
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self addContentBtn];
    [self addDeleteBtn];
}

- (void)addContentBtn
{
    if (!_contentBtn) {
        _contentBtn = [[UIButton alloc] init];
        _contentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_contentBtn];
        [_contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10.0);
            make.top.equalTo(self.contentView.mas_top).offset(5.0);
            make.right.equalTo(self.contentView.mas_right).offset(-10.0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0);
        }];
    }
}

- (void)addDeleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"close-fill"] forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(-5.0);
            make.right.equalTo(self.contentView).offset(5.0);
            make.size.mas_equalTo(CGSizeMake(13.0, 13.0));
        }];
    }
}

- (void)deleteBtnAction
{
    if (_deleteBtnActionBlock) {
        _deleteBtnActionBlock();
    }
}

- (void)setContentString:(NSString *)contentString
{
    _contentString = contentString;
    [self.contentBtn setTitle:contentString forState:(UIControlStateNormal)];
}

@end
