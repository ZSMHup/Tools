//
//  QRCodeAlbumManager.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//


#import "QRCodeAlbumManager.h"

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

#import "UIImage+ImageSize.h"

@interface QRCodeAlbumManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) NSString *detectorString;

@end

@implementation QRCodeAlbumManager

static QRCodeAlbumManager *_instance;


+ (instancetype)shareQRCodeAlbumManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)initialization {
    
}

// 从相册中读取二维码
- (void)readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController {
    self.currentVC = currentController;
    if (currentController == nil) {
        NSException *excp = [NSException exceptionWithName:@"QRCode" reason:@"readQRCodeFromAlbumWithCurrentController: 方法中的 currentController 参数不能为空" userInfo:nil];
        [excp raise];
    }
//    NSLog(@"detectorString === %@",self.detectorString);
    __weak typeof(self) weakSelf = self;
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (status == PHAuthorizationStatusAuthorized) {  // 用户第一次同意了访问相册权限
                    strongSelf.isPHAuthorization = YES;
                    [strongSelf enterImagePickerController];
                } else { // 用户第一次拒绝了访问相机权限
                    
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            self.isPHAuthorization = YES;
            [self enterImagePickerController];
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *executableFile = [infoDictionary objectForKey:(NSString *)kCFBundleExecutableKey];

            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"相册权限未开启" message:[NSString stringWithFormat:@"请去-> [设置 - 隐私 - 照片 - %@] 打开访问开关",executableFile] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:alertA];
            [self.currentVC presentViewController:alertC animated:YES completion:nil];
        } else if (status == PHAuthorizationStatusRestricted) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于系统原因, 无法访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:alertA];
            [self.currentVC presentViewController:alertC animated:YES completion:nil];
        }
    }
}

// 进入 UIImagePickerController
- (void)enterImagePickerController {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark  UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.currentVC dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeAlbumManagerDidCancelWithImagePickerController:)]) {
        [self.delegate QRCodeAlbumManagerDidCancelWithImagePickerController:self];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 对选取照片的处理，如果选取的图片尺寸过大，则压缩选取图片，否则不作处理
    UIImage *image = [UIImage imageSizeWithScreenImage:info[UIImagePickerControllerOriginalImage]];
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    __weak typeof(self) weakSelf = self;
    if (features.count == 0) {
        [self.currentVC dismissViewControllerAnimated:YES completion:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(QRCodeAlbumManager:didFinishPickingMediaWithResult:)]) {
                [strongSelf.delegate QRCodeAlbumManager:strongSelf didFinishPickingMediaWithResult:strongSelf.detectorString];
            }
        }];
        return;
        
    } else {
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            NSString *resultStr = feature.messageString;
          
            self.detectorString = resultStr;
        }
        [self.currentVC dismissViewControllerAnimated:YES completion:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(QRCodeAlbumManager:didFinishPickingMediaWithResult:)]) {
                [strongSelf.delegate QRCodeAlbumManager:strongSelf didFinishPickingMediaWithResult:strongSelf.detectorString];
            }
            strongSelf.detectorString = nil;
        }];
    }
}

@end
