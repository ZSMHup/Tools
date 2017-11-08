//
//  PlayerViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/8.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "PlayerViewController.h"
#import <ZFPlayer/ZFPlayer.h>
#import <Masonry/Masonry.h>
#import "UINavigationController+ZFFullscreenPopGesture.h"

@interface PlayerViewController ()<ZFPlayerDelegate,ZFPlayerControlViewDelagate>

@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;

@end

@implementation PlayerViewController

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser) {
        self.isPlaying = YES;
        //        [self.playerView pause];
        self.playerView.playerPushedOrPresented = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    [self.playerView autoPlayTheVideo];
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)playerFatherView {
    if (!_playerFatherView) {
        _playerFatherView = [[UIView alloc] init];

    }
    return _playerFatherView;
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.title = @"这里设置视频标题";
        _playerModel.videoURL = [NSURL URLWithString:@"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4"];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView = self.playerFatherView;
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        [_playerView playerControlView:nil playerModel:self.playerModel];
        // 设置代理
        _playerView.delegate = self;
    }
    return _playerView;
}


@end
