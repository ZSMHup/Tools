//
//  CommonWebView.h
//  Tools
//
//  Created by 张书孟 on 2017/12/15.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class CommonWebView;

@protocol CommonWebViewDelegate <NSObject>

@optional

///**
// 请求开始前，会先掉用此代理方法
// */
//- (void)wkWebView:(CommonWebView *)wkWebView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
///**
// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
// */
//- (void)wkWebView:(CommonWebView *)wkWebView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;


/**
 页面开始加载时调用

 @param webView CommonWebView
 */
- (void)webViewDidStartLoad:(CommonWebView *)webView;

/**
 内容开始返回时调用

 @param webView CommonWebView
 @param url url
 */
- (void)webView:(CommonWebView *)webView didCommitWithURL:(NSURL *)url;

/**
 页面加载完成之后调用

 @param webView CommonWebView
 @param url url
 */
- (void)webView:(CommonWebView *)webView didFinishLoadWithURL:(NSURL *)url;

/**
 页面加载失败时调用

 @param webView CommonWebView
 @param error 返回错误信息
 */
- (void)webView:(CommonWebView *)webView didFailLoadWithError:(NSError *)error;

/**
 在js端调用alert函数时，会触发此方法
 js端调用alert时所传的数据可以通过message拿到
 在原生得到结果后，需要回调js，是通过completionHandler回调
 */
- (void)webView:(CommonWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;

/**
 在js端调用Confirm函数时，会触发此方法
 通过message可以拿到js端所传的数据
 在iOS端显示原生alert得到YES／NO
 在原生得到结果后，需要回调js，是通过completionHandler回调
 */
- (void)webView:(CommonWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler;

/**
 在js端调用Prompt函数时，会触发此方法
 要求输入一段文本
 在原生输入得到内容后，通过completionHandler回调给js
 */
- (void)webView:(CommonWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler;


@end

@interface CommonWebView : WKWebView

/** CommonWebViewDelegate */
@property (nonatomic, weak) id<CommonWebViewDelegate> delegate;
/** 进度条颜色(默认蓝色) */
@property (nonatomic, strong) UIColor *progressViewColor;
/** 导航栏标题 */
@property (nonatomic, copy) NSString *navigationItemTitle;
/** 导航栏存在且有穿透效果(默认导航栏存在且有穿透效果) */
@property (nonatomic, assign) BOOL isNavigationBarOrTranslucent;

/**
 类方法创建 CommonWebView

 @param frame frame
 @return CommonWebView
 */
+ (instancetype)webViewWithFrame:(CGRect)frame;
+ (instancetype)webViewWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration;

/**
 加载 web

 @param urlString 地址
 */
- (void)loadRequestWithUrlString:(NSString *)urlString;

/**
 加载本地资源

 @param fileName 该资源的名称（一定要加后缀）
 */
- (void)loadFileName:(NSString *)fileName;

/**
 加载本地资源

 @param filePath 本地资源路径
 */
- (void)loadFileWithFilePath:(NSString *)filePath;

/**
 加载 HTML

 @param HTMLString HTMLString
 */
//- (void)loadHTMLString:(NSString *)HTMLString;

/**
 刷新数据
 */
- (void)reloadData;

/**
 返回上一页
 */
- (void)goBack;

/**
 进入下一页
 */
- (void)goForward;

/**
 清除WKWebView的所有缓存（只能 iOS9 以后使用）

 @param completion 清除成功之后的回调
 */
- (void)removeAllCached:(void(^)(void))completion;

@end
