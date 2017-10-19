//
//  SCEditVideoViewController.h
//  SCRecorderT
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "BaseViewController.h"

#import "SCRecorder.h"

@interface SCEditVideoViewController : BaseViewController

@property (strong, nonatomic) SCRecordSession *recordSession;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) SCVideoPlayerView *videoPlayerView;

- (void)deletePressed:(id)sender;

@end
