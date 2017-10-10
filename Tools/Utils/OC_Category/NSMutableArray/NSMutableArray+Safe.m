//
//  NSMutableArray+Safe.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/8/1.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

- (void)ay_addObject:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

@end
