//
//  CustomTabView.h
//  CustomTabView
//
//  Created by tianchuang_2 on 16/8/2.
//  Copyright © 2016年 李文良. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark-----选项卡协议
@class TCTabSlideView;
@protocol TCTabSlideViewDelegate <NSObject>
/**
 *  将要点击选项卡的事件
 *
 *  @param slideView 选项卡
 *  @param fromTag   起始tag值
 *  @param toTag     被选中的tag
 */
@optional
- (void)slideViewWillChange:(TCTabSlideView *)slideView fromCurrentBtn:(NSInteger)fromTag toSelectedBtn:(NSInteger)toTag;
/**
 *  将要点击选项卡的事件
 *
 *  @param slideView 选项卡
 *  @param fromTag   起始tag值
 *  @param toTag     被选中的tag
 */
@optional
- (void)slideViewDidChanged:(TCTabSlideView *)slideView fromCurrentBtn:(NSInteger)fromTag toSelectedBtn:(NSInteger)toTag;


/**
 点击工具条和滑动scrollview的回调
 
 @param currentIndex 当前的所在的是第几个偏移量
 */
@optional
- (void)updateScrollViewWithOffset:(NSInteger)currentIndex;


@end

#pragma mark-------选项卡
@interface TCTabSlideView : UIView<UIScrollViewDelegate>
@property(nonatomic,assign)id <TCTabSlideViewDelegate> delegate;
/**
 *  创建tabSlideView的方法 
 *
 *  @param frame    外部设定tabSlideView在俯视图上的位置
 *  @param titleArr tabSlideView上的btn的标题
 *
 *  @return tabSlideView
 */
- (instancetype) initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr;
/**
 *  通过拖动scrollviw来改变选中的按钮
 *
 *  @param offsetNum scrollView的偏移量/scrollview的宽度
 */
- (void)changeSelectedItemWithContentOffset:(NSInteger)offsetNum;//



@property(nonatomic,assign)int first_selected_item;//默认选项
@property(nonatomic,strong)UIColor *normalColor;//正常字体的颜色  设置颜色的顺序不可以改变：先设置正常颜色再设置选中颜色
@property(nonatomic,strong)UIColor *selectedColor;//选中按钮的字体颜色
@property(nonatomic,strong)UIColor *buttomLineLabelColor;//下部的label的颜色
/**默认选中的index*/
@property (nonatomic,assign) NSInteger selcetdIndex;
@end


