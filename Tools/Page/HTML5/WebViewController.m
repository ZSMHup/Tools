//
//  WebViewController.m
//  Tools
//
//  Created by 张书孟 on 2018/3/16.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewPushController.h"

#import <AYWebView/AYWebView.h>
#import <Masonry/Masonry.h>

#define LocalUrl @"http://192.168.20.18:3000/"

@interface WebViewController () <AYWebViewDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) AYWebView *webView;

@property (nonatomic, strong) NSString *url;

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    [config.userContentController addScriptMessageHandler:self name:@"AppTabs"];
    [config.userContentController addScriptMessageHandler:self name:@"Income"];
    [config.userContentController addScriptMessageHandler:self name:@"GoodsList"];
    [config.userContentController addScriptMessageHandler:self name:@"IntegralList"];
    [config.userContentController addScriptMessageHandler:self name:@"Auth"];
    [config.userContentController addScriptMessageHandler:self name:@"Recommend"];
    [config.userContentController addScriptMessageHandler:self name:@"HelpCenter"];

    _webView = [AYWebView webViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) configuration:config];
    _webView.delegate = self;
    _webView.isNavigationBarOrTranslucent = NO;
    NSString *url = [NSString stringWithFormat:@"%@Personal", LocalUrl];
   [_webView loadRequestWithUrlString:url];
    [self.view addSubview:self.webView];
    
}

- (void)webView:(AYWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.navigationItem.title = webView.navigationItemTitle;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Carousel"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"AppTabs"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"AppTabs"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"Income"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Personal/Detail"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"GoodsList"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Personal/GoodsList"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"IntegralList"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Personal/IntegralList"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"Auth"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Personal/Auth"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"Recommend"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Personal/RecommendReward"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"HelpCenter"]) {
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Personal/HelpCenter"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)webView:(AYWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
