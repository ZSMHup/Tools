//
//  NSUserDefaults+UserDefaults.m
//  VodSDKDemo
//
//  Created by gs_mac_wjj on 15/9/21.
//  Copyright © 2015年 Gensee. All rights reserved.
//

#import "NSUserDefaults+UserDefaults.h"

static NSString *kDomain = @"domain";
static NSString *kServiceType = @"serviceType";
static NSString *kNumber = @"number";
static NSString *kVodPassword = @"vodPassword";

@implementation NSUserDefaults (UserDefaults)

- (NSString *)getDomain
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:kDomain];
}

- (void)setDomain:(NSString *)domain
{
    [[NSUserDefaults standardUserDefaults]setObject:domain forKey:kDomain];
}

- (NSString *)getServiceType
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:kServiceType];
}

- (void)setServiceType:(NSString*)serviceType
{
    [[NSUserDefaults standardUserDefaults]setObject:serviceType forKey:kServiceType];
}

- (NSString *)getNumber
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:kNumber];
}

- (void)setNumber:(NSString*)roomNumber
{
    [[NSUserDefaults standardUserDefaults]setObject:roomNumber forKey:kNumber];
}

- (NSString *)getVodPassword
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:kVodPassword];
}

- (void)setVodPassword:(NSString *)watchPassword
{
    [[NSUserDefaults standardUserDefaults]setObject:watchPassword forKey:kVodPassword];
}

@end