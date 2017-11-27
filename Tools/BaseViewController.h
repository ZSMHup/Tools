//
//  BaseViewController.h
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  在控制器内部的滚动视图, 大小变化时会回调该方法
 */
@property (nonatomic, copy) void(^contentChanged)(void);
@property (nonatomic, weak) UIScrollView *scrollview;


- (void)setNavTransparent:(BOOL)isTransparent;
- (void)setNavBlackLine:(BOOL)showLine;

@end
