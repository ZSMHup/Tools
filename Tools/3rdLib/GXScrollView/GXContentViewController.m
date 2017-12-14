//
//  GXContentViewController.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/19.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXContentViewController.h"

#import "GXConfigConst.h"

@interface GXContentViewController () <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *position;

@end

@implementation GXContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMessage:) name:gx_kScrollToTopNotificationName object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification
- (void)acceptMessage:(NSNotification *)sender
{
    NSString *notificationName = sender.name;
    if ([notificationName isEqualToString:gx_kScrollToTopNotificationName]) {
        NSDictionary *userInfo = sender.userInfo;
        BOOL canScroll = [userInfo[gx_kCanScrollKey] boolValue];
        self.orientation = userInfo[gx_kOrientationKey];
        self.position = userInfo[gx_kPositionKey];
        self.canScroll = canScroll;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        if ([self.orientation isEqualToString:@"up"]) {
            if (![self.position isEqualToString:@"top"]) {
                scrollView.contentOffset = CGPointZero;
                self.canScroll = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:gx_kLeaveFromTopNotificationName object:nil userInfo:@{gx_kCanScrollKey: @YES}];
            }
        }
        if ([self.position isEqualToString:@"top"]) {
            if ([self.orientation isEqualToString:@"down"]) {
                scrollView.contentOffset = CGPointZero;
                self.canScroll = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:gx_kLeaveFromTopNotificationName object:nil userInfo:@{gx_kCanScrollKey: @YES}];
            }
        }
    }
}

@end
