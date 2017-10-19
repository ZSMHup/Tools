//
//  CyclePagerViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/16.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "CyclePagerViewController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "CyclePagerViewCell.h"

@interface CyclePagerViewController () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation CyclePagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPagerView];
    [self addPageControl];
    [self loadData];
}

- (void)dealloc {
    NSLog(@"CyclePagerViewController dealloc");
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        [datas addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    CyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.imgView.image = [UIImage imageNamed:_datas[index]];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc] init];
    if (_datas.count <= 1) {
        layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
        layout.itemSpacing = 0;
        _pagerView.isInfiniteLoop = NO;
        _pagerView.autoScrollInterval = 0;
    } else {
        layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame) * 0.8, CGRectGetHeight(pageView.frame) * 0.8);
        layout.itemSpacing = 15;
        _pagerView.isInfiniteLoop = YES;
    }
    layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    layout.layoutType = TYCyclePagerTransformLayoutCoverflow;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    NSLog(@"点击了: %ld",index);
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

#pragma mark -- getter

- (void)addPagerView {
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc] init];
        _pagerView.frame = CGRectMake(0, 64, self.view.frame.size.width, 200);
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 1.0;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[CyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
        [self.view addSubview:_pagerView];
    }
}

- (void)addPageControl {
    if (!_pageControl) {
        _pageControl = [[TYPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
        _pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [_pagerView addSubview:_pageControl];
    }
}

@end
