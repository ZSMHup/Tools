//
//  QRCodeScanningSuccessVC.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "QRCodeScanningSuccessVC.h"
#import "CommonWebView.h"
#import <Masonry/Masonry.h>

#import "FileDownloadManager.h"

@interface QRCodeScanningSuccessVC ()<CommonWebViewDelegate>

@property (nonatomic, strong) CommonWebView *webView;

@end

@implementation QRCodeScanningSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    _webView = [CommonWebView webViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.isNavigationBarOrTranslucent = NO;
    _webView.delegate = self;
//    [_webView loadRequestWithUrlString:self.urlString];
//    [_webView loadRequestWithUrlString:@"https://www.baidu.com/s?ie=UTF-8&wd=The%20file%20%E2%80%9CAFNetworking.xcconfig%E2%80%9D%20couldn%E2%80%99t%20be%20opened%20because%20there%20is%20no%20s"];
    [_webView loadFileName:@"test1.html"];
    
//    if ([[FileDownloadManager sharedInstance] isExistence:@"http://tya.znzkj.net/touyanshe_web/outImages/20180104/20180104_5642247.pdf" fileName:@"PDF"]) {
//        NSString *filePath = [[FileDownloadManager sharedInstance] getFileWithURL:@"http://tya.znzkj.net/touyanshe_web/outImages/20180104/20180104_5642247.pdf" fileName:@"PDF"];
//        [_webView loadFileWithFilePath:filePath];
//    }
    
    [self.view addSubview:_webView];
    
}

- (void)setupNavigationItem {
    
    UIBarButtonItem *rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(right_BarButtonItemAction)];
    UIBarButtonItem *rightBarButtonItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFastForward) target:self action:@selector(right_BarButtonItemAction1)];
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem1, rightBarButtonItem2];
}

- (void)right_BarButtonItemAction {
    [self.webView goBack];
}

- (void)right_BarButtonItemAction1 {
    [self.webView removeAllCached:^{
        NSLog(@"清除缓存成功");
    }];
}

- (void)webView:(CommonWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.navigationItem.title = webView.navigationItemTitle;
}

@end
