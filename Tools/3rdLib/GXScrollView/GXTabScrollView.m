//
//  GXPageScrollView.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/20.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXTabScrollView.h"
#import "GXScrollTableView.h"

#import "GXConfigConst.h"

@interface GXTabScrollView () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, GXScrollTableViewCellDelegate>

@property (nonatomic, strong) GXScrollTableView *tableView;

@property (nonatomic, strong) NSArray *configInfo;

@property (nonatomic, assign) BOOL atTopCanNotMoveTabView;
@property (nonatomic, assign) BOOL atTopCanNotMoveTabViewPre;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, strong) NSArray *indexPaths;

@end

@implementation GXTabScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMessage:) name:gx_kLeaveFromTopNotificationName object:nil];
        _scrollAnimated = YES;
        _orientation = @"";
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public
- (void)reloadData
{
    [[self gx_viewController].childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.view.frame = [self gx_viewController].view.frame;
    }];
    self.configInfo = nil;
    [self gx_addSubviews];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    self.indexPaths = indexPaths;
    [self.tableView reloadData];
}

#pragma mark - private
- (void)gx_addSubviews
{
    if (!_tableView) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
        _tableView = [[GXScrollTableView alloc] initWithFrame:CGRectMake(0, 0, gx_kScreenWidth, CGRectGetHeight(self.frame) + CGRectGetHeight(_tableView.tableHeaderView.frame)) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.allowsSelection = NO;
        _tableView.rowHeight = CGRectGetHeight(self.frame) - gx_kTabMenuOffsetTop;
        [_tableView registerClass:[GXScrollTableViewCell class] forCellReuseIdentifier:@"GXScrollTableViewCell"];
        [self addSubview:_tableView];
    }
    _tableView.tableHeaderView = _headerView ?: [[UIView alloc] initWithFrame:CGRectMake(0, 0, gx_kScreenWidth, gx_kTabMenuOffsetTop + 0.01)];
}

- (UIViewController *)gx_viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - notification
- (void)acceptMessage:(NSNotification *)sender
{
    NSDictionary *userInfo = sender.userInfo;
    self.canScroll = [userInfo[gx_kCanScrollKey] boolValue];
}

#pragma mark - GXScrollTableViewCellDelegate
- (void)scrollTableViewCell:(GXScrollTableViewCell *)cell horizontalScrollToIndex:(NSUInteger)index forState:(GXPageScrollViewHorizontalScrollState)state
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabScrollView:horizontalScrollToIndex:forState:)]) {
        [self.delegate tabScrollView:self horizontalScrollToIndex:index forState:state];
    }
}

- (void)scrollTableViewCell:(GXScrollTableViewCell *)cell didSelectItemAtIndex:(NSUInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabScrollView:didSelectItemAtIndex:)]) {
        [self.delegate tabScrollView:self didSelectItemAtIndex:index];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GXScrollTableViewCell"];
    cell.contentView.frame = CGRectMake(0, 0, gx_kScreenWidth, CGRectGetHeight(self.frame) - gx_kTabMenuOffsetTop);
    cell.delegate = self;
    cell.scrollAnimated = self.scrollAnimated;
    cell.configInfo = self.configInfo;
    [cell showBadgeAtIndexPaths:self.indexPaths];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabScrollView:scrollViewDidScroll:)]) {
        [self.delegate tabScrollView:self scrollViewDidScroll:scrollView];
    }
    
    if (self.lastOffsetY < scrollView.contentOffset.y) {
        self.orientation = @"up";
    }
    if (self.lastOffsetY > scrollView.contentOffset.y) {
        self.orientation = @"down";
    }
    CGFloat tabOffsetY = [self.tableView rectForSection:0].origin.y - gx_kTabMenuOffsetTop;
    CGFloat offsetY = scrollView.contentOffset.y;
    _atTopCanNotMoveTabViewPre = _atTopCanNotMoveTabView;
    if (offsetY >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _atTopCanNotMoveTabView = YES;
    }
    else {
        _atTopCanNotMoveTabView = NO;
    }
    
    if (self.tableView.contentOffset.y <= 0) {
        self.tableView.contentOffset = CGPointMake(0, 0);
        [[NSNotificationCenter defaultCenter] postNotificationName:gx_kScrollToTopNotificationName object:nil userInfo:@{gx_kCanScrollKey: @YES, gx_kOrientationKey: self.orientation, gx_kPositionKey: @"init"}];
    }
    else {
        if (!_atTopCanNotMoveTabView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:gx_kScrollToTopNotificationName object:nil userInfo:@{gx_kCanScrollKey: @NO}];
        }
    }
    
    if (_atTopCanNotMoveTabViewPre != _atTopCanNotMoveTabView) {
        if (!_atTopCanNotMoveTabViewPre && _atTopCanNotMoveTabView) {
            [[NSNotificationCenter defaultCenter] postNotificationName:gx_kScrollToTopNotificationName object:nil userInfo:@{gx_kCanScrollKey: @YES, gx_kOrientationKey: self.orientation, gx_kPositionKey: @"top"}];
            _canScroll = NO;
        }
        if (_atTopCanNotMoveTabViewPre && !_atTopCanNotMoveTabView) {
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastOffsetY = scrollView.contentOffset.y;
}

#pragma mark - getter & setter
- (void)setHeaderView:(UIView *)headerView
{
    if (headerView.frame.size.height <= gx_kTabMenuOffsetTop) {
        CGRect frame = headerView.frame;
        frame.size.height = gx_kTabMenuOffsetTop + 0.01;
        headerView.frame = frame;
    }
    _headerView = headerView;
}

- (NSArray *)configInfo
{
    if (!_configInfo) {
        
        NSUInteger count = 0;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInPageScrollView:)]) {
            count = [self.dataSource numberOfItemsInPageScrollView:self];
        }
        
        if (count > 0) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (int i = 0; i < count; i++) {
                NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
                
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(tabScrollView:titleForItemAtIndex:)]) {
                    NSString *title = [self.dataSource tabScrollView:self titleForItemAtIndex:i];
                    if (title) {
                        [mDic setObject:title forKey:@"title"];
                    }
                }
                
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(tabScrollView:scrollViewForIndex:)]) {
                    UIView *scrollView = [self.dataSource tabScrollView:self scrollViewForIndex:i];
                    if (scrollView) {
                        [mDic setObject:scrollView forKey:@"itemView"];
                    }
                }
                
                [mArr addObject:mDic];
            }
            _configInfo = [mArr copy];
        }
    }
    return _configInfo;
}

@end
