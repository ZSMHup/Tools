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

@interface NetworkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LiveListModel *> *dataSource;
@property (nonatomic, assign) NSInteger page;

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData {
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    NSDictionary *dic = @{
                          @"requestCode":@"80003",
                          @"user_id":@"36720",
                          @"type":@"2",
                          @"limit":@"20",
                          @"page":page,
                          @"q_t":@"2",
                          };
    [NetWorkRequest requestLiveListWithParameters:dic responseCaches:^(LiveListModel *model) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
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
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            if ([model success]) {
                self.dataSource = [model.responseResultList mutableCopy];
            }
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            if (model.responseResultList.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                if ([model success]) {
                    [self.dataSource addObjectsFromArray:[model.responseResultList mutableCopy]];
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
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
    return cell;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.view);
        }];
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_tableView.mj_footer resetNoMoreData];
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
