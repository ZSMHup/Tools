//
//  CustomTabView.m
//  CustomTabView
//
//  Created by tianchuang_2 on 16/8/2.
//  Copyright © 2016年 李文良. All rights reserved.
//

#import "TCTabSlideView.h"
#import "UIView+Extension.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface TCTabSlideView ()
{
    // 按钮底部的线宽度比例, 与整个按钮宽度的占比 (范围:0 ~ 1)
    CGFloat _bottomLineWidthScale;
}
@property(nonatomic,strong)UILabel *buttomLineLabel;
@property(nonatomic,strong)UIButton *beforeBtn;
@property(nonatomic,strong)NSArray *titleArr;
@end
@implementation TCTabSlideView
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr
{
    self = [super init];
    if (self) {
        if (titleArr.count == 0) {
            return nil;
            
        };
        
        [self setConfigs];
        self.frame = frame;
        self.titleArr = titleArr;
        [self setUpSlideView];
        
    }
    return self;
}
/**设置默认属性*/
- (void)setConfigs{
    self.backgroundColor = [UIColor whiteColor];
    _selectedColor = [UIColor blackColor];
    _normalColor = [UIColor grayColor];
    _buttomLineLabelColor = [UIColor orangeColor];
    _first_selected_item = 0;
    _bottomLineWidthScale = .6f;
    
}
/**设置按钮的正常颜色*/
- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:normalColor forState:UIControlStateNormal];

        }
    }
    
}
/** 设置选中按钮的颜色 */
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [self.beforeBtn setTitleColor:selectedColor forState:UIControlStateNormal];
    
}
/**设置默认的选中次数*/
- (void)setFirst_selected_item:(int)first_selected_item{
    _first_selected_item = first_selected_item;
    if (first_selected_item<=self.titleArr.count) {
        self.buttomLineLabel.frame = CGRectMake((self.bounds.size.width/self.titleArr.count)*((1-_bottomLineWidthScale)/2+_first_selected_item),self.bounds.size.height-4, _bottomLineWidthScale*self.bounds.size.width/self.titleArr.count, 4);
    }
    
}
/**设置下部lineLabel的颜色*/
- (void)setButtomLineLabelColor:(UIColor *)buttomLineLabelColor{
    _buttomLineLabelColor = buttomLineLabelColor;
    self.buttomLineLabel.backgroundColor = buttomLineLabelColor;
  
}
/**创建自定义slidView*/
- (void)setUpSlideView{
    for (int i=0; i<self.titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(self.bounds.size.width/self.titleArr.count), 0, self.bounds.size.width/self.titleArr.count, self.bounds.size.height-4);
        button.backgroundColor = [UIColor clearColor];
    
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:self.normalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(chooseBtnWillClickAction:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(chooseBtnDidClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:button];
        
        
        //设置第一选中的btn颜色
        if (i==_first_selected_item) {
            [button setTitleColor:_selectedColor forState:UIControlStateNormal];
            self.beforeBtn = button;
        }
        
        
    }
    self.buttomLineLabel = [[UILabel alloc] init];
    self.buttomLineLabel.backgroundColor = self.buttomLineLabelColor;
    self.buttomLineLabel.frame = CGRectMake((self.bounds.size.width/self.titleArr.count)*((1-_bottomLineWidthScale)/2+_first_selected_item),self.bounds.size.height-4, _bottomLineWidthScale*self.bounds.size.width/self.titleArr.count, 4);
    [self addSubview:self.buttomLineLabel];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, [self getHeight]-.6f, ScreenW, .6f)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
}

/**将要点击的事件*/
- (void)chooseBtnWillClickAction:(UIButton *)sender{
     //代理
    if ([self.delegate respondsToSelector:@selector(slideViewWillChange:fromCurrentBtn:toSelectedBtn:)]) {
        [self.delegate slideViewWillChange:self fromCurrentBtn:self.beforeBtn.tag toSelectedBtn:sender.tag];
    }
//    if ([self.delegate respondsToSelector:@selector(updateScrollViewWithOffset:)]) {
//        [self.delegate updateScrollViewWithOffset:self.tag];
//    }
    
}

/**默认选中的位置*/
-(void)setSelcetdIndex:(NSInteger)selcetdIndex{
    _selcetdIndex = selcetdIndex;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if ( ((UIButton *)view).tag == selcetdIndex) {
                [self chooseBtnDidClickedActionWithNoAnimations:((UIButton *)view)];
            }
        }
    }
}
/**点击之后的事件*/
- (void)chooseBtnDidClickedAction:(UIButton *)sender{
    //切换btn颜色
    [self.beforeBtn setTitleColor:_normalColor forState:UIControlStateNormal];
     self.beforeBtn.enabled = YES;
     sender.enabled = NO;
    [sender setTitleColor:_selectedColor forState:UIControlStateNormal];
    self.beforeBtn = sender;

    //改变btn下面的那条线
    [UIView animateWithDuration:.25f animations:^{
        self.buttomLineLabel.frame = CGRectMake([sender getX]+(self.bounds.size.width/self.titleArr.count)*(1-_bottomLineWidthScale)/2, [sender getHeight], (self.bounds.size.width/self.titleArr.count)*_bottomLineWidthScale , 4);
    }];
    
    //代理
    if ([self.delegate respondsToSelector:@selector(slideViewDidChanged:fromCurrentBtn:toSelectedBtn:)]) {
        [self.delegate slideViewDidChanged:self fromCurrentBtn:self.beforeBtn.tag toSelectedBtn:sender.tag];
    }
    
//    if ([self.delegate respondsToSelector:@selector(updateScrollViewWithOffset:)]) {
//        [self.delegate updateScrollViewWithOffset:sender.tag];
//    }
    
}

/**默认选中无动画效果(用于外界改变tab选项调用, 无代理回调)*/
-(void)chooseBtnDidClickedActionWithNoAnimations:(UIButton *)sender{
    //切换btn颜色
    [self.beforeBtn setTitleColor:_normalColor forState:UIControlStateNormal];
    [sender setTitleColor:_selectedColor forState:UIControlStateNormal];
    self.beforeBtn.enabled = YES;
    sender.enabled = NO;
    //改变btn下面的那条线
    self.buttomLineLabel.frame = CGRectMake([sender getX]+(self.bounds.size.width/self.titleArr.count)*(1-_bottomLineWidthScale)/2, [sender getHeight], (self.bounds.size.width/self.titleArr.count)*_bottomLineWidthScale , 4);
    self.beforeBtn = sender;
}

/**点击之后的事件(用于外界改变tab选项调用, 无代理回调)*/
- (void)chooseBtnDidClickedActionWithoutDelegate:(UIButton *)sender
{
    //切换btn颜色
    [self.beforeBtn setTitleColor:_normalColor forState:UIControlStateNormal];
    [sender setTitleColor:_selectedColor forState:UIControlStateNormal];
    self.beforeBtn.enabled = YES;
    sender.enabled = NO;
    //改变btn下面的那条线
    [UIView animateWithDuration:.25f animations:^{
        self.buttomLineLabel.frame = CGRectMake([sender getX]+(self.bounds.size.width/self.titleArr.count)*(1-_bottomLineWidthScale)/2, [sender getHeight], (self.bounds.size.width/self.titleArr.count)*_bottomLineWidthScale , 4);

    }];
    
    self.beforeBtn = sender;
}

//**根据偏移量改变选中的按钮-------虚拟点击*/
- (void)changeSelectedItemWithContentOffset:(NSInteger)offsetNum{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if ( ((UIButton *)view).tag==offsetNum) {
                [self chooseBtnDidClickedActionWithoutDelegate:((UIButton *)view)];
            }
        }
    }
    
}
#pragma mark------scrollview的代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger currIndex = scrollView.contentOffset.x / ScreenW;
    [self changeSelectedItemWithContentOffset:(int)currIndex];
    if (self.delegate) {
        [self.delegate updateScrollViewWithOffset:currIndex];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSUInteger currIndex = scrollView.contentOffset.x / ScreenW;
    [self changeSelectedItemWithContentOffset:(int)currIndex];
    if (self.delegate) {
        [self.delegate updateScrollViewWithOffset:currIndex];
    }
}


@end
