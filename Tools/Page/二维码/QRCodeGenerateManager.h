//
//  QRCodeGenerateManager.h
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QRCodeGenerateManager : NSObject

/**
 *  生成一张带有logo的二维码
 *
 *  @param data    传入你要生成二维码的数据
 *  @param logoImageName    logo的image名
 *  @param logoScaleToSuperView    logo相对于父视图的缩放比（取值范围：0-1，0，代表不显示，1，代表与父视图大小相同）
 */
+ (UIImage *)generateWithLogoQRCodeData:(NSString *)data logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

/**
 *  生成一张彩色的二维码
 *
 *  @param data    传入你要生成二维码的数据
 *  @param backgroundColor    背景色
 *  @param mainColor    主颜色
 */
+ (UIImage *)generateWithColorQRCodeData:(NSString *)data backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

@end
