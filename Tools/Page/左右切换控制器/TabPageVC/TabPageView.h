//
//  TabPageView.h
//  Tools
//
//  Created by 张书孟 on 2017/12/12.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectIndex)(NSInteger index);

@interface TabPageView : UIView

/** 背景颜色 */
@property (nonatomic, strong) UIColor *bgColor;
/** 按钮未选中背景颜色 */
@property (nonatomic, strong) UIColor *tabBgColorNormal;
/** 按钮选中背景颜色 */
@property (nonatomic, strong) UIColor *tabBgColorSelected;
/** 文字未选中颜色 */
@property (nonatomic, strong) UIColor *titleColorNormal;
/** 文字选中颜色 */
@property (nonatomic, strong) UIColor *titleColorSelected;
/** 底部指示线颜色 */
@property (nonatomic, strong) UIColor *tabLineColor;
/** 底部线颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 底部指示线高度 */
@property (nonatomic, assign) CGFloat tabLineHeight;
/** 底部线高度 */
@property (nonatomic, assign) CGFloat lineHeight;
/** 当前选中第几个按钮 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 当前选中第几个按钮的回调 */
@property (nonatomic, copy) selectIndex index;


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;










@end
