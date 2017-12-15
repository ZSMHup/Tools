//
//  QRCodeAlbumManager.h
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QRCodeAlbumManager;

@protocol QRCodeAlbumManagerDelegate <NSObject>

@required

/**
 图片选择控制器取消按钮的点击回调方法

 @param albumManager QRCodeAlbumManager
 */
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(QRCodeAlbumManager *)albumManager;

/**
 图片选择控制器选取图片完成之后的回调方法

 @param albumManager QRCodeAlbumManager
 @param result 获取的二维码数据
 */
- (void)QRCodeAlbumManager:(QRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result;

@end

@interface QRCodeAlbumManager : NSObject

@property (nonatomic, weak) id<QRCodeAlbumManagerDelegate> delegate;
/** 判断相册访问权限是否授权 */
@property (nonatomic, assign) BOOL isPHAuthorization;

+ (instancetype)shareQRCodeAlbumManager;

- (void)readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController;

@end
