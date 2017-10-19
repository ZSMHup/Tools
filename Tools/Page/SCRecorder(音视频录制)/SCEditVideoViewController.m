//
//  SCEditVideoViewController.m
//  SCRecorderT
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "SCEditVideoViewController.h"

@interface SCEditVideoViewController () {
    NSMutableArray *_thumbnails;
    NSInteger _currentSelected;
}

@end

@implementation SCEditVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStylePlain target:self action:@selector(deletePressed:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [self.view addSubview:self.videoPlayerView];
    [self.view addSubview:self.scrollView];
    
    self.videoPlayerView.tapToPauseEnabled = YES;
    self.videoPlayerView.player.loopEnabled = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray *thumbnails = [NSMutableArray new];
    NSInteger i = 0;
    
    for (SCRecordSessionSegment *segment in self.recordSession.segments) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = segment.thumbnail;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedVideo:)];
        imageView.userInteractionEnabled = YES;
        
        [imageView addGestureRecognizer:tapGesture];
        
        [thumbnails addObject:imageView];
        
        [self.scrollView addSubview:imageView];
        
        i++;
    }
    
    _thumbnails = thumbnails;
    [self reloadScrollView];
    [self showVideo:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.videoPlayerView.player pause];
}

- (void)reloadScrollView {
    CGFloat cellSize = self.scrollView.frame.size.height;
    int i = 0;
    for (UIImageView *imageView in _thumbnails) {
        imageView.frame = CGRectMake(cellSize * i, 0, cellSize, cellSize);
        i++;
    }
    self.scrollView.contentSize = CGSizeMake(_thumbnails.count * self.scrollView.frame.size.height, self.scrollView.frame.size.height);
}

- (void)touchedVideo:(UITapGestureRecognizer *)gesture {
    NSInteger idx = [_thumbnails indexOfObject:gesture.view];
    
    [self showVideo:idx];
}

- (void)showVideo:(NSInteger)idx {
    if (idx < 0) {
        idx = 0;
    }
    
    if (idx < _recordSession.segments.count) {
        SCRecordSessionSegment *segment = [_recordSession.segments objectAtIndex:idx];
        [self.videoPlayerView.player setItemByAsset:segment.asset];
        [self.videoPlayerView.player play];
    }
    
    _currentSelected = idx;
    
    for (NSInteger i = 0; i < _thumbnails.count; i++) {
        UIImageView *imageView = [_thumbnails objectAtIndex:i];
        
        imageView.alpha = i == idx ? 1 : 0.5;
    }
}

- (void)deletePressed:(id)sender {
    if (_currentSelected < _recordSession.segments.count) {
        [_recordSession removeSegmentAtIndex:_currentSelected deleteFile:YES];
        UIImageView *imageView = [_thumbnails objectAtIndex:_currentSelected];
        [_thumbnails removeObjectAtIndex:_currentSelected];
        [UIView animateWithDuration:0.3 animations:^{
            imageView.transform = CGAffineTransformMakeScale(0, 0);
            [self reloadScrollView];
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
        
        [self showVideo:_currentSelected % _recordSession.segments.count];
    }
}

- (SCVideoPlayerView *)videoPlayerView {
    if (!_videoPlayerView) {
        _videoPlayerView = [[SCVideoPlayerView alloc] init];
        _videoPlayerView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 224);
    }
    return _videoPlayerView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150)];
    }
    return _scrollView;
}

@end
