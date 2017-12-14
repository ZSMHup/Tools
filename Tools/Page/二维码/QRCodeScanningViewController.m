//
//  QRCodeScanningViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "QRCodeScanningViewController.h"
#import "QRCodeScanManager.h"
#import "QRCodeScanningView.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeScanningViewController ()<QRCodeScanManagerDelegate>

@property (nonatomic, strong) QRCodeScanManager *manager;
@property (nonatomic, strong) QRCodeScanningView *scanningView;
/** 闪光灯 */
@property (nonatomic, strong) UIButton *flashlightBtn;

@end

@implementation QRCodeScanningViewController

- (void)dealloc {
    NSLog(@"%@ - dealloc",self.class);
    [self removeScanningView];
}

#pragma mark - lifecycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    
    [_manager cancelSampleBufferDelegate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_manager stopRunning];
    [_manager videoPreviewLayerRemoveFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupQRCodeScanning];
    [self.view addSubview:self.scanningView];
    [self addFlashlightBtn];
}

#pragma mark - private
- (void)setupQRCodeScanning {
    self.manager = [QRCodeScanManager shareQRCodeScanManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    //    [manager cancelSampleBufferDelegate];
    _manager.delegate = self;
}

- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)flashlightBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"QRCodeFlashlightCloseImage"] forState:(UIControlStateNormal)];
        [self.manager openFlashlight];
    } else {
        [sender setImage:[UIImage imageNamed:@"QRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [self.manager closeFlashlight];
    }
}

#pragma mark - getter
- (QRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[QRCodeScanningView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        _scanningView.scanningImageName = @"QRCodeScanningLineGrid";
//        _scanningView.scanningAnimationStyle = ScanningAnimationStyleGrid;
//        _scanningView.cornerColor = [UIColor orangeColor];
//        _scanningView.cornerLocation = CornerLoactionOutside;
    }
    return _scanningView;
}

- (void)addFlashlightBtn {
    if (!_flashlightBtn) {
        _flashlightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 150, 60, 60)];
        [_flashlightBtn setImage:[UIImage imageNamed:@"QRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.scanningView addSubview:_flashlightBtn];
    }
}

#pragma mark - - - QRCodeScanManagerDelegate

- (void)QRCodeScanManager:(QRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager palySoundName:@"sound.caf"];
        [scanManager stopRunning];
        [scanManager videoPreviewLayerRemoveFromSuperlayer];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"stringValue: %@",obj.stringValue);
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}












@end
