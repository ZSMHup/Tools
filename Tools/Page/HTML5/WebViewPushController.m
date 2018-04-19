//
//  WebViewPushController.m
//  Tools
//
//  Created by 张书孟 on 2018/4/16.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "WebViewPushController.h"
#import "CommonWebView.h"
#import <Masonry/Masonry.h>

#define LocalUrl @"http://localhost:3000/"

@interface WebViewPushController () <CommonWebViewDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) CommonWebView *webView;

@end

@implementation WebViewPushController


- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"HomeModel"];
    
    _webView = [CommonWebView webViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) configuration:config];
    _webView.delegate = self;
    _webView.isNavigationBarOrTranslucent = NO;
    [_webView loadRequestWithUrlString:self.url];
    [self.view addSubview:self.webView];
}

- (void)webView:(CommonWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.navigationItem.title = webView.navigationItemTitle;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"HomeModel"]) {
        NSLog(@"message.body: %@", message.body);
        WebViewPushController *vc = [[WebViewPushController alloc] init];
        vc.url = [NSString stringWithFormat:@"%@%@", LocalUrl, @"Home"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)webView:(CommonWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
