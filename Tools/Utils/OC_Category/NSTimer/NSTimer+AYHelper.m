//
//  NSTimer+AYHelper.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/8/24.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "NSTimer+AYHelper.h"

@implementation NSTimer (AYHelper)

#pragma mark - public
+ (NSTimer *)AY_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    NSTimer *timer = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(__executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}

+ (NSTimer *)AY_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    NSTimer *timer = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(__executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}

#pragma mark - private
+ (void)__executeTimerBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo]) {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end
