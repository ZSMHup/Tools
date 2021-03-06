//
//  NavigationController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NavigationController.h"
#import "NavigationControllerTest1.h"
#import "NavigationControllerTest3.h"
#import "UITableViewCell+FastCell.h"
#import "CAKeyframeAnimationController.h"

@interface NavigationController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(saveToCameraRoll)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [self addTableView];
}

- (void)saveToCameraRoll {
    NavigationControllerTest1 *t1 = [[NavigationControllerTest1 alloc] init];
    [self.navigationController pushViewController:t1 animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"CABasicAnimation基础动画";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"CAKeyframeAnimation基础动画";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NavigationControllerTest3 *test3 = [[NavigationControllerTest3 alloc] init];
        [self.navigationController pushViewController:test3 animated:YES];
    } else if (indexPath.row == 1) {
        CAKeyframeAnimationController *test4 = [[CAKeyframeAnimationController alloc] init];
        [self.navigationController pushViewController:test4 animated:YES];
    }
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0 ,*)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        [self.view addSubview:_tableView];
    }
}


@end
