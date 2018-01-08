//
//  GXTabMenuView.h
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXTabMenuView : UIView

@property (nonatomic, strong) UIColor *tabMenuBackgroundColor;
@property (nonatomic, strong) UIColor *tabMenuTitleNormalColor;
@property (nonatomic, strong) UIColor *tabMenuTitleSelectedColor;
@property (nonatomic, assign) BOOL lineHidden;

@property (nonatomic, copy) void(^didSelectItemHandler)(NSUInteger index);

- (instancetype)initWithTitles:(NSArray *)titles;
- (void)didSelectItemAtIndex:(NSUInteger)index;
- (void)showBadgeAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
