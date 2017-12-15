//
//  UIImage+ImageSize.h
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageSize)

/**
 设置一张不超过屏幕尺寸的 image

 @param image 传入一张image
 @return 返回一张不超过屏幕尺寸的 image
 */
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

@end
