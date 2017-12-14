//
//  GXPageScrollView.h
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/20.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GXScrollTableViewCell.h"

@class GXTabScrollView;

@protocol GXTabScrollViewDataSource <NSObject>

@required

- (NSUInteger)numberOfItemsInPageScrollView:(GXTabScrollView *)pageScrollView;

- (UIScrollView *)tabScrollView:(GXTabScrollView *)tabScrollView scrollViewForIndex:(NSUInteger)index;

@optional

- (NSString *)tabScrollView:(GXTabScrollView *)tabScrollView titleForItemAtIndex:(NSUInteger)index;

@end

@protocol GXTabScrollViewDelegate <NSObject>

@optional

- (void)tabScrollView:(GXTabScrollView *)tabScrollView scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)tabScrollView:(GXTabScrollView *)tabScrollView didSelectItemAtIndex:(NSUInteger)index;

- (void)tabScrollView:(GXTabScrollView *)tabScrollView horizontalScrollToIndex:(NSUInteger)index forState:(GXPageScrollViewHorizontalScrollState)state;

@end

@interface GXTabScrollView : UIView

@property (nonatomic, weak) id <GXTabScrollViewDataSource> dataSource;
@property (nonatomic, weak) id <GXTabScrollViewDelegate> delegate;

@property (nonatomic, assign) BOOL scrollAnimated; // animate at scroll, default is YES

@property (nonatomic, strong) UIView *headerView;

- (void)reloadData;

- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
