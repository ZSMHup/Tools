//
//  CommonWebView.h
//  Tools
//
//  Created by 张书孟 on 2017/12/15.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonWebView;

@protocol CommonWebViewDelegate <NSObject>

@optional

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

@end

@interface CommonWebView : UIView

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
