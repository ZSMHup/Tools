//
//  NavigationControllerTest1.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NavigationControllerTest1.h"
#import "NavigationControllerTest2.h"

#import "UITableViewCell+FastCell.h"
#import "NavigationBarBgView.h"

#import <Masonry/Masonry.h>

@interface NavigationControllerTest1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NavigationBarBgView *navView;
@property (nonatomic, strong) UIImageView *headImg;

@end

@implementation NavigationControllerTest1

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavTransparent:YES];
    [self setNavBlackLine:YES];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setNavTransparent:YES];
    [self setNavBlackLine:YES];
}
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(saveToCameraRoll)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.title = @"列表";
    [self addTableView];
    [self addNavView];
}

- (void)saveToCameraRoll {
    NavigationControllerTest2 *t2 = [[NavigationControllerTest2 alloc] init];
    [self.navigationController pushViewController:t2 animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",(long)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.y;
//    NSLog(@"offset: %f", offset);
//    if (offset > 50) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    } else {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    }
    self.navView.alpha = offset / 64;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headImg;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0 ,*)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)addNavView {
    if (!_navView) {
        _navView = [[NavigationBarBgView alloc] init];
        [self.view addSubview:_navView];
    }
}

- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        _headImg.image = [UIImage imageNamed:@"4"];
    }
    return _headImg;
}



@end
