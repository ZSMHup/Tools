//
//  ParentTableViewCell.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXScrollTableViewCell.h"

#import "GXTabMenuView.h"

#import "GXConfigConst.h"

@interface GXScrollTableViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) GXTabMenuView *tabMenuView;
@property (nonatomic, strong) UIScrollView *tabContentView;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation GXScrollTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - public
- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    [_tabMenuView showBadgeAtIndexPaths:indexPaths];
}

#pragma mark - private
- (void)gx_addSubviews
{
    if (!_tabContentView) {
        _tabContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, gx_kTabMenuHeight, gx_kScreenWidth, CGRectGetHeight(self.contentView.frame) - gx_kTabMenuHeight)];
        _tabContentView.delegate = self;
        _tabContentView.pagingEnabled = YES;
        _tabContentView.bounces = NO;
        _tabContentView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_tabContentView];
    }
}

- (void)gx_addTitleView
{
    _tabMenuView = [[GXTabMenuView alloc] initWithTitles:self.titles];
    __weak typeof(self) weakSelf = self;
    _tabMenuView.didselectItemAtIndex = ^(NSUInteger index) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(scrollTableViewCell:didSelectItemAtIndex:)]) {
            [weakSelf.delegate scrollTableViewCell:weakSelf didSelectItemAtIndex:index];
        }
        [weakSelf.tabContentView setContentOffset:CGPointMake(index * gx_kScreenWidth, 0) animated:weakSelf.scrollAnimated];
    };
    [self.contentView addSubview:_tabMenuView];
}

- (void)gx_addItemView:(UIScrollView *)itemView atIndex:(NSUInteger)index
{
    itemView.frame = CGRectMake(index * gx_kScreenWidth, 0, gx_kScreenWidth, CGRectGetHeight(_tabContentView.frame));
    itemView.alwaysBounceVertical = YES;
    [_tabContentView addSubview:itemView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageIndex = offsetX / gx_kScreenWidth;
    [_tabMenuView selectItemAtIndex:pageIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTableViewCell:horizontalScrollToIndex:forState:)]) {
        [self.delegate scrollTableViewCell:self horizontalScrollToIndex:pageIndex forState:GXPageScrollViewHorizontalScrollStateDidEndDecelerating];
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
            [_tabMenuView selectItemAtIndex:pageIndex];
        }
        self.currentIndex = pageIndex;
        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTableViewCell:horizontalScrollToIndex:forState:)]) {
            [self.delegate scrollTableViewCell:self horizontalScrollToIndex:pageIndex forState:GXPageScrollViewHorizontalScrollStateDidScroll];
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

- (void)setConfigInfo:(NSArray *)configInfo
{
    if (configInfo.count > 0) {
        [self gx_addSubviews];
        [self.titles removeAllObjects];
        _tabContentView.contentSize = CGSizeMake(gx_kScreenWidth * configInfo.count, CGRectGetHeight(_tabContentView.frame));
        [configInfo enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj[@"title"]) {
                [self.titles addObject:obj[@"title"]];
            }
            UIScrollView *tabItemView = obj[@"itemView"];
            [self gx_addItemView:tabItemView atIndex:idx];
        }];
        CGFloat tabContentOffset = 0;
        if (self.titles.count > 0) {
            tabContentOffset = gx_kTabMenuHeight;
            [self gx_addTitleView];
        }
        _tabContentView.frame = CGRectMake(0, tabContentOffset, gx_kScreenWidth, CGRectGetHeight(self.contentView.frame) - tabContentOffset);
    }
}

@end
