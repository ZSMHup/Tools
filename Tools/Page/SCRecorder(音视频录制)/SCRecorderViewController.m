//
//  SCRecorderViewController.m
//  SCRecorderT
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SCTouchDetector.h"
#import "SCRecorderViewController.h"
#import "SCVideoPlayerViewController.h"
//#import "SCImageDisplayerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "SCSessionListViewController.h"
#import "SCRecordSessionManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define kVideoPreset AVCaptureSessionPresetHigh

@interface SCRecorderViewController ()<SCRecorderDelegate, UIImagePickerControllerDelegate>
{
    SCRecorder *_recorder;
    UIImage *_photo;
    SCRecordSession *_recordSession;
    UIImageView *_ghostImageView;
}

@property (strong, nonatomic) SCRecorderToolsView *focusView;
@property (strong, nonatomic) UIView *recordView;
@property (strong, nonatomic) UIButton *stopButton;//停止
@property (strong, nonatomic) UIButton *retakeButton;//重置
@property (strong, nonatomic) UIView *previewView;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UILabel *timeRecordedLabel;
@property (strong, nonatomic) UIView *downBar;
@property (strong, nonatomic) UIButton *switchCameraModeButton;
@property (strong, nonatomic) UIButton *reverseCamera;//切换前后摄像头
@property (strong, nonatomic) UIButton *flashModeButton;//闪光灯
@property (strong, nonatomic) UIButton *capturePhotoButton;
@property (strong, nonatomic) UIButton *ghostModeButton;
@property (strong, nonatomic) UIView *toolsContainerView;
@property (strong, nonatomic) UIButton *openToolsButton;

@end

@implementation SCRecorderViewController
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#endif

- (void)dealloc {
    _recorder.previewView = nil;
    NSLog(@"SCRecorderViewController dealloc");
}

#pragma mark - lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareSession];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_recorder previewViewFrameChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_recorder startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_recorder stopRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    [self addPreviewView];
    [self addRecordView];
    [self addStopButton];
    [self addRetakeButton];
    [self addReverseCamera];
    [self addTimeRecordedLabel];
    [self addFlashModeButton];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    _recorder = [SCRecorder recorder];
    _recorder.captureSessionPreset = [SCRecorderTools bestCaptureSessionPresetCompatibleWithAllDevices];
    
    _recorder.delegate = self;
    _recorder.autoSetVideoOrientation = YES;
    UIView *previewView = self.previewView;
    _recorder.previewView = previewView;
    
    self.focusView = [[SCRecorderToolsView alloc] initWithFrame:previewView.bounds];
    self.focusView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    self.focusView.recorder = _recorder;
    [previewView addSubview:self.focusView];
    self.focusView.outsideFocusTargetImage = [UIImage imageNamed:@"capture_flip"];
    
    _recorder.initializeSessionLazily = NO;
    
    NSError *error;
    if (![_recorder prepare:&error]) {
        NSLog(@"Prepare error: %@", error.localizedDescription);
    }
}

#pragma mark - private

- (void)prepareSession {
    if (_recorder.session == nil) {
        SCRecordSession *session = [SCRecordSession recordSession];
        session.fileType = AVFileTypeQuickTimeMovie;
        _recorder.session = session;
    }
    
    [self updateTimeRecordedLabel];
}

- (void)updateTimeRecordedLabel {
    CMTime currentTime = kCMTimeZero;
    
    if (_recorder.session != nil) {
        currentTime = _recorder.session.duration;
    }
    
    self.timeRecordedLabel.text = [NSString stringWithFormat:@"%.2f sec", CMTimeGetSeconds(currentTime)];
}

- (void)showVideo {
    SCVideoPlayerViewController *video = [[SCVideoPlayerViewController alloc] init];
    video.recordSession = _recordSession;
    [self.navigationController pushViewController:video animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark -- SCRecorderDelegate

- (void)recorder:(SCRecorder *)recorder didCompleteSession:(SCRecordSession *)recordSession {
    NSLog(@"didCompleteSession:");
    [self saveAndShowSession:recordSession];
}

- (void)recorder:(SCRecorder *)recorder didAppendVideoSampleBufferInSession:(SCRecordSession *)recordSession {
    [self updateTimeRecordedLabel];
}

#pragma mark - event response
//返回
- (void)btnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//录制结束
- (void)handleTouchDetected:(SCTouchDetector*)touchDetector {
    if (touchDetector.state == UIGestureRecognizerStateBegan) {
        //        _ghostImageView.hidden = YES;
        [_recorder record];
    } else if (touchDetector.state == UIGestureRecognizerStateEnded) {
        [_recorder pause];
    }
}

//点击停止跳到播放页面
- (void)saveAndShowSession:(SCRecordSession *)recordSession {
    [[SCRecordSessionManager sharedInstance] saveRecordSession:recordSession];
    
    _recordSession = recordSession;
    [self showVideo];
}

//停止
- (void)handleStopButtonTapped:(id)sender {
    [_recorder pause:^{
        [self saveAndShowSession:_recorder.session];
    }];
}

//切换前后摄像头
- (void)handleReverseCameraTapped:(id)sender {
    [_recorder switchCaptureDevices];
}

//重置
- (void)handleRetakeButtonTapped:(id)sender {
    SCRecordSession *recordSession = _recorder.session;
    
    if (recordSession != nil) {
        _recorder.session = nil;
        
        // If the recordSession was saved, we don't want to completely destroy it
        if ([[SCRecordSessionManager sharedInstance] isSaved:recordSession]) {
            [recordSession endSegmentWithInfo:nil completionHandler:nil];
        } else {
            [recordSession cancelSession:nil];
        }
    }
    
    [self prepareSession];
}

//闪光灯开／关
- (IBAction)switchFlash:(UIButton *)sender {
    NSString *flashModeString = nil;
    if ([_recorder.captureSessionPreset isEqualToString:AVCaptureSessionPresetPhoto]) {
        switch (_recorder.flashMode) {
            case SCFlashModeAuto:
                flashModeString = @"Flash : Off";
                _recorder.flashMode = SCFlashModeOff;
                break;
            case SCFlashModeOff:
                flashModeString = @"Flash : On";
                _recorder.flashMode = SCFlashModeOn;
                break;
            case SCFlashModeOn:
                flashModeString = @"Flash : Light";
                _recorder.flashMode = SCFlashModeLight;
                break;
            case SCFlashModeLight:
                flashModeString = @"Flash : Auto";
                _recorder.flashMode = SCFlashModeAuto;
                break;
            default:
                break;
        }
    } else {
        switch (_recorder.flashMode) {
            case SCFlashModeOff:
                flashModeString = @"Flash : On";
                _recorder.flashMode = SCFlashModeLight;
                break;
            case SCFlashModeLight:
                flashModeString = @"Flash : Off";
                _recorder.flashMode = SCFlashModeOff;
                break;
            default:
                break;
        }
    }
    
    [self.flashModeButton setTitle:flashModeString forState:UIControlStateNormal];
}

#pragma mark - getter

- (void)addPreviewView {
    if (!_previewView) {
        _previewView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_previewView];
    }
}

- (void)addRecordView {
    if (!_recordView) {
        _recordView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 100, 50)];
        _recordView.backgroundColor = [UIColor redColor];
        [_recordView addGestureRecognizer:[[SCTouchDetector alloc] initWithTarget:self action:@selector(handleTouchDetected:)]];
        [self.view addSubview:_recordView];
    }
}

- (void)addReverseCamera {
    if (!_reverseCamera) {
        _reverseCamera = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 20, 100, 50)];
        [_reverseCamera addTarget:self action:@selector(handleReverseCameraTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_reverseCamera setImage:[UIImage imageNamed:@"capture_flip"] forState:(UIControlStateNormal)];
        [self.view addSubview:_reverseCamera];
    }
}

- (void)addRetakeButton {
    if (!_retakeButton) {
        _retakeButton = [[UIButton alloc] initWithFrame:CGRectMake(110, self.view.frame.size.height - 50, 100, 50)];
        _retakeButton.backgroundColor = [UIColor orangeColor];
        [_retakeButton addTarget:self action:@selector(handleRetakeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_retakeButton setTitle:@"重置" forState:(UIControlStateNormal)];
        [self.view addSubview:_retakeButton];
    }
}

- (void)addStopButton {
    if (!_stopButton) {
        _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(220, self.view.frame.size.height - 50, 100, 50)];
        _stopButton.backgroundColor = [UIColor blueColor];
        [_stopButton addTarget:self action:@selector(handleStopButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_stopButton setTitle:@"停止" forState:(UIControlStateNormal)];
        [self.view addSubview:_stopButton];
    }
}

- (void)addTimeRecordedLabel {
    if (!_timeRecordedLabel) {
        _timeRecordedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 30, 90, 30)];
        _timeRecordedLabel.text = @"0.00 sec";
        _timeRecordedLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:_timeRecordedLabel];
    }
}

- (void)addFlashModeButton {
    if (!_flashModeButton) {
        _flashModeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height / 2, 100, 50)];
        _flashModeButton.backgroundColor = [UIColor greenColor];
        [_flashModeButton addTarget:self action:@selector(switchFlash:) forControlEvents:UIControlEventTouchUpInside];
        [_flashModeButton setTitle:@"闪光灯" forState:(UIControlStateNormal)];
        [self.view addSubview:_flashModeButton];
    }
}




@end
