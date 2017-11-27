//
//  PlayerTableViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/9.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "PlayerTableViewController.h"
#import "PlayerViewController.h"

#import "PlayerTableViewCell.h"
#import <ZFPlayer/ZFPlayer.h>
#import "VideoResolution.h"

#import "VideoModel.h"

#import <Masonry/Masonry.h>
#import "UITableViewCell+FastCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlayerTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZFPlayerDelegate>

@property (nonatomic, strong) UITableView *listtableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation PlayerTableViewController

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addListtableView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *videoList = [dic objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        VideoModel *model = [[VideoModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    // 这里设置横竖屏不同颜色的statusbar
//    if (ZFPlayerShared.isLandscape) {
//        return UIStatusBarStyleLightContent;
//    }
//    return UIStatusBarStyleDefault;
//}
//
//- (BOOL)prefersStatusBarHidden {
//    return ZFPlayerShared.isStatusBarHidden;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerTableViewCell *cell = [PlayerTableViewCell cellWithTableView:tableView];
    
    __block VideoModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    __block NSIndexPath *weakIndexPath = indexPath;
    __block PlayerTableViewCell *weakCell = cell;
    __weak typeof(self) weakSelf = self;
    cell.playBlock = ^(UIButton *sender) {
        // 分辨率字典（key:分辨率名称，value：分辨率url)
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (VideoResolution * resolution in model.playInfo) {
            [dic setValue:resolution.url forKey:resolution.name];
        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:dic.allValues.firstObject];
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title = model.title;
        playerModel.videoURL = videoURL;
        playerModel.placeholderImageURLString = model.coverForFeed;
        playerModel.scrollView = weakSelf.listtableView;
        playerModel.indexPath = weakIndexPath;
        // 赋值分辨率字典
        playerModel.resolutionDic = dic;
        // player的父视图tag
        playerModel.fatherViewTag = weakCell.videoView.tag;
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:weakSelf.controlView playerModel:playerModel];
        // 下载功能
//        weakSelf.playerView.hasDownload = YES;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoModel *model = self.dataSource[indexPath.row];
    PlayerViewController *player = [[PlayerViewController alloc] init];
    player.title = model.title;
    player.videoUrl = [NSURL URLWithString:model.playUrl];
    [self.navigationController pushViewController:player animated:YES];
}

- (void)addListtableView {
    if (!_listtableView) {
        _listtableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _listtableView.delegate = self;
        _listtableView.dataSource = self;
        _listtableView.rowHeight = 350.0;
        
        [self.view addSubview:_listtableView];
        [_listtableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.view);
        }];
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}



@end
