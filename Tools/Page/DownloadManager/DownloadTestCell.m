//
//  DownloadTestCell.m
//  FileDownloadManagerTest
//
//  Created by 张书孟 on 2017/12/26.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "DownloadTestCell.h"

@interface DownloadTestCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation DownloadTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addNameLabel];
        [self addProgressLabel];
        [self addDownloadBtn];
        [self addDeleteBtn];
    }
    return self;
}

- (void)setConfig:(NSDictionary *)config {
    _config = config;
    self.nameLabel.text = config[@"att_name"];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.f%%", progress];
}

- (void)btnClick:(UIButton *)sender {
    if (_downloadBtnClick) {
        _downloadBtnClick(sender,self.progressLabel);
    }
}

- (void)deleteBtnClick:(UIButton *)sender {
    if (_deleteBtnClick) {
        _deleteBtnClick(self.progressLabel);
    }
}

- (void)addNameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
    }
}

- (void)addProgressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 60, 30)];
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_progressLabel];
    }
}

- (void)addDownloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 10, 60, 30)];
        [_downloadBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _downloadBtn.backgroundColor = [UIColor orangeColor];
        [_downloadBtn setTitle:@"下载" forState:(UIControlStateNormal)];
        [_downloadBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_downloadBtn];
    }
}

- (void)addDeleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(270, 10, 60, 30)];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _deleteBtn.backgroundColor = [UIColor orangeColor];
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_deleteBtn];
    }
}

@end
