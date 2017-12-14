//
//  GXPageScrollView.h
//  CloudLogistics
//
//  Created by 高翔 on 2017/8/8.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GXPageScrollViewScrollState) {
    GXPageScrollViewScrollStateDidEndDecelerating = 0,
    GXPageScrollViewScrollStateDidScroll
};

@class GXPageScrollView;

@protocol GXPageScrollViewDataSource <NSObject>

@required

- (NSUInteger)numberOfItemsInPageScrollView:(GXPageScrollView *)pageScrollView;

- (UIView *)pageScrollView:(GXPageScrollView *)pageScrollView contentViewForIndex:(NSUInteger)index;

@optional

- (NSString *)pageScrollView:(GXPageScrollView *)pageScrollView titleForItemAtIndex:(NSUInteger)index;

@end

@protocol GXPageScrollViewDelegate <NSObject>

@optional

- (void)pageScrollView:(GXPageScrollView *)pageScrollView didSelectItemAtIndex:(NSInteger)index;

- (void)pageScrollView:(GXPageScrollView *)pageScrollView didScrollToIndex:(NSInteger)index forState:(GXPageScrollViewScrollState)state;

@end

@interface GXPageScrollView : UIView

@property (nonatomic, weak) id<GXPageScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<GXPageScrollViewDelegate> delegate;
@property (nonatomic, assign) BOOL animated; // horizontal scroll animate, default is NO
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) UIColor *tabMenuBackgroundColor;
@property (nonatomic, strong) UIColor *tabMenuTitleNormalColor;
@property (nonatomic, strong) UIColor *tabMenuTitleSelectedColor;
@property (nonatomic, assign) BOOL lineHidden;

- (void)reloadData;

- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (void)selectItemAtIndex:(NSUInteger)index;

@end
