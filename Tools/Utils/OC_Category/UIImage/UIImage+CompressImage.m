//
//  UIImage+CompressImage.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/28.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "UIImage+CompressImage.h"

@implementation UIImage (CompressImage)

- (UIImage *)imageByResizeToWidth:(CGFloat)width
{
    return [self imageByResizeToWidth:width scale:YES];
}

- (UIImage *)imageByResizeToWidth:(CGFloat)width scale:(BOOL)scale
{
    if (self.size.width <= 0 || self.size.height <= 0) return nil;
    CGFloat height = width * self.size.height / self.size.width;
    return [self imageByResizeToSize:CGSizeMake(width, height) scale:scale];
}

- (UIImage *)imageByResizeToSize:(CGSize)size
{
    return [self imageByResizeToSize:size scale:YES];
}

- (UIImage *)imageByResizeToSize:(CGSize)size scale:(BOOL)scale
{
    if (size.width <= 0 || size.height <= 0) return nil;
    CGFloat scaleFactor = scale ? self.scale : 1.0;
    UIGraphicsBeginImageContextWithOptions(size, NO, scaleFactor);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

NS_INLINE CGFloat clampCompressionFactor(CGFloat factor)
{
    return factor <= 1e-10 ? 1e-10 : factor > 0.1 ? 0.1 : factor;
}

- (NSData *)compressToJPEGFormatDataWithFactor:(CGFloat)factor maxFileSize:(u_int64_t)fileSize
{
    if (!self) return nil;
    
    NSData *tempImageData = UIImageJPEGRepresentation(self, 1.0);
    if ([tempImageData length] <= fileSize) return tempImageData;
    
    NSData *targetImageData = nil;
    CGFloat compressionFactor = clampCompressionFactor(factor);
    CGFloat minFactor = 0;
    CGFloat maxFactor = 1.0;
    CGFloat midFactor = 0;
    
    while (fabs(maxFactor-minFactor) > compressionFactor)
    {
        @autoreleasepool
        {
            midFactor = minFactor + (maxFactor - minFactor)/2;
            tempImageData = UIImageJPEGRepresentation(self, midFactor);
            
            if ([tempImageData length] > fileSize) {
                maxFactor = midFactor;
            } else {
                minFactor = midFactor;
                targetImageData = tempImageData;
            }
        }
    }
    
    return targetImageData;
}

- (NSData *)resetImageDataWithImageWidth:(CGFloat)width maxFileSize:(uint64_t)maxFileSize
{
    // Image Size
    UIImage *newImage = [self imageByResizeToWidth:width];
    
    // File Size
    return [newImage compressToJPEGFormatDataWithFactor:1e-10 maxFileSize:maxFileSize];
}

- (NSData *)resetImageDataWithImageSize:(CGSize)size maxFileSize:(uint64_t)maxFileSize
{
    // Image Size
    UIImage *newImage = [self imageByResizeToSize:size];
    
    // File Size
    return [newImage compressToJPEGFormatDataWithFactor:1e-10 maxFileSize:maxFileSize];
}

+ (UIImage *)compressImage:(UIImage *)image
{
    if (!image) {
       return nil;
    }
    
    CGFloat width = image.size.width;
    if (image.size.width > [[UIScreen mainScreen] bounds].size.width) {
        width = [[UIScreen mainScreen] bounds].size.width;
    }
    
    NSData *data = [image resetImageDataWithImageWidth:width maxFileSize:100000];
    return [UIImage imageWithData:data];
}

@end
