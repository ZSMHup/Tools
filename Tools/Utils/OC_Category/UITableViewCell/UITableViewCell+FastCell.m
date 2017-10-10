//
//  UITableViewCell+FastCell.m
//  Tools
//
//  Created by 张书孟 on 2017/9/29.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "UITableViewCell+FastCell.h"

#define kCellIdentifier NSStringFromClass(self)

@implementation UITableViewCell (FastCell)

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadWithComponents];
    }
    
    return cell;
}

+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(!cell){
        cell = [self viewFromXIB];
        
        
    }
    return cell;
}

+ (instancetype)viewFromXIB
{
    
    UITableViewCell *xibCell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier owner:nil options:nil] firstObject];
    
    if(!xibCell){
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@", kCellIdentifier);
    }
    return xibCell;
}

#pragma mark - private
- (void)loadWithComponents
{
    
}

- (void)setDataWithModel:(NSObject *)model
{
    
}

+ (CGFloat)getCellHeightWithModel:(NSObject *)model
{
    return 0;
}


@end
