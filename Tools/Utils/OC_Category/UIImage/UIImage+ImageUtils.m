//
//  UIImage+ImageUtils.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/7.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "UIImage+ImageUtils.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (ImageUtils)

+ (UIImage *)gradientImageWithBounds:(CGRect)bounds colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius gradientStyle:(UIGradientStyle)gradientStyle
{
    UIImage *gradientImage = [UIImage gradientImageWithBounds:bounds colors:colors gradientStyle:gradientStyle];
    return [gradientImage imageAddCornerWithRadius:cornerRadius andSize:bounds.size];
    
}

- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context,path.CGPath);
    CGContextClip(context);
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)gradientImageWithBounds:(CGRect)bounds colors:(NSArray *)colors gradientStyle:(UIGradientStyle)gradientStyle
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for(UIColor *color in colors) {
        [arr addObject:(id)color.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arr, NULL);
    
    CGPoint start = CGPointMake(0.f, 0.5);
    CGPoint end = CGPointMake(bounds.size.width, 0.0);
    
    switch (gradientStyle) {
        case UIGradientStyleTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case UIGradientStyleLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
        default: {
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
        };
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return outImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color bounds:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color bounds:(CGRect)bounds
{
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, bounds);
    UIImage *outImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImg;
}

- (UIImage *)changeImageColorWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.f);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.width);
    CGContextAddEllipseInRect(ref, rect);
    CGContextClip(ref);
    [self drawInRect:rect];
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
}

- (UIImage *)boxBlurImageWithBlur:(CGFloat)blur
{
    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
    UIImage *destImage = [UIImage imageWithData:imageData];
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = destImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    // create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    // create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    // perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength
{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor) {
            scaleFactor = widthFactor;
        } else {
            
            scaleFactor = heightFactor;
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(!newImage) {
        NSLog(@"could not scale image");
    }
    
    return newImage ;
    
}

- (UIImage *)imageByScalingToSizeWithoutDistortion:(CGSize)targetSize
{
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)compressToKBytes:(CGFloat)kBytes completion:(void(^)(UIImage *compressImage))completion
{
    __block UIImage *imageCope = self;
    CGFloat fImageBytes = kBytes * 1024; // 需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes && fImageBytes > 0) {
        
        dispatch_async(dispatch_queue_create("CompressedImage", DISPATCH_QUEUE_SERIAL), ^{
            
            /* 宽高的比例 **/
            CGFloat ratioOfWH = imageWidth / imageHeight;
            /* 压缩率 **/
            CGFloat compressionRatio = fImageBytes / uploadImageData.length;
            /* 宽度或者高度的压缩率 **/
            CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
            
            CGFloat dWidth   = imageWidth  * widthOrHeightCompressionRatio;
            CGFloat dHeight  = imageHeight * widthOrHeightCompressionRatio;
            if (ratioOfWH > 0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
                dHeight = dWidth/ratioOfWH;
            } else {
                dWidth  = dHeight*ratioOfWH;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImagePNGRepresentation(imageCope);
            
            // 微调
            NSInteger compressCount = 0;
            /* 控制在 1M 以内**/
            while (fabs(uploadImageData.length - fImageBytes) > 1000) {
                /* 再次压缩的比例**/
                CGFloat nextCompressionRatio = 0.9;
                
                if (uploadImageData.length > fImageBytes) {
                    dWidth  = dWidth*nextCompressionRatio;
                    dHeight = dHeight*nextCompressionRatio;
                } else {
                    dWidth  = dWidth / nextCompressionRatio;
                    dHeight = dHeight / nextCompressionRatio;
                }
                
                imageCope = [self drawWithWithImage:imageCope width:(NSInteger)dWidth height:(NSInteger)dHeight];
                uploadImageData = UIImagePNGRepresentation(imageCope);
                
                /*防止进入死循环**/
                compressCount ++;
                if (compressCount == 10) {
                    break;
                }
                
            }
            
            imageCope = [[UIImage alloc] initWithData:uploadImageData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(imageCope);
                }
            });
        });
    } else {
        if (completion) {
            completion(imageCope);
        }
    }
}

- (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(NSInteger)dWidth height:(NSInteger)dHeight
{
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
}

@end
