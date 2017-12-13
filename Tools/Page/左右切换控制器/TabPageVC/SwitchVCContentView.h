//
//  SwitchVCContentView.h
//  Tools
//
//  Created by 张书孟 on 2017/12/12.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchVCContentView : UIView

/**
 初始化方法

 @param frame frame
 @param titleArray 标题
 @param controllersArray 控制器
 @return SwitchVCContentView
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray controllersArray:(NSArray *)controllersArray;

@end
