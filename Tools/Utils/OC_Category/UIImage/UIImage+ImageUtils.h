//
//  UIImage+ImageUtils.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/7.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, UIGradientStyle) {
    // left to right
    UIGradientStyleLeftToRight,
    // top to bottom
    UIGradientStyleTopToBottom
};

@interface UIImage (ImageUtils)

/**
 设置带圆角的渐变色图片
 
 @param bounds 要设置的view的bounds
 @param colors 渐变色包含的颜色数组
 @param cornerRadius 圆角弧度
 @param gradientStyle 渐变类型
 @return 带圆角的渐变色图片
 */
+ (UIImage *)gradientImageWithBounds:(CGRect)bounds colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius gradientStyle:(UIGradientStyle)gradientStyle;

/**
 根据颜色导出图片
 
 @param color 设置的颜色
 @return 该种颜色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 改变图片颜色
 
 @param color 设置的颜色
 @return 改变颜色后的图片
 */
- (UIImage *)changeImageColorWithColor:(UIColor *)color;

/**
 给图片设置圆角
 
 @param radius 弧度
 @param size 图片的尺寸
 @return 带圆角的图片
 */
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

/**
 设置图片圆形
 
 @return 圆形的图片
 */
- (UIImage *)circleImage;


/**
 给图片毛玻璃处理

 @param blur 模糊度，最好设置0.5
 @return 带有毛玻璃效果的图片
 */
- (UIImage *)boxBlurImageWithBlur:(CGFloat)blur;

/**
 图片尺寸压缩

 @param image 待处理的图片
 @param newSize 新的尺寸
 @return 尺寸压缩后的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 图片质量压缩

 @param image 待处理的图片
 @param maxLength 最大字节长度
 @return 质量被压缩后的图片
 */
- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

/**
 图片尺寸压缩失真

 @param targetSize 目标尺寸
 @return 尺寸压缩后的图片
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 图片尺寸压缩不失真

 @param targetSize 目标尺寸
 @return 尺寸压缩后的图片
 */
- (UIImage *)imageByScalingToSizeWithoutDistortion:(CGSize)targetSize;

/**
 图片体积压缩

 @param maxLength 限制体积
 @return 体积压缩后的图片
 */
- (UIImage *)compressToByte:(int)maxLength;

- (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block;

- (void)compressToKBytes:(CGFloat)kBytes completion:(void(^)(UIImage *compressImage))completion;

@end
