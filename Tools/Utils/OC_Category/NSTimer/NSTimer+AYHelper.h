//
//  NSTimer+AYHelper.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/8/24.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (AYHelper)

+ (NSTimer *)AY_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

+ (NSTimer *)AY_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end
