//
//  AYTagCollectionLayout.h
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter;

@class AYTagCollectionLayout;

@protocol AYTagCollectionLayoutDelegate <NSObject>
@required

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(AYTagCollectionLayout *)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath;

@optional

//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(AYTagCollectionLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(AYTagCollectionLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end

@interface AYTagCollectionLayout : UICollectionViewLayout

@property (nonatomic, weak) id <AYTagCollectionLayoutDelegate> delegate;

@property(nonatomic, assign) UIEdgeInsets sectionInset; //sectionInset
@property(nonatomic, assign) CGFloat lineSpacing;  //line space
@property(nonatomic, assign) CGFloat itemSpacing; //item space
@property(nonatomic, assign) CGFloat itemHeigh;  //item heigh

@end
