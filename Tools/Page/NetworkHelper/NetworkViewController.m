//
//  NetworkViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkViewController.h"
#import "UITableViewCell+FastCell.h"
#import <Masonry/Masonry.h>
#import "NetworkRequest.h"
#import "LiveListModel.h"
#import <MJRefresh/MJRefresh.h>
#import "NetworkCache.h"
#import <AYProgressHUD/AYProgressHUD.h>

@interface NetworkViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LiveListModel *> *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    NSDictionary *dic = @{
                          @"requestCode":@"80003",
                          @"user_id":@"110430",
                          @"type":@"2",
                          @"limit":@"10",
                          @"page":page,
                          @"q_t":@"2",
                          };
    [AYProgressHUD showNetWorkLoading];
    [NetWorkRequest requestLiveListWithParameters:dic responseCaches:^(LiveListModel *model) {
        if ([self.tableView.mj_header isRefreshing]) {
            if ([model success]) {
                self.dataSource = [model.responseResultList mutableCopy];
            }
        } else {
            if ([model success]) {
                [self.dataSource addObjectsFromArray:[model.responseResultList mutableCopy]];
            }
        }
        [self.tableView reloadData];
    } success:^(LiveListModel *model) {
        [AYProgressHUD dismiss];
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            if ([model success]) {
                self.dataSource = [model.responseResultList mutableCopy];
            }
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            if ([model success]) {
                [self.dataSource addObjectsFromArray:[model.responseResultList mutableCopy]];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    LiveListModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"test -- %@",model.subject];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell -- %ld", indexPath.row);
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
//        self.view = _tableView;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            [weakSelf loadData];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.page++;
            [weakSelf loadData];
        }];
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


@end
