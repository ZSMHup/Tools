//
//  ViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/9/29.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewCell+FastCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *classDic = self.dataSource[indexPath.row];
    NSString *className = classDic[@"class"];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0 ,*)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        [self.view addSubview:_tableView];
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestClassList" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        _dataSource = [NSMutableArray arrayWithArray:array];
    }
    return _dataSource;
}

@end
