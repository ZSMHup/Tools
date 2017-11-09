//
//  PlayerTableViewCell.m
//  Tools
//
//  Created by 张书孟 on 2017/11/9.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "PlayerTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UITableViewCell+FastCell.h"

@interface PlayerTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation PlayerTableViewCell

- (void)loadWithComponents {
    [self addIconImg];
    [self addNameLabel];
    [self addDateLabel];
    [self addTitleLabel];
    [self addVideoView];
    [self addPlayBtn];
    
    [self layoutIfNeeded];
    [self cutRoundView:self.iconImg];
    
    // 设置imageView的tag，在PlayerView中取（建议设置100以上）
    self.videoView.tag = 1001;
}

- (void)setModel:(VideoModel *)model {
    self.titleLabel.text = model.title;
    [self.videoView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

// 切圆角
- (void)cutRoundView:(UIImageView *)imageView {
    CGFloat corner = imageView.frame.size.width / 2;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    shapeLayer.path = path.CGPath;
    imageView.layer.mask = shapeLayer;
}

- (void)addIconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"defaultUserIcon"];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10.0);
            make.top.equalTo(self.mas_top).offset(10.0);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }
}

- (void)addNameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"qwert";
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).offset(10.0);
            make.top.equalTo(self.iconImg.mas_top);
        }];
    }
}

- (void)addDateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"2017.11.09 12:00";
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).offset(10.0);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10.0);
        }];
    }
}

- (void)addTitleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"123456789";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_left);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(10.0);
        }];
    }
}

- (void)addVideoView {
    if (!_videoView) {
        _videoView = [[UIImageView alloc] init];
        _videoView.backgroundColor = [UIColor redColor];
        _videoView.userInteractionEnabled = YES;
        [self.contentView addSubview:_videoView];
        [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10.0);
            make.height.equalTo(_videoView.mas_width).multipliedBy(9.0f/16.0f);
        }];
    }
}

- (void)addPlayBtn {
    if (!_playBtn) {
        _playBtn = [[UIButton alloc] init];
        [_playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:(UIControlStateNormal)];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.videoView addSubview:_playBtn];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.videoView);
            make.width.height.mas_equalTo(50);
        }];
    }
}

- (void)playBtnClick:(UIButton *)sender {
    if (_playBlock) {
        _playBlock(sender);
    }
}


@end
