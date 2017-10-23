//
//  NavigationControllerTest2.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NavigationControllerTest2.h"
#import "UITableViewCell+FastCell.h"
#import "AlertView.h"
@interface NavigationControllerTest2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NavigationControllerTest2

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavTransparent:NO];
    [self setNavBlackLine:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setNavTransparent:NO];
    [self setNavBlackLine:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    
    UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    titleBtn.backgroundColor = [UIColor redColor];
    [titleBtn setTitle:@"title" forState:(UIControlStateNormal)];
    [titleBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = titleBtn;
    
}

- (void)titleBtnClick {
    [AlertView showAlertViewWithTitle:@"title" block:^(NSInteger index) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",indexPath.row];
    return cell;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:(UITableViewStylePlain)];
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
