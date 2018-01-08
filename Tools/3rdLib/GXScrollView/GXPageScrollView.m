//
//  GXPageScrollView.m
//  CloudLogistics
//
//  Created by 高翔 on 2017/8/8.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXPageScrollView.h"
#import "GXTabMenuView.h"

#import "GXConfigConst.h"

@interface GXPageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) GXTabMenuView *tabMenuView;
@property (nonatomic, strong) UIScrollView *tabContentView;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSArray *configInfo;

@end

@implementation GXPageScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self gx_addSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadData];
}

#pragma mark - public
- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [_tabMenuView showBadgeAtIndexPaths:indexPaths];
}

- (void)selectItemAtIndex:(NSUInteger)index
{
    [self.tabMenuView didSelectItemAtIndex:index];
    [self.tabContentView setContentOffset:CGPointMake(index * gx_kScreenWidth, 0) animated:self.animated];
}

#pragma mark - private
- (void)gx_addTitleView
{
    if ([self.subviews containsObject:_tabMenuView]) {
        [_tabMenuView removeFromSuperview];
    }
    _tabMenuView = [[GXTabMenuView alloc] initWithTitles:self.titles];
    _tabMenuView.tabMenuBackgroundColor = self.tabMenuBackgroundColor;
    _tabMenuView.tabMenuTitleNormalColor = self.tabMenuTitleNormalColor;
    _tabMenuView.tabMenuTitleSelectedColor = self.tabMenuTitleSelectedColor;
    _tabMenuView.lineHidden = self.lineHidden;
    __weak typeof(self) weakSelf = self;
    _tabMenuView.didSelectItemHandler = ^(NSUInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(pageScrollView:didSelectItemAtIndex:)]) {
            [strongSelf.delegate pageScrollView:strongSelf didSelectItemAtIndex:index];
        }
        [strongSelf.tabContentView setContentOffset:CGPointMake(index * gx_kScreenWidth, 0) animated:strongSelf.animated];
    };
    [self addSubview:_tabMenuView];
}

- (void)gx_addSubviews
{
    if (!_tabContentView) {
        _tabContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, gx_kTabMenuHeight, gx_kScreenWidth, CGRectGetHeight(self.frame) - gx_kTabMenuHeight)];
        _tabContentView.delegate = self;
        _tabContentView.pagingEnabled = YES;
        _tabContentView.bounces = NO;
        _tabContentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_tabContentView];
    }
}

- (void)reloadData
{
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInPageScrollView:)]) {
        count = [self.dataSource numberOfItemsInPageScrollView:self];
    }
    
    if (count > 0) {
        
        [self.titles removeAllObjects];
        NSMutableArray *contentViews = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageScrollView:titleForItemAtIndex:)]) {
                NSString *title = [self.dataSource pageScrollView:self titleForItemAtIndex:i];
                if (title) {
                    [self.titles addObject:title];
                }
            }
            
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageScrollView:contentViewForIndex:)]) {
                UIView *contentView = [self.dataSource pageScrollView:self contentViewForIndex:i];
                if (contentView) {
                    [contentViews addObject:contentView];
                }
            }
        }
        
        CGFloat tabContentOffset = 0;
        if (self.titles.count > 0) {
            tabContentOffset = gx_kTabMenuHeight;
            [self gx_addTitleView];
        }
        _tabContentView.frame = CGRectMake(0, tabContentOffset, gx_kScreenWidth, CGRectGetHeight(self.frame) - tabContentOffset);
        _tabContentView.contentSize = CGSizeMake(gx_kScreenWidth * count, CGRectGetHeight(_tabContentView.bounds));
        
        if (contentViews.count > 0) {
            [_tabContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            [contentViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self gx_addItemView:obj atIndex:idx];
            }];
        }
        [_tabContentView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)gx_addItemView:(UIView *)itemView atIndex:(NSUInteger)index
{
    itemView.frame = CGRectMake(index * gx_kScreenWidth, 0, gx_kScreenWidth, CGRectGetHeight(_tabContentView.frame));
    [_tabContentView addSubview:itemView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageIndex = offsetX / gx_kScreenWidth;
    [_tabMenuView didSelectItemAtIndex:pageIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageScrollView:didScrollToIndex:forState:)]) {
        [self.delegate pageScrollView:self didScrollToIndex:pageIndex forState:GXPageScrollViewScrollStateDidEndDecelerating];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageIndex = offsetX / gx_kScreenWidth;
    
    CGFloat first = floor(offsetX / gx_kScreenWidth);
    CGFloat last = offsetX / gx_kScreenWidth - first;
    
    if (last > 0.5) {
        pageIndex = ceil(offsetX / gx_kScreenWidth);
    }
    
    if (self.currentIndex != pageIndex) {
        if (pageIndex >= self.titles.count) {
            pageIndex = self.titles.count - 1;
        }
        if (pageIndex < 0) {
            pageIndex = 0;
        }
        if (scrollView.isDragging) {
            [_tabMenuView didSelectItemAtIndex:pageIndex];
        }
        self.currentIndex = pageIndex;
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageScrollView:didScrollToIndex:forState:)]) {
            [self.delegate pageScrollView:self didScrollToIndex:pageIndex forState:GXPageScrollViewScrollStateDidScroll];
        }
    }
}

#pragma mark - getter & setter
- (NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

@end
