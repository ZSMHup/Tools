//
//  ParentTableViewCell.h
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GXPageScrollViewHorizontalScrollState) {
    GXPageScrollViewHorizontalScrollStateDidScroll = 0,
    GXPageScrollViewHorizontalScrollStateDidEndDecelerating
};

@class GXScrollTableViewCell;

@protocol GXScrollTableViewCellDelegate <NSObject>

@optional
- (void)scrollTableViewCell:(GXScrollTableViewCell *)cell horizontalScrollToIndex:(NSUInteger)index forState:(GXPageScrollViewHorizontalScrollState)state;
- (void)scrollTableViewCell:(GXScrollTableViewCell *)cell didSelectItemAtIndex:(NSUInteger)index;

@end

@interface GXScrollTableViewCell : UITableViewCell

@property (nonatomic, weak) id <GXScrollTableViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL scrollAnimated;
@property (nonatomic, strong) NSArray *configInfo;

- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
