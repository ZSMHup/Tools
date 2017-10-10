//
//  NSObject+DebugLog.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/6.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DebugLog)

+ (void)setLogON;

+ (void)setLogOFF;

+ (void)logError:(NSString *)text;

+ (void)logWarning:(NSString *)warning;

+ (void)logINFO:(NSString *)INFO;

+ (void)logVerbose:(NSString *)Verbose;

@end
