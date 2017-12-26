//
//  FileDownloadManager.h
//  Tools
//
//  Created by 张书孟 on 2017/12/26.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FileSessionModel.h"

@interface FileDownloadManager : NSObject
/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 开启任务下载资源
 
 @param url 下载地址
 @param attribute 需要存储的属性
 @param progressBlock 回调下载进度
 @param stateBlock 下载状态
 */
//- (void)download:(NSString *)url attribute:(NSDictionary *)attribute progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock;
- (void)downloadWithUrl:(NSString *)url fileName:(NSString *)fileName attribute:(NSDictionary *)attribute progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock;

/**
 *  开始下载
 */
- (void)start:(NSString *)url;


/**
 *  暂停下载
 */
- (void)pause:(NSString *)url;

/**
 *  查询该资源的下载进度值
 *
 *  @param url 下载地址
 *
 *  @return 返回下载进度值
 */
//- (CGFloat)progress:(NSString *)url;
- (CGFloat)progress:(NSString *)url fileName:(NSString *)fileName;

/**
 *  获取该资源总大小
 *
 *  @param url 下载地址
 *
 *  @return 资源总大小
 */
//- (NSInteger)fileTotalLength:(NSString *)url;
- (NSInteger)fileTotalLength:(NSString *)url fileName:(NSString *)fileName;

/**
 *  判断该资源是否下载完成
 *
 *  @param url 下载地址
 *
 *  @return YES: 完成
 */
- (BOOL)isCompletion:(NSString *)url fileName:(NSString *)fileName;

/**
 *  判断该文件是否存在
 */
- (BOOL)isExistence:(NSString *)url fileName:(NSString *)fileName;

/**
 *  删除该资源
 *
 *  @param url 下载地址
 *  @param fileName 存放的文件夹
 */
- (void)deleteFile:(NSString *)url fileName:(NSString *)fileName;

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile;

/**
 获取文件存放路径（Documents）
 
 @return 沙盒路径
 */
- (NSString *)getFileRoute;

/**
 获取下载文件的信息
 
 @param fileName 文件存放路径的目录名称 默认：Default
 @return 文件属性
 */
- (NSArray *)getAttribute:(NSString *)fileName;

@end
