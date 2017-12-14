//
//  PageViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/12.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "PageViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"

#import "SwitchVCContentView.h"
#import "GXPageScrollView.h"
#import "GXTabScrollView.h"

#import <Masonry/Masonry.h>

@interface PageViewController ()<GXPageScrollViewDataSource, GXPageScrollViewDelegate>

@property (nonatomic, strong) GXPageScrollView *pageScrollView;
@property (nonatomic, strong) GXTabScrollView *tabScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) SwitchVCContentView *contentView;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.contentView];
    [self tys_addChildViewControllers];
    [self tys_addSubviews];
}

#pragma mark - private
- (void)tys_addSubviews
{
    self.navigationItem.title = @"我的下载";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.pageScrollView];
    [self.pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)tys_addChildViewControllers
{
    FirstViewController *myDownloadAudioVC = [[FirstViewController alloc] init];
    myDownloadAudioVC.view.frame = self.view.frame;
    [self addChildViewController:myDownloadAudioVC];
    
    SecondViewController *myDownloadDataVC = [[SecondViewController alloc] init];
    myDownloadDataVC.view.frame = self.view.frame;
    [self addChildViewController:myDownloadDataVC];
    
//    ThirdViewController *myDownloadDemoDocVC = [[ThirdViewController alloc] init];
//    myDownloadDemoDocVC.view.frame = self.view.frame;
//    [self addChildViewController:myDownloadDemoDocVC];
}

#pragma mark - GXPageScrollViewDataSource
- (NSUInteger)numberOfItemsInPageScrollView:(GXPageScrollView *)pageScrollView
{
    return self.childViewControllers.count;
}

- (UIView *)pageScrollView:(GXPageScrollView *)pageScrollView contentViewForIndex:(NSUInteger)index
{
    BaseViewController *contentVC = self.childViewControllers[index];
    return contentVC.view;
}

- (NSString *)pageScrollView:(GXPageScrollView *)pageScrollView titleForItemAtIndex:(NSUInteger)index
{
    return self.titles[index];
}

//- (NSUInteger)numberOfItemsInPageScrollView:(GXTabScrollView *)pageScrollView {
//    return self.childViewControllers.count;
//}
//
//- (UIScrollView *)tabScrollView:(GXTabScrollView *)tabScrollView scrollViewForIndex:(NSUInteger)index {
//    PageViewController *firstContentVC = self.childViewControllers[index];
//
//    return firstContentVC.tableView;
//}
//
//- (NSString *)tabScrollView:(GXTabScrollView *)tabScrollView titleForItemAtIndex:(NSUInteger)index {
//    return self.titles[index];
//}

#pragma mark - getter
- (GXPageScrollView *)pageScrollView
{
    if (!_pageScrollView) {
        _pageScrollView = [[GXPageScrollView alloc] init];
        _pageScrollView.lineHidden = YES;
        _pageScrollView.dataSource = self;
        _pageScrollView.delegate = self;
        _pageScrollView.animated = YES;
    }
    return _pageScrollView;
}

//- (GXTabScrollView *)pageScrollView
//{
//    if (!_tabScrollView) {
//        _tabScrollView = [[GXTabScrollView alloc] init];
//        _tabScrollView.dataSource = self;
//        _tabScrollView.delegate = self;
//    }
//    return _tabScrollView;
//}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"回放", @"下载资料"];
    }
    return _titles;
}

//- (SwitchVCContentView *)contentView {
//    if (!_contentView) {
//        NSArray *controllers = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourViewController"];
//        _contentView = [[SwitchVCContentView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 200) titleArray:@[@"000",@"1111",@"22",@"33333"] controllersArray:controllers];
//    }
//    return _contentView;
//}

//- (UIView *)headView {
//    if (!_headView) {
//        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//        _headView.backgroundColor = [UIColor redColor];
//    }
//    return _headView;
//}

@end
