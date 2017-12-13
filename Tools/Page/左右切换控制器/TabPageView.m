//
//  TabPageView.m
//  Tools
//
//  Created by 张书孟 on 2017/12/12.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "TabPageView.h"

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@interface TabPageView ()

/** tab */
@property (nonatomic, strong) UIButton *tabBtn;
/** 选中的tab */
@property (nonatomic, strong) UIButton *selectesTabBtn;
/** 底部指示线 */
@property (nonatomic, strong) UIView *tabLineView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *tabTitleArray;

@end

@implementation TabPageView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        if (titleArray.count == 0) {
            return nil;
        }
        [self setConfigs];
        self.tabTitleArray = titleArray;
        [self addTabBtn];
    }
    return self;
}
#pragma mark - private
// 设置默认属性
- (void)setConfigs{
    _bgColor = [UIColor orangeColor];
    _tabBgColorNormal = [UIColor whiteColor];
    _tabBgColorSelected = [UIColor whiteColor];
    _titleColorNormal = [UIColor grayColor];
    _titleColorSelected = [UIColor redColor];
    _tabLineColor = [UIColor redColor];
    _lineColor = [UIColor clearColor];
    _tabLineHeight = 2.0;
    _lineHeight = 1.0;
    _selectedIndex = 0;
    self.backgroundColor = _bgColor;
}

- (void)addTabBtn {
    
    for (NSInteger i = 0; i < self.tabTitleArray.count; i++) {
        _tabBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / self.tabTitleArray.count * i, 0, kWidth / self.tabTitleArray.count, kHeight)];
        [_tabBtn setTitle:self.tabTitleArray[i] forState:(UIControlStateNormal)];
        [_tabBtn setTitleColor:_titleColorNormal forState:(UIControlStateNormal)];
        _tabBtn.backgroundColor = _tabBgColorNormal;
        [_tabBtn addTarget:self action:@selector(tabBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _tabBtn.tag = 1000 + i;
        [self addSubview:_tabBtn];
        
        if (i == _selectedIndex) {
            [self tabBtnClick:_tabBtn];
        }
    }
    _tabLineView = [[UIView alloc] initWithFrame:CGRectMake(20, kHeight - _tabLineHeight, kWidth / self.tabTitleArray.count - 40, _tabLineHeight)];
    _tabLineView.backgroundColor = _tabLineColor;
    [self addSubview:_tabLineView];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - _lineHeight, kWidth, _lineHeight)];
    _lineView.backgroundColor = _lineColor;
    [self addSubview:_lineView];
}


#pragma mark - event response
- (void)tabBtnClick:(UIButton *)sender {
    for (NSInteger i = 0; i < self.tabTitleArray.count; i++) {
        self.selectesTabBtn = (UIButton *)[self viewWithTag:1000 + i];
        if (sender == self.selectesTabBtn) {
            self.selectesTabBtn.backgroundColor = _tabBgColorSelected;
            [self.selectesTabBtn setTitleColor:_titleColorSelected forState:(UIControlStateNormal)];
            [UIView animateWithDuration:0.25 animations:^{
                _tabLineView.frame = CGRectMake(kWidth / self.tabTitleArray.count * i + 20, kHeight - _tabLineHeight, kWidth / self.tabTitleArray.count - 40, _tabLineHeight);
            }];
            if (_index) {
                _index(i);
            }
        } else {
            self.selectesTabBtn.backgroundColor = _tabBgColorNormal;
            [self.selectesTabBtn setTitleColor:_titleColorNormal forState:(UIControlStateNormal)];
        }
    }
    sender = self.selectesTabBtn;
}

#pragma mark - settter
- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void)setTabBgColorNormal:(UIColor *)tabBgColorNormal {
    _tabBgColorNormal = tabBgColorNormal;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.backgroundColor = tabBgColorNormal;
        }
    }
}

- (void)setTabBgColorSelected:(UIColor *)tabBgColorSelected {
    _tabBgColorSelected = tabBgColorSelected;
    _selectesTabBtn = (UIButton *)[self viewWithTag:1000 + _selectedIndex];
    _selectesTabBtn.backgroundColor = tabBgColorSelected;
}

- (void)setTitleColorNormal:(UIColor *)titleColorNormal {
    _titleColorNormal = titleColorNormal;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:titleColorNormal forState:(UIControlStateNormal)];
        }
    }
}

- (void)setTitleColorSelected:(UIColor *)titleColorSelected {
    _titleColorSelected = titleColorSelected;
    _selectesTabBtn = (UIButton *)[self viewWithTag:1000 + _selectedIndex];
    [_selectesTabBtn setTitleColor:titleColorSelected forState:(UIControlStateNormal)];
}

- (void)setTabLineColor:(UIColor *)tabLineColor {
    _tabLineColor = tabLineColor;
    _tabLineView.backgroundColor = tabLineColor;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _lineView.backgroundColor = lineColor;
}

- (void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    _lineView.frame = CGRectMake(0, kHeight - lineHeight, kWidth, lineHeight);
}

- (void)setTabLineHeight:(CGFloat)tabLineHeight {
    _tabLineHeight = tabLineHeight;
    _tabLineView.frame = CGRectMake(20, kHeight - tabLineHeight - 1, kWidth / self.tabTitleArray.count - 40, tabLineHeight);
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    _tabBtn = (UIButton *)[self viewWithTag:1000 + _selectedIndex];
    for (NSInteger i = 0; i < self.tabTitleArray.count; i++) {
        _selectesTabBtn = (UIButton *)[self viewWithTag:1000 + i];
        if (_tabBtn == _selectesTabBtn) {
            _selectesTabBtn.backgroundColor = _tabBgColorSelected;
            [_selectesTabBtn setTitleColor:_titleColorSelected forState:(UIControlStateNormal)];
            [UIView animateWithDuration:0.25 animations:^{
                _tabLineView.frame = CGRectMake(kWidth / self.tabTitleArray.count * selectedIndex + 20, kHeight - _tabLineHeight, kWidth / _tabTitleArray.count - 40, _tabLineHeight);
            }];
//            if (_index) {
//                _index(i);
//            }
        } else {
            _selectesTabBtn.backgroundColor = _tabBgColorNormal;
            [_selectesTabBtn setTitleColor:_titleColorNormal forState:(UIControlStateNormal)];
        }
    }
    _tabBtn = _selectesTabBtn;
}

@end
