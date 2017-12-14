//
//  QRCodeScanManager.h
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class QRCodeScanManager;

@protocol QRCodeScanManagerDelegate <NSObject>

@optional
/**
 二维码扫描获取数据的回调方法

 @param scanManager QRCodeScanManager
 @param metadataObjects 扫描二维码数据信息
 */
- (void)QRCodeScanManager:(QRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects;

/**
 根据光线强弱值打开手电筒的方法

 @param scanManager QRCodeScanManager
 @param brightnessValue 光线强弱值
 */
- (void)QRCodeScanManager:(QRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue;

@end

@interface QRCodeScanManager : NSObject

/**
 QRCodeScanManagerDelegate
 */
@property (nonatomic, weak) id<QRCodeScanManagerDelegate> delegate;

+ (instancetype)shareQRCodeScanManager;

/**
 *  创建扫描二维码会话对象以及会话采集数据类型和扫码支持的编码格式的设置，必须实现的方法
 *
 *  @param sessionPreset    会话采集数据类型
 *  @param metadataObjectTypes    扫码支持的编码格式
 *  @param currentController      QRCodeScanManager 所在控制器
 */
- (void)setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController;

/**
 开启会话对象扫描
 */
- (void)startRunning;

/**
 停止会话对象扫描
 */
- (void)stopRunning;

/**
 移除 videoPreviewLayer 对象
 */
- (void)videoPreviewLayerRemoveFromSuperlayer;

/**
 重置根据光线强弱值打开手电筒的 delegate 方法
 */
- (void)resetSampleBufferDelegate;

/**
 取消根据光线强弱值打开手电筒的 delegate 方法
 */
- (void)cancelSampleBufferDelegate;

/**
 播放音效文件

 @param name 文件名称
 */
- (void)palySoundName:(NSString *)name;

/**
 打开手电筒
 */
- (void)openFlashlight;

/**
 关闭手电筒
 */
- (void)closeFlashlight;

@end
