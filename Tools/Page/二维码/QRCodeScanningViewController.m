//
//  QRCodeScanningViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "QRCodeScanningViewController.h"
#import "QRCodeScanningSuccessVC.h"

#import <AYQRCodeManager/AYQRCodeScanManager.h>
#import <AYQRCodeManager/AYQRCodeScanningView.h>
#import <AYQRCodeManager/AYQRCodeAlbumManager.h>
#import <AVFoundation/AVFoundation.h>

@interface QRCodeScanningViewController ()<AYQRCodeScanManagerDelegate, AYQRCodeAlbumManagerDelegate>

@property (nonatomic, strong) AYQRCodeScanManager *manager;
@property (nonatomic, strong) AYQRCodeScanningView *scanningView;
/** 闪光灯 */
@property (nonatomic, strong) UIButton *flashlightBtn;

@end

@implementation QRCodeScanningViewController

- (void)dealloc {
    NSLog(@"%@ - dealloc",self.class);
}

#pragma mark - lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupQRCodeScanning];
    [self.view addSubview:self.scanningView];
    [self.scanningView addSubview:self.flashlightBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [self.manager startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

#pragma mark - private

- (void)setupNavigationBar {
    self.navigationItem.title = @"扫一扫";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
}

- (void)setupQRCodeScanning {
    self.manager = [AYQRCodeScanManager shareQRCodeScanManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    _manager.delegate = self;
}

- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
    [self.manager videoPreviewLayerRemoveFromSuperlayer];
}

- (void)flashlightBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.manager openFlashlight];
    } else {
        [self.manager closeFlashlight];
    }
}

- (void)rightBarButtonItenAction {
    AYQRCodeAlbumManager *manager = [AYQRCodeAlbumManager shareQRCodeAlbumManager];
    [manager readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
}

#pragma mark - getter
- (AYQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[AYQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        _scanningView.scanningImageName = @"QRCodeScanningLineGrid";
//        _scanningView.scanningAnimationStyle = ScanningAnimationStyleGrid;
//        _scanningView.cornerColor = [UIColor orangeColor];
//        _scanningView.cornerLocation = CornerLoactionOutside;
    }
    return _scanningView;
}

- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        _flashlightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 150, 60, 60)];
        [_flashlightBtn setImage:[UIImage imageNamed:@"QRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setImage:[UIImage imageNamed:@"QRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _flashlightBtn;
}

#pragma mark - - - QRCodeScanManagerDelegate

- (void)QRCodeScanManager:(AYQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager palySoundName:@"sound.caf"];
        [scanManager stopRunning];
//        [scanManager videoPreviewLayerRemoveFromSuperlayer];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"stringValue: %@",obj.stringValue);
        
        QRCodeScanningSuccessVC *vc = [[QRCodeScanningSuccessVC alloc] init];
        vc.urlString = obj.stringValue;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(AYQRCodeAlbumManager *)albumManager {
    NSLog(@"取消");
}
- (void)QRCodeAlbumManager:(AYQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    NSLog(@"result: %@",result);
    
    if (result) {
        [self.manager stopRunning];
        QRCodeScanningSuccessVC *vc = [[QRCodeScanningSuccessVC alloc] init];
        vc.urlString = result;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"未能识别");
    }
}

@end
