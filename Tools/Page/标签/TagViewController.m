//
//  TagViewController.m
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "TagViewController.h"
#import "AYTagCollectionLayout.h"
#import "TagCollectionViewCell.h"
#import "TagAddCollectionViewCell.h"

@interface TagViewController () <UICollectionViewDelegate, UICollectionViewDataSource, AYTagCollectionLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *fakeDataArray;

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fakeDataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.fakeDataArray.count) {
        TagCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollectionViewCell" forIndexPath:indexPath];
        [item setContentString:self.fakeDataArray[indexPath.item]];
        __weak typeof(self) weakSelf = self;
        item.deleteBtnActionBlock = ^{
            [weakSelf.fakeDataArray removeObjectAtIndex:indexPath.item];
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [weakSelf.collectionView performBatchUpdates:^{
                [strongSelf.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            } completion:^(BOOL finished) {
                [strongSelf.collectionView reloadData];
            }];
        };
        return item;
    }
    else {
        TagAddCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagAddCollectionViewCell" forIndexPath:indexPath];
        [item setContentString:@"+ 添加"];
        __weak typeof(self) weakSelf = self;
        item.addBtnActionBlock = ^{
            [weakSelf.fakeDataArray addObject:@"123456789454"];
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [weakSelf.collectionView performBatchUpdates:^{
                [strongSelf.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:strongSelf.fakeDataArray.count - 1 inSection:0]]];
            } completion:^(BOOL finished) {
                [strongSelf.collectionView reloadData];
            }];
        };
        return item;
    }
}

#pragma mark - AYTagCollectionLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(AYTagCollectionLayout *)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.fakeDataArray.count) {
        CGSize size = CGSizeZero;
        size.height = 30.0;
        CGSize tempSize = [self sizeWithString:self.fakeDataArray[indexPath.item] fontSize:14.0];
        size.width = tempSize.width + 20 + 1;
        return size.width;
    }
    else {
        CGSize size = CGSizeZero;
        size.height = 30.0;
        CGSize tempSize = [self sizeWithString:@"+ 添加" fontSize:14.0];
        size.width = tempSize.width + 20 + 1;
        return size.width;
    }
}

- (CGSize)sizeWithString:(NSString *)str fontSize:(float)fontSize
{
    CGSize constraint = CGSizeMake(self.view.frame.size.width - 40, fontSize + 1);
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize retSize = [str boundingRectWithSize:constraint
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attribute
                                       context:nil].size;
    tempSize = retSize;
    return tempSize ;
}

- (void)addObjectAction
{
    NSLog(@"ddddddddd");
    [self.fakeDataArray addObject:@"123"];
    __weak typeof(self) weakSelf = self;
    [self.collectionView performBatchUpdates:^{
        [weakSelf.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:weakSelf.fakeDataArray.count - 1 inSection:0]]];
    } completion:^(BOOL finished) {
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        AYTagCollectionLayout *layout = [[AYTagCollectionLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemSpacing = 10.0;
        layout.lineSpacing = 10.0;
        layout.itemHeigh = 30.0;
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        [_collectionView registerClass:[TagCollectionViewCell class] forCellWithReuseIdentifier:@"TagCollectionViewCell"];
        
        [_collectionView registerClass:[TagAddCollectionViewCell class] forCellWithReuseIdentifier:@"TagAddCollectionViewCell"];
    }
    return _collectionView;
}

- (NSMutableArray *)fakeDataArray
{
    if (!_fakeDataArray) {
        NSArray *array = @[@"头条",@"热点新闻",@"体育杂志",@"本地",@"财经",@"暴雪游戏帖",@"图片",@"轻松一刻",@"LOL",@"段子手",@"军事",@"房产",@"English",@"家居",@"原创大型喜剧",@"游戏英雄联盟"];
        _fakeDataArray = [NSMutableArray arrayWithArray:array];
    }
    return _fakeDataArray;
}

@end
