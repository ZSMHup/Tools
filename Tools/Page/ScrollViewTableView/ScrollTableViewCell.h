//
//  ScrollTableViewCell.h
//  Tools
//
//  Created by 张书孟 on 2017/11/21.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkRequestModel.h"

@interface ScrollTableViewCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,copy) NSString *currentController;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setDataWithModel:(NetworkRequestModel *)baseModel callBack:(void(^)(CGFloat cellHeight, NSUInteger index))cellHeight;

- (void)setTabCurrIndex:(NSUInteger)currIndex fromLastIndex:(NSUInteger)lastIndex;

@end
