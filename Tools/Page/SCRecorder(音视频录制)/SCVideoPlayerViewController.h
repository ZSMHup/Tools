//
//  SCVideoPlayerViewController.h
//  SCRecorderT
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "BaseViewController.h"
#import "SCRecorder.h"

@interface SCVideoPlayerViewController : BaseViewController<SCPlayerDelegate, SCAssetExportSessionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) SCRecordSession *recordSession;
@property (nonatomic, strong) SCSwipeableFilterView *filterSwitcherView;
@property (nonatomic, strong) UILabel *filterNameLabel;
@property (nonatomic, strong) UILabel *saveLabel;
@property (nonatomic, strong) UIView *exportView;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIButton *editVideo;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end
