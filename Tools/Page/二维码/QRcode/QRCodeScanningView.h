//
//  QRCodeScanningView.h
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CornerLoactionDefault, // 默认与边框线同中心点
    CornerLoactionInside, // 在边框线内部
    CornerLoactionOutside, // 在边框线外部
} CornerLoaction;

typedef enum : NSUInteger{
    ScanningAnimationStyleDefault, // 单线扫描样式
    ScanningAnimationStyleGrid, // 网格扫描样式
} ScanningAnimationStyle;

@interface QRCodeScanningView : UIView

/** 扫描样式，默认 ScanningAnimationStyleDefault */
@property (nonatomic, assign) ScanningAnimationStyle scanningAnimationStyle;
/** 扫描线名 */
@property (nonatomic, copy) NSString *scanningImageName;
/** 边框颜色，默认白色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 边角位置，默认 CornerLoactionDefault */
@property (nonatomic, assign) CornerLoaction cornerLocation;
/** 边角颜色，默认微信颜色 */
@property (nonatomic, strong) UIColor *cornerColor;
/** 边角宽度，默认 2.f */
@property (nonatomic, assign) CGFloat cornerWidth;
/** 扫描区周边颜色的 alpha 值，默认 0.2f */
@property (nonatomic, assign) CGFloat backgroundAlpha;
/** 扫描线动画时间，默认 0.02 */
@property (nonatomic, assign) NSTimeInterval animationTimeInterval;

/**
 添加定时器
 */
- (void)addTimer;
/**
 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器)
 */
- (void)removeTimer;

@end
