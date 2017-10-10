//
//  NSObject+DebugLog.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/6.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "NSObject+DebugLog.h"

#ifdef DEBUG
#define DebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DebugLog(...)
#endif

NSString *const kLogOFF           = @"logIsOFF";
NSString *const kIsProduction     = @"isProduction";

NSString *const kErrorStatus      = @"ERROR";
NSString *const kWarningStatus    = @"WARNING";
NSString *const kINFOStatus       = @"INFO";
NSString *const kVerboseStatus    = @"VERBOSE";

@implementation NSObject (DebugLog)

#pragma mark - private
- (BOOL)checkIsProduction
{
    return [TYSUserDefaults boolForKey:kIsProduction];
}

- (BOOL)checkLogStatusSettings
{
    return [TYSUserDefaults boolForKey:kLogOFF];
}

- (void)log:(NSString *)status text:(NSString *)text
{
    if ([self checkIsProduction]) return;
    if ([self checkLogStatusSettings]) return;
    
    DebugLog(@"[%@]: %@", status, text);
}


#pragma mark - public
+ (void)setLogON
{
    [TYSUserDefaults setBool:NO forKey:kLogOFF];
    [TYSUserDefaults synchronize];
    [self logINFO:@"日志已开启，如不需要，请调用 [NSObject setLogOFF] 关闭日志"];
}

+ (void)setLogOFF
{
    [TYSUserDefaults setBool:YES forKey:kLogOFF];
    [TYSUserDefaults synchronize];
    [self logINFO:@"日志已关闭，如需要，请调用 [NSObject setLogON] 打开日志"];
}

+ (void)logError:(NSString *)error
{
    [self log:kErrorStatus text:error];
}

+ (void)logWarning:(NSString *)warning
{
    [self log:kWarningStatus text:warning];
}

+ (void)logINFO:(NSString *)INFO
{
    [self log:kINFOStatus text:INFO];
}

+ (void)logVerbose:(NSString *)Verbose
{
    [self log:kVerboseStatus text:Verbose];
}

@end
