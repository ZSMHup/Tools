//
//  SCVideoPlayerViewController.m
//  SCRecorderT
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "SCVideoPlayerViewController.h"
#import "SCEditVideoViewController.h"
#import "SCWatermarkOverlayView.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface SCVideoPlayerViewController ()

@property (nonatomic, strong) SCAssetExportSession *exportSession;
@property (nonatomic, strong) SCPlayer *player;

@end

@implementation SCVideoPlayerViewController

- (void)dealloc {
    [self.filterSwitcherView removeObserver:self forKeyPath:@"selectedFilter"];
    self.filterSwitcherView = nil;
    if (_player) {
        [_player pause];
        _player = nil;
    }
    
    [self cancelSaveToCameraRoll];
}

#pragma mark - lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_recordSession.segments.count > 0) {
        [_player setItemByAsset:_recordSession.assetRepresentingSegments];
        [_player play];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_player pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

#pragma mark - private

- (void)setupUI {
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveToCameraRoll)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(startMediaBrowser)];
    self.navigationItem.rightBarButtonItems = @[saveButton, addButton];
    
    [self addFilterSwitcherView];
    [self addEditVideo];
    [self addExportView];
    [self addFilterNameLabel];
    [self addSaveLabel];
    [self addIndicatorView];
    [self addProgressView];
    
    _player = [SCPlayer player];
    if ([[NSProcessInfo processInfo] activeProcessorCount] > 1) {
        self.filterSwitcherView.contentMode = UIViewContentModeScaleAspectFill;
        SCFilter *emptyFilter = [SCFilter emptyFilter];
        emptyFilter.name = @"#nofilter";
        
        self.filterSwitcherView.filters = @[
                                            emptyFilter,
                                            [SCFilter filterWithCIFilterName:@"CIPhotoEffectNoir"],
                                            [SCFilter filterWithCIFilterName:@"CIPhotoEffectChrome"],
                                            [SCFilter filterWithCIFilterName:@"CIPhotoEffectInstant"],
                                            [SCFilter filterWithCIFilterName:@"CIPhotoEffectTonal"],
                                            [SCFilter filterWithCIFilterName:@"CIPhotoEffectFade"],
                                            // Adding a filter created using CoreImageShop
                                            [SCFilter filterWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"a_filter" withExtension:@"cisf"]],
                                            [self createAnimatedFilter]
                                            ];
        _player.SCImageView = self.filterSwitcherView;
        [self.filterSwitcherView addObserver:self forKeyPath:@"selectedFilter" options:NSKeyValueObservingOptionNew context:nil];
    } else {
        SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
        playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        playerView.frame = self.filterSwitcherView.frame;
        playerView.autoresizingMask = self.filterSwitcherView.autoresizingMask;
        [self.filterSwitcherView.superview insertSubview:playerView aboveSubview:self.filterSwitcherView];
        [self.filterSwitcherView removeFromSuperview];
    }
    _player.loopEnabled = YES;
}

- (SCFilter *)createAnimatedFilter {
    SCFilter *animatedFilter = [SCFilter emptyFilter];
    animatedFilter.name = @"Animated Filter";

    SCFilter *gaussian = [SCFilter filterWithCIFilterName:@"CIGaussianBlur"];
    SCFilter *blackAndWhite = [SCFilter filterWithCIFilterName:@"CIColorControls"];

    [animatedFilter addSubFilter:gaussian];
    [animatedFilter addSubFilter:blackAndWhite];

    double duration = 0.5;
    double currentTime = 0;
    BOOL isAscending = YES;

    Float64 assetDuration = CMTimeGetSeconds(_recordSession.assetRepresentingSegments.duration);

    while (currentTime < assetDuration) {
        if (isAscending) {
            [blackAndWhite addAnimationForParameterKey:kCIInputSaturationKey startValue:@1 endValue:@0 startTime:currentTime duration:duration];
            [gaussian addAnimationForParameterKey:kCIInputRadiusKey startValue:@0 endValue:@10 startTime:currentTime duration:duration];
        } else {
            [blackAndWhite addAnimationForParameterKey:kCIInputSaturationKey startValue:@0 endValue:@1 startTime:currentTime duration:duration];
            [gaussian addAnimationForParameterKey:kCIInputRadiusKey startValue:@10 endValue:@0 startTime:currentTime duration:duration];
        }

        currentTime += duration;
        isAscending = !isAscending;
    }

    return animatedFilter;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.filterSwitcherView) {
        self.filterNameLabel.hidden = NO;
        self.filterNameLabel.text = self.filterSwitcherView.selectedFilter.name;
        self.filterNameLabel.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.filterNameLabel.alpha = 1;
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.3 delay:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.filterNameLabel.alpha = 0;
                } completion:^(BOOL finished) {
                    
                }];
            }
        }];
    }
}

- (void)assetExportSessionDidProgress:(SCAssetExportSession *)assetExportSession {
    dispatch_async(dispatch_get_main_queue(), ^{
        float progress = assetExportSession.progress;
        CGRect frame =  self.progressView.frame;
        frame.size.width = self.progressView.superview.frame.size.width * progress;
        self.progressView.frame = frame;
    });
}

- (void)saveToCameraRoll {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    SCFilter *currentFilter = [self.filterSwitcherView.selectedFilter copy];
    [_player pause];
    
    SCAssetExportSession *exportSession = [[SCAssetExportSession alloc] initWithAsset:self.recordSession.assetRepresentingSegments];
    exportSession.videoConfiguration.filter = currentFilter;
    exportSession.videoConfiguration.preset = SCPresetHighestQuality;
    exportSession.audioConfiguration.preset = SCPresetHighestQuality;
    exportSession.videoConfiguration.maxFrameRate = 35;
    exportSession.outputUrl = self.recordSession.outputUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.delegate = self;
    exportSession.contextType = SCContextTypeAuto;
    self.exportSession = exportSession;
    
    self.exportView.hidden = NO;
    self.exportView.alpha = 0;
    CGRect frame =  self.progressView.frame;
    frame.size.width = 0;
    self.progressView.frame = frame;

    [UIView animateWithDuration:0.3 animations:^{
        self.exportView.alpha = 1;
    }];
    
    SCWatermarkOverlayView *overlay = [SCWatermarkOverlayView new];
    overlay.date = self.recordSession.date;
    exportSession.videoConfiguration.overlay = overlay;
    
    NSLog(@"Starting exporting");
    
    CFTimeInterval time = CACurrentMediaTime();
    __weak typeof(self) wSelf = self;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        __strong typeof(self) strongSelf = wSelf;
        
        if (!exportSession.cancelled) {
            NSLog(@"Completed compression in %fs", CACurrentMediaTime() - time);
        }
        
        if (strongSelf != nil) {
            [strongSelf.player play];
            strongSelf.exportSession = nil;
            strongSelf.navigationItem.rightBarButtonItem.enabled = YES;
            
            [UIView animateWithDuration:0.3 animations:^{
                strongSelf.exportView.alpha = 0;
            }];
        }
        
        NSError *error = exportSession.error;
        if (exportSession.cancelled) {
            NSLog(@"Export was cancelled");
        } else if (error == nil) {
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            [exportSession.outputUrl saveToCameraRollWithCompletion:^(NSString * _Nullable path, NSError * _Nullable error) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                
                if (error == nil) {
                    [[[UIAlertView alloc] initWithTitle:@"Saved to camera roll" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"Failed to save" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }
            }];
        } else {
            if (!exportSession.cancelled) {
                [[[UIAlertView alloc] initWithTitle:@"Failed to save" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
        }
    }];
}

- (void)cancelSaveToCameraRoll {
    [self.exportSession cancelExport];
}

#pragma mark - event response

- (void)editVideoClick {
    SCEditVideoViewController *edit = [[SCEditVideoViewController alloc] init];
    edit.recordSession = self.recordSession;
    [self.navigationController pushViewController:edit animated:YES];
}

- (BOOL)startMediaBrowser {
    //Validations
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
        return NO;
    }
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = self;
    
    [self presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSURL *url = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    SCRecordSessionSegment *segment = [SCRecordSessionSegment segmentWithURL:url info:nil];
    
    [_recordSession addSegment:segment];
}


#pragma mark - getter
- (void)addFilterSwitcherView {
    if (!_filterSwitcherView) {
        _filterSwitcherView = [[SCSwipeableFilterView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_filterSwitcherView];
    }
}

- (void)addEditVideo {
    if (!_editVideo) {
        _editVideo = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 70, 100, 30)];
        [_editVideo setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editVideo setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_editVideo addTarget:self action:@selector(editVideoClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_editVideo];
    }
}

- (void)addExportView {
    if (!_exportView) {
        _exportView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 80, self.view.frame.size.height / 2 - 65, 160, 130)];
        _exportView.backgroundColor = [UIColor blackColor];
        _exportView.hidden = YES;
        _exportView.clipsToBounds = YES;
        _exportView.layer.cornerRadius = 20;
        [self.view addSubview:_exportView];
    }
}

- (void)addProgressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.exportView.frame.size.width, 50)];
        _progressView.backgroundColor = [UIColor redColor];
        [self.exportView addSubview:_progressView];
    }
}

-(void)addFilterNameLabel {
    if (!_filterNameLabel) {
        _filterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 20, self.view.frame.size.width, 40)];
        _filterNameLabel.textAlignment = NSTextAlignmentCenter;
        _filterNameLabel.textColor = [UIColor whiteColor];
        _filterNameLabel.hidden = YES;
        [self.view addSubview:_filterNameLabel];
    }
}

- (void)addIndicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.exportView.frame.size.width / 2 - 10, self.exportView.frame.size.height / 2 - 15, 20, 20)];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [_indicatorView startAnimating];
        [self.exportView addSubview:_indicatorView];
    }
}

- (void)addSaveLabel {
    if (!_saveLabel) {
        _saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.exportView.frame.size.width, 36)];
        _saveLabel.textAlignment = NSTextAlignmentCenter;
        _saveLabel.textColor = [UIColor whiteColor];
        _saveLabel.text = @"保存中...";
        [self.exportView addSubview:_saveLabel];
    }
}


@end
