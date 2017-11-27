//
//  TwoViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/21.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "TwoViewController.h"
#import "UITableViewCell+FastCell.h"
#import <Masonry/Masonry.h>
#import "NetworkRequest.h"
#import "TwoModel.h"
#import <MJRefresh/MJRefresh.h>
#import "NetworkCache.h"


@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <TwoModel *> *dataSource;
@property (nonatomic, assign) NSInteger page;

@end

@implementation TwoViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    if (self.contentChanged) {
        self.contentChanged();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    NSDictionary *dic = @{
                          @"requestCode":@"10012",
                          @"user_id":@"110430",
                          @"limit":@"5",
                          @"page":page,
                          };
    
    [NetWorkRequest requestAnalysListWithParameters:dic responseCaches:^(TwoModel *model) {
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
        if (self.contentChanged) {
            self.contentChanged();
        }
        [self.tableView reloadData];
    } success:^(TwoModel *model) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            if ([model success]) {
                self.dataSource = [model.responseResultList mutableCopy];
            }
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            if ([model success]) {
                if (model.responseResultList.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.dataSource addObjectsFromArray:[model.responseResultList mutableCopy]];
                }
            }
        }
        if (self.contentChanged) {
            self.contentChanged();
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (self.contentChanged) {
            self.contentChanged();
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    TwoModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"test -- %@",model.name];
    cell.textLabel.numberOfLines = 0;
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
//            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
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
