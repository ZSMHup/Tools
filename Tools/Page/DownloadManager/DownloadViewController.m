//
//  DownloadViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/20.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "DownloadViewController.h"
#import "FileDownloadManager.h"

@interface DownloadViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *beginBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation DownloadViewController

//NSString *downloadUrl = @"http://web.touyanshe.com.cn/touyanshe_web/outImages/20170914/20170914_6689922.pdf";
//NSString *downloadUrl = @"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4";
NSString *downloadUrl = @"http://120.25.226.186:32812/resources/videos/minion_01.mp4";

- (void)dealloc
{
    NSLog(@"dealloc");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"沙盒路径： %@",[[FileDownloadManager sharedInstance] getFileRoute]);
    NSLog(@"---------------------");
    NSLog(@"%@",[[FileDownloadManager sharedInstance] getAttribute:@"PDF"]);
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"断点续传";
    
    _beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _beginBtn.frame = CGRectMake(100, 100, 80, 30);
    [_beginBtn setTitle:[self getTitleWithDownloadState:DownloadStateSuspended] forState:UIControlStateNormal];
    
    _beginBtn.backgroundColor = [UIColor cyanColor];
    [_beginBtn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_beginBtn];
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
    _cancelBtn.frame = CGRectMake(100, 300, 80, 30);
    _cancelBtn.backgroundColor = [UIColor cyanColor];
    [_cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 260, 20)];
    [self.view addSubview:_titleLabel];
    _titleLabel.text = @"当前下载进度：";
    _titleLabel.textAlignment = 0;
    [self refreshDataWithState:DownloadStateSuspended];
    
}

#pragma mark 刷新数据（用来判断程序刚进来时候下载的文件本地是否存在过，进度咋样）
- (void)refreshDataWithState:(DownloadState)state
{
    _titleLabel.text = [NSString stringWithFormat:@"当前下载进度：%.f%%", [[FileDownloadManager sharedInstance] progress:downloadUrl fileName:@"PDF"] * 100];
    
    [self.beginBtn setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
    
    
    NSLog(@"-----%f", [[FileDownloadManager sharedInstance] progress:downloadUrl fileName:@"PDF"]);
}

#pragma mark 按钮状态
- (NSString *)getTitleWithDownloadState:(DownloadState)state
{
    switch (state) {
        case DownloadStateStart:
            return @"暂停";
        case DownloadStateSuspended:
        case DownloadStateFailed:
            return @"开始";
        case DownloadStateCompleted:
            return @"完成";
        default:
            break;
    }
}

- (void)handleBtn:(UIButton *)btn {
    
    NSDictionary *dic = @{
                          @"fileId" : @"1",
                          @"create_time" : @"2017.12.20",
                          @"att_name" : @"测试",
                          @"live_id" : @"123456789",
                          @"att_path" : downloadUrl
                          };
    
    [[FileDownloadManager sharedInstance] downloadWithUrl:downloadUrl fileName:@"PDF" attribute:dic progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _titleLabel.text = [NSString stringWithFormat:@"当前下载进度：%.2f%%", progress* 100];
            NSLog(@"---progress---: %lf",progress * 100);
        });
    } state:^(DownloadState state) {
        NSLog(@"dsfsdgsd");
        NSLog(@"state == %u", state);
        dispatch_async(dispatch_get_main_queue(), ^{
            [btn setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
        });
    }];
}

- (void)cancelBtn:(UIButton *)btn {
    
    [[FileDownloadManager sharedInstance] deleteFile:downloadUrl fileName:@"PDF"];
    
//    [[HSDownloadManager sharedInstance] deleteAllFile];
    
    _titleLabel.text = [NSString stringWithFormat:@"当前下载进度：%.f%%", [[FileDownloadManager sharedInstance] progress:downloadUrl fileName:@"PDF"] * 100];
}

@end
