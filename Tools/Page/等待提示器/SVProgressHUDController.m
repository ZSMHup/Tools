//
//  SVProgressHUDController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "SVProgressHUDController.h"
#import "UITableViewCell+FastCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUDController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SVProgressHUDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSV)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)dismissSV {
    [SVProgressHUD dismiss];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"show";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"showProgress";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"showWithStatus";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"showImage";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"showInfoWithStatus";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"showSuccessWithStatus";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"showErrorWithStatus";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [SVProgressHUD show];
    } else if (indexPath.row == 1) {
        [SVProgressHUD showProgress:3.0];
    } else if (indexPath.row == 2) {
        [SVProgressHUD showWithStatus:@"showWithStatus"];
    } else if (indexPath.row == 3) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"capture_flip"] status:@"showImage"];
    } else if (indexPath.row == 4) {
        [SVProgressHUD showInfoWithStatus:@"xxxxx."];
    } else if (indexPath.row == 5) {
        [SVProgressHUD showSuccessWithStatus:@"Success!"];
    } else if (indexPath.row == 6) {
        [SVProgressHUD showErrorWithStatus:@"Error"];
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
