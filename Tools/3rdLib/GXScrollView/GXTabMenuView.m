//
//  GXTabMenuView.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXTabMenuView.h"

#import "GXTabMenuCell.h"

#import "GXConfigConst.h"

@interface GXTabMenuView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CALayer *underline;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *titleWidthArray;
@property (nonatomic, strong) NSMutableArray *titleSelectArray;
@property (nonatomic, strong) NSArray<NSIndexPath *> *showBadgeIndexPaths;
@property (nonatomic, assign) CGFloat totalWidth;

@end

@implementation GXTabMenuView

- (instancetype)initWithTitles:(NSArray *)titles
{
    CGRect defaultFrame = CGRectMake(0, 0, gx_kScreenWidth, gx_kTabMenuHeight);
    self = [super initWithFrame:defaultFrame];
    if (self) {
        _titles = titles;
        [self gx_configTitleWidth];
        [self gx_addSubviews];
    }
    return self;
}

- (void)gx_addSubviews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = gx_kScreenWidth / _titles.count;
    flowLayout.itemSize = CGSizeMake(itemWidth, gx_kTabMenuHeight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, gx_kScreenWidth, gx_kTabMenuHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[GXTabMenuCell class] forCellWithReuseIdentifier:@"GXTabMenuCell"];
    [self addSubview:_collectionView];
    
    _underline = [[CALayer alloc] init];
    _underline.backgroundColor = gx_kTabMenuUnderlineColor.CGColor;
    [self.layer addSublayer:_underline];
    
    if (_titles.count > 0) {
        [self selectItemAtIndex:0];
    }
    
    CALayer *line = [[CALayer alloc] init];
    line.frame = CGRectMake(0, gx_kTabMenuHeight - 0.5, gx_kScreenWidth, 0.5);
    line.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:line];
}

- (void)gx_configTitleWidth
{
    _titleWidthArray = [NSMutableArray array];
    [_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect titleFrame = [obj boundingRectWithSize:CGSizeMake(gx_kTabMenuTitleMaxLength, gx_kTabMenuHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: gx_kTabMenuTitleFont} context:nil];
        _totalWidth += (titleFrame.size.width + gx_kTabMenuTitleOffset);
        [_titleWidthArray addObject:@(titleFrame.size.width + gx_kTabMenuTitleOffset)];
    }];
}

- (void)gx_selectItemAtIndex:(NSUInteger)index
{
    [self.titleSelectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            [self.titleSelectArray replaceObjectAtIndex:idx withObject:@YES];
        }
        else {
            [self.titleSelectArray replaceObjectAtIndex:idx withObject:@NO];
        }
    }];
    [_collectionView reloadData];
}

#pragma mark - public
- (void)selectItemAtIndex:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    GXTabMenuCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"GXTabMenuCell" forIndexPath:indexPath];
    CGRect frame = [self.collectionView convertRect:cell.frame toView:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.underline.frame = CGRectMake(frame.origin.x + (frame.size.width - 61) / 2, 42.5, 61, gx_kTabMenuUnderlineHeight);
    }];
    [self gx_selectItemAtIndex:index];
}

- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    self.showBadgeIndexPaths = indexPaths;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXTabMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GXTabMenuCell" forIndexPath:indexPath];
    if ([self.showBadgeIndexPaths containsObject:indexPath]) {
        cell.showBadge = YES;
    } else {
        cell.showBadge = NO;
    }
    cell.tabMenuTitleSelectedColor = self.tabMenuTitleSelectedColor ?: gx_kTabMenuTitleSelectedColor;
    cell.tabMenuTitleNormalColor = self.tabMenuTitleNormalColor ?: gx_kTabMenuTitleNormalColor;
    cell.lineHidden = self.lineHidden;
    [cell setTitle:self.titles[indexPath.item]];
    [cell setChecked:[self.titleSelectArray[indexPath.item] boolValue]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self selectItemAtIndex:indexPath.item];
    
    if (self.didselectItemAtIndex) {
        self.didselectItemAtIndex(indexPath.item);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.totalWidth < gx_kScreenWidth) {
        CGFloat titleWidth = [self.titleWidthArray[indexPath.item] doubleValue];
        CGFloat offset = (gx_kScreenWidth - self.totalWidth) / self.titles.count;
        return CGSizeMake(titleWidth + offset, gx_kTabMenuHeight);
    }
    CGFloat titleWidth = [self.titleWidthArray[indexPath.item] doubleValue];
    return CGSizeMake(titleWidth, gx_kTabMenuHeight);
}

#pragma mark - getter
- (NSMutableArray *)titleSelectArray
{
    if (!_titleSelectArray) {
        _titleSelectArray = [NSMutableArray array];
        [_titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (0 == idx) {
                [_titleSelectArray addObject:@YES];
            }
            else {
                [_titleSelectArray addObject:@NO];
            }
        }];
    }
    return _titleSelectArray;
}

- (void)setTabMenuBackgroundColor:(UIColor *)tabMenuBackgroundColor
{
    _collectionView.backgroundColor = tabMenuBackgroundColor ?: [UIColor whiteColor];
}

@end
