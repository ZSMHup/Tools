//
//  SwitchVCContentView.m
//  Tools
//
//  Created by 张书孟 on 2017/12/12.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "SwitchVCContentView.h"
#import "BaseViewController.h"
#import "TabPageView.h"

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height
#define tabHeight 50

@interface SwitchVCContentView ()<UIScrollViewDelegate>

@property (nonatomic, strong) TabPageView *tabPageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *controllersArray;
@property (nonatomic, strong) NSMutableArray *controllers;

@end

@implementation SwitchVCContentView

- (void)dealloc {
    [self removeFromSuperview];
    [self.controllers removeAllObjects];
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray controllersArray:(NSArray *)controllersArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titleArray;
        self.controllersArray = controllersArray;
        [self addTabPageView];
        [self addScrollView];
        [self scrollViewDidEndScrollingAnimation:self.scrollView];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    self.tabPageView.selectedIndex = index;
    NSString *vc = self.controllersArray[index];
    
    self.tabPageView.userInteractionEnabled = YES;
    if ([self.controllers containsObject: vc]) return;
    UIViewController *willShowVc = [[NSClassFromString(vc) alloc] init];
    if ([willShowVc isViewLoaded]) return;
    [self.controllers addObject:vc];
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}
/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - getter
- (void)addTabPageView {
    if (!_tabPageView) {
        _tabPageView = [[TabPageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, tabHeight) titleArray:self.titleArray];
        __weak typeof(self) weakSelf = self;
        _tabPageView.index = ^(NSInteger index) {
            weakSelf.tabPageView.userInteractionEnabled = NO;
            if (index >= self.controllersArray.count) return ;
            if (weakSelf.scrollView) {
                CGPoint offset = weakSelf.scrollView.contentOffset;
                offset.x = index * weakSelf.scrollView.frame.size.width;
                [weakSelf.scrollView setContentOffset:offset animated:YES];
            }
        };
        [self addSubview:_tabPageView];
    }
}

- (void)addScrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tabHeight, kWidth, kHeight - tabHeight - 64)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(kWidth * self.controllersArray.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] init];
    }
    return _titleArray;
}

- (NSArray *)controllersArray {
    if (!_controllersArray) {
        _controllersArray = [[NSArray alloc] init];
    }
    return _controllersArray;
}
- (NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return _controllers;
}


@end
