//
//  GXScrollTableView.m
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/14.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "GXScrollTableView.h"

@implementation GXScrollTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
