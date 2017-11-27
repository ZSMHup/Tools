//
//  ScrollTableViewCell.m
//  Tools
//
//  Created by 张书孟 on 2017/11/21.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThridViewController.h"
#import "FourthViewController.h"
#import "BaseViewController.h"
#import "UIView+Extension.h"

#define kTCCellIdentifier  @"kTCCellIdentifier"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ScrollTableViewCell ()<UIScrollViewDelegate>

#define kDefaultSideslipHeight  ScreenH - 50 - 64  // 该值为默认的无数据时Cell侧滑的可滑动区域高度

@property (nonatomic, strong) NSArray *arrayControllerClass;
@property (nonatomic, strong) NSMutableArray *arrayControllers;
@property (nonatomic, assign) NSUInteger currIndex;
@property (nonatomic, copy) void(^cellHeight)(CGFloat cellHeight, NSUInteger index);
@property (nonatomic, strong) NetworkRequestModel *baseModel;

@end

@implementation ScrollTableViewCell

- (NSMutableArray *)arrayControllers{
    if (_arrayControllers == nil) {
        _arrayControllers = [NSMutableArray array];
    }
    return _arrayControllers;
}

- (NSArray *)arrayControllerClass{
    if (_arrayControllerClass == nil) {
        _arrayControllerClass = @[[OneViewController class],[TwoViewController class],[ThridViewController class],[FourthViewController class]];
    }
    return _arrayControllerClass;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTCCellIdentifier];
    if (cell == nil) {
        cell = [[ScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTCCellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configScrollView];
    }
    return self;
}

- (void)configScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.scrollView.contentSize = CGSizeMake(ScreenW * self.arrayControllerClass.count, [self.scrollView getHeight]);
//    self.scrollView.backgroundColor = [UIColor blueColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
}

- (void)setDataWithModel:(NetworkRequestModel *)baseModel callBack:(void (^)(CGFloat cellHeight, NSUInteger index))cellHeight{
    if (_baseModel && baseModel == self.baseModel){
        return;
    }
    _baseModel = baseModel;
    _cellHeight = cellHeight;
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    [self.arrayControllers removeAllObjects];
    __weak typeof(self) weakSelf = self;
    for (Class vc in self.arrayControllerClass) {
        BaseViewController *subVC = [[vc alloc] init];
        if ([subVC isViewLoaded]) return;
        subVC.view.frame = (CGRect){{ScreenW * [self.arrayControllerClass indexOfObject:vc], 0}, CGSizeMake(ScreenW, ScreenH)};
        subVC.contentChanged = ^() {
            [weakSelf returnCellHeight];
        };
        [self.arrayControllers addObject:subVC];
        [self.scrollView addSubview:subVC.view];
        subVC.scrollview.scrollEnabled = NO;
        self.currIndex = self.scrollView.contentOffset.x/ScreenW;
    }
}

- (void)setCellHeightReturn:(void (^)(CGFloat cellHeight, NSUInteger index))cellHeight{
    self.cellHeight = cellHeight;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.currIndex = scrollView.contentOffset.x/ScreenW;
    [self returnCellHeight];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)returnCellHeight{
    if (self.cellHeight) {
        BaseViewController *subVC = self.arrayControllers[self.currIndex];
        CGFloat culCellHeight = MAX(subVC.scrollview.contentSize.height, kDefaultSideslipHeight);
        self.cellHeight(culCellHeight, self.currIndex);
        [subVC.view updateHeight:MAX(culCellHeight,ScreenH)];
        [self.scrollView updateHeight:MAX(culCellHeight, ScreenH)];
        [subVC.view updateHeight:MAX(culCellHeight, ScreenH)]; // 行数:1, 修复问题(BUG描述:(当第二个Tab过长时, 滑动到左右视图, subVC高度会被<self.scrollView updateHeight>制空))
    }
}

- (void)setTabCurrIndex:(NSUInteger)currIndex fromLastIndex:(NSUInteger)lastIndex;{
    [self.scrollView setContentOffset:CGPointMake(currIndex * ScreenW, 0) animated:YES];
    self.currIndex = currIndex;
}

@end
