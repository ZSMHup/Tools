//
//  VideoListViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/9.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "VideoListViewController.h"
#import "PlayerViewController.h"
#import "PlayerTableViewController.h"

#import <Masonry/Masonry.h>
#import "UITableViewCell+FastCell.h"

@interface VideoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *videoListTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation VideoListViewController

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationSetUp];
    
    self.dataSource = @[@"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4",
                        @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4",
                        @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
                        @"http://baobab.wdjcdn.com/14525705791193.mp4",
                        @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
                        @"http://baobab.wdjcdn.com/1455968234865481297704.mp4",
                        @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
                        @"http://baobab.wdjcdn.com/14564977406580.mp4",
                        @"http://baobab.wdjcdn.com/1456316686552The.mp4",
                        @"http://baobab.wdjcdn.com/1456480115661mtl.mp4",
                        @"http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
                        @"http://baobab.wdjcdn.com/1455614108256t(2).mp4",
                        @"http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
                        @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
                        @"http://baobab.wdjcdn.com/1456734464766B(13).mp4",
                        @"http://baobab.wdjcdn.com/1456653443902B.mp4",
                        @"http://baobab.wdjcdn.com/1456231710844S(24).mp4"];
    
    [self addVideoListTableView];
}

- (void)navigationSetUp {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"列表" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonItemClick {
    PlayerTableViewController *player = [[PlayerTableViewController alloc] init];
    [self.navigationController pushViewController:player animated:YES];
}

// 必须支持转屏，但只是只支持竖屏，否则横屏启动起来页面是横的
- (BOOL)shouldAutorotate {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"网络视频%zd",indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *player = [[PlayerViewController alloc] init];
    player.videoUrl = [NSURL URLWithString:self.dataSource[indexPath.row]];
    player.title = [NSString stringWithFormat:@"网络视频%zd",indexPath.row+1];
    [self.navigationController pushViewController:player animated:YES];
}

- (void)addVideoListTableView {
    if (!_videoListTableView) {
        _videoListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _videoListTableView.delegate = self;
        _videoListTableView.dataSource = self;
        [self.view addSubview:_videoListTableView];
        [_videoListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.view);
        }];
    }
}



@end
