//
//  WebViewController.m
//  Tools
//
//  Created by 张书孟 on 2018/3/16.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "WebViewController.h"
#import "CommonWebView.h"
#import <Masonry/Masonry.h>

#define LocalUrl @"http://192.168.20.28:3000/"

@interface WebViewController () <CommonWebViewDelegate>

@property (nonatomic, strong) CommonWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [CommonWebView webViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    _webView.delegate = self;
    _webView.isNavigationBarOrTranslucent = NO;
   [_webView loadRequestWithUrlString:[NSString stringWithFormat:@"%@index.html", LocalUrl]];
    [self.view addSubview:self.webView];
    
    
}

- (void)webView:(CommonWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.navigationItem.title = webView.navigationItemTitle;
}

@end
