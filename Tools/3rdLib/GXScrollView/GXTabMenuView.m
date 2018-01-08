//
//  GXTabMenuView.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXTabMenuView.h"
#import "GXTabMenuCell.h"

#define gx_kScreenWidth [UIScreen mainScreen].bounds.size.width

CGFloat const GXTabMenuHeight = 50.f;
CGFloat const GXTabMenuTitleMaxLength = 120.f;
CGFloat const GXTabMenuTitleOffset = 20.f;

@interface GXTabMenuView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *titleWidthArray;
@property (nonatomic, strong) NSArray<NSIndexPath *> *showBadgeIndexPaths;
@property (nonatomic, assign) CGFloat totalWidth;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation GXTabMenuView

- (instancetype)initWithTitles:(NSArray *)titles
{
    CGRect defaultFrame = CGRectMake(0, 0, gx_kScreenWidth, GXTabMenuHeight);
    self = [super initWithFrame:defaultFrame];
    if (self) {
        _titles = titles;
        [self gx_configDataSource];
        [self gx_configTitleWidth];
        [self gx_addSubviews];
    }
    return self;
}

- (void)gx_addSubviews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(60, GXTabMenuHeight);
    flowLayout.minimumLineSpacing = 30;
    flowLayout.minimumInteritemSpacing = 30;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 24, 0, 24);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, gx_kScreenWidth, GXTabMenuHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *cellId = [NSString stringWithFormat:@"GXTabMenuCell_%ld", idx];
        [_collectionView registerClass:[GXTabMenuCell class] forCellWithReuseIdentifier:cellId];
    }];

    [self addSubview:_collectionView];

    if (_titles.count > 0) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }

    CALayer *line = [[CALayer alloc] init];
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
    line.frame = CGRectMake(0, GXTabMenuHeight - 1, gx_kScreenWidth, 1);
    [self.layer addSublayer:line];
}

- (void)gx_configDataSource
{
    [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GXTabMenuModel *model = [[GXTabMenuModel alloc] init];
        model.title = obj;
        model.titleNormalColor = [UIColor lightGrayColor];
        model.titleSelectedColor = [UIColor redColor];
        model.backgroundLayerColor = [UIColor clearColor];
        model.underlineColor = [UIColor redColor];
        [self.dataSource addObject:model];
    }];
}

- (void)gx_configTitleWidth
{
    _titleWidthArray = [NSMutableArray array];
    [_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect titleFrame = [obj boundingRectWithSize:CGSizeMake(GXTabMenuTitleMaxLength, GXTabMenuHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
        _totalWidth += (titleFrame.size.width + GXTabMenuTitleOffset);
        [_titleWidthArray addObject:@(titleFrame.size.width + GXTabMenuTitleOffset)];
    }];
}

#pragma mark - public
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    if (self.currentIndex == index) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    self.currentIndex = index;
}

- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    self.showBadgeIndexPaths = indexPaths;
    [self.collectionView reloadData];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [NSString stringWithFormat:@"GXTabMenuCell_%ld", indexPath.item];
    GXTabMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.item]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXTabMenuModel *model = self.dataSource[self.currentIndex];
    model.deselectDisabled = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXTabMenuModel *model = self.dataSource[self.currentIndex];
    model.deselectDisabled = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex == indexPath.item) {
        return;
    }

    self.currentIndex = indexPath.item;
    if (self.didSelectItemHandler) {
        self.didSelectItemHandler(indexPath.item);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXTabMenuModel *model = self.dataSource[indexPath.item];
    return CGSizeMake(model.title.length * 15, GXTabMenuHeight);
}

#pragma mark - getter
- (void)setTabMenuBackgroundColor:(UIColor *)tabMenuBackgroundColor
{
    _collectionView.backgroundColor = tabMenuBackgroundColor ?: [UIColor whiteColor];
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end

