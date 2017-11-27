//
//  ScrollViewTableviewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/21.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "ScrollViewTableviewController.h"
#import "TCTabSlideView.h"
#import "UITableViewCell+FastCell.h"
#import "NetworkRequestModel.h"
#import "ScrollTableViewCell.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height


@interface ScrollViewTableviewController ()<UITableViewDelegate,UITableViewDataSource,TCTabSlideViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TCTabSlideView *tabSlideView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NetworkRequestModel *baseModel;

@end

@implementation ScrollViewTableviewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baseModel = [[NetworkRequestModel alloc] init];
    [self addTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView];
        cell.textLabel.text = @"123";
        return cell;
    } else {
        ScrollTableViewCell *cell = [ScrollTableViewCell cellWithTableView:tableView];
        __weak typeof(self) weakSelf = self;
        [cell setDataWithModel:self.baseModel callBack:^(CGFloat cellHeight, NSUInteger index) {
            // 处理返回的CellHeight 和 选择了Tab选项卡第几项
            [weakSelf handleScrollCellCallBackWithCurrentIndex:index cellHeight:cellHeight];
        }];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return self.cellHeight;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!section) {
        return .1f;
    }else{
        return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section) {
        return self.tabSlideView;
    }else{
        return nil;
    }
}

#pragma mark - 界面逻辑处理
- (void)handleScrollCellCallBackWithCurrentIndex:(NSUInteger)index cellHeight:(CGFloat)cellHeight{
    [self.tabSlideView changeSelectedItemWithContentOffset:(int)index];
    self.cellHeight = cellHeight;
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

- (void)slideViewDidChanged:(TCTabSlideView *)slideView fromCurrentBtn:(NSInteger)fromTag toSelectedBtn:(NSInteger)toTag{
    ScrollTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell setTabCurrIndex:toTag fromLastIndex:fromTag];
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        [self.view addSubview:_tableView];
    }
}

- (TCTabSlideView *)tabSlideView{
    if (_tabSlideView == nil) {
        _tabSlideView = [[TCTabSlideView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, (50)) titleArr:@[@"标签1",@"标签2",@"标签3",@"标签4"]];
        _tabSlideView.selectedColor = [UIColor blackColor];
        _tabSlideView.normalColor = [UIColor lightGrayColor];
        _tabSlideView.delegate = self;
        _tabSlideView.backgroundColor = [UIColor redColor];
    }
    return _tabSlideView;
}


@end
