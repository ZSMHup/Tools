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

@interface NavigationControllerTest1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NavigationControllerTest1

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavTransparent:YES];
    [self setNavBlackLine:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setNavTransparent:YES];
    [self setNavBlackLine:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(saveToCameraRoll)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [self addTableView];
    
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
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",indexPath.row];
    return cell;
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
