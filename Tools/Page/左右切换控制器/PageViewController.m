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
#import "GXTabScrollView.h"

#import <Masonry/Masonry.h>

#define kHeaderTableViewHeight 140.0f

@interface PageViewController ()<UITableViewDelegate, UITableViewDataSource, GXTabScrollViewDataSource>

@property (nonatomic, strong) UITableView *headerTableView;
@property (nonatomic, strong) GXTabScrollView *tabScrollView;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tys_addSubviews];
}

#pragma mark - private
- (void)tys_addSubviews
{
    self.navigationItem.title = @"我的下载";
    
    [self tys_addChildViewControllers];
    
    
}

- (void)tys_addChildViewControllers
{
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.view.frame = self.view.frame;
    [self addChildViewController:firstVC];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.view.frame = self.view.frame;
    [self addChildViewController:secondVC];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    thirdVC.view.frame = self.view.frame;
    [self addChildViewController:thirdVC];
    
    [self.view addSubview:self.tabScrollView];
    [self.tabScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
//    self.tabScrollView.headerView = self.headerTableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark - GXTabScrollViewDataSource
- (NSUInteger)numberOfItemsInPageScrollView:(GXTabScrollView *)pageScrollView
{
    return self.childViewControllers.count;
}

- (NSString *)tabScrollView:(GXTabScrollView *)tabScrollView titleForItemAtIndex:(NSUInteger)index
{
    return self.titles[index];
}

- (UIView *)tabScrollView:(GXTabScrollView *)tabScrollView scrollViewForIndex:(NSUInteger)index
{
    if (0 == index) {
        FirstViewController *recReadingVC = self.childViewControllers[index];
        return recReadingVC.tableView;
    } else if (1 == index) {
        SecondViewController *roadShowVC = self.childViewControllers[index];
        return roadShowVC.tableView;
    } else {
        ThirdViewController *thirdVC = self.childViewControllers[index];
        return thirdVC.tableView;
    }
}

#pragma mark - getter
- (GXTabScrollView *)tabScrollView
{
    if (!_tabScrollView) {
        _tabScrollView = [[GXTabScrollView alloc] init];
        _tabScrollView.dataSource = self;
//        _tabScrollView.delegate  = self;
        _tabScrollView.backgroundColor = [UIColor redColor];
    }
    return _tabScrollView;
}

- (UITableView *)headerTableView
{
    if (!_headerTableView) {
        _headerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, kHeaderTableViewHeight) style:UITableViewStylePlain];
        _headerTableView.dataSource = self;
        _headerTableView.delegate = self;
        _headerTableView.backgroundColor = [UIColor orangeColor];
//        _headerTableView.estimatedRowHeight = 50.f;
        _headerTableView.estimatedSectionHeaderHeight = 0.f;
        _headerTableView.estimatedSectionFooterHeight = 0.f;
        _headerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _headerTableView.scrollEnabled = NO;
        [_headerTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _headerTableView;
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"回放", @"下载资料", @"下载资料"];
    }
    return _titles;
}

@end
