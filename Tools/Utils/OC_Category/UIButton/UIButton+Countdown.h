//
//  UIButton+Countdown.h
//  Tools
//
//  Created by 张书孟 on 2017/10/16.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^countdownCompletionBlock)(void);

@interface UIButton (Countdown)

/** 倒计时，s倒计 */
- (void)countdownWithSec:(NSInteger)time;
/** 倒计时，秒字倒计 */
- (void)countdownWithSecond:(NSInteger)second;
/** 倒计时，s倒计,带有回调 */
- (void)countdownWithSec:(NSInteger)sec completion:(countdownCompletionBlock)block;
/** 倒计时,秒字倒计，带有回调 */
- (void)countdownWithSecond:(NSInteger)second completion:(countdownCompletionBlock)block;

@end
