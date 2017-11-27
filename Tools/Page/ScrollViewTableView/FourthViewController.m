//
//  FourthViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/22.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "FourthViewController.h"
#import "UITableViewCell+FastCell.h"
#import <Masonry/Masonry.h>

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"test - %ld",indexPath.row];
    return cell;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        self.scrollview = _tableView;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

@end
