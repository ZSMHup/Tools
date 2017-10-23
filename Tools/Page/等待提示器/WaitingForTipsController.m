//
//  WaitingForTipsController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "WaitingForTipsController.h"
#import "UITableViewCell+FastCell.h"
#import "SVProgressHUDController.h"

@interface WaitingForTipsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WaitingForTipsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"SVProgressHUD";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SVProgressHUDController *sv = [[SVProgressHUDController alloc] init];
        [self.navigationController pushViewController:sv animated:YES];
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
