//
//  UITableView+TYSCustomize.m
//  Touyanshe
//
//  Created by 高翔 on 2017/5/25.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "UITableView+TYSCustomize.h"

@implementation UITableView (TYSCustomize)

- (void)tys_setSeparatorInsetLeft:(CGFloat)left right:(CGFloat)right
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, left, 0, right)];
        [self setSeparatorColor:[UIColor tys_lineColor]];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, left, 0, right)];
    }
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [self setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)tys_setSeparatorStyle
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        [self setSeparatorColor:[UIColor tys_lineColor]];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [self setPreservesSuperviewLayoutMargins:NO];
    }
}

@end
