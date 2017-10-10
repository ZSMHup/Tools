//
//  NSUserDefaults+UserDefaults.h
//  VodSDKDemo
//
//  Created by gs_mac_wjj on 15/9/21.
//  Copyright © 2015年 Gensee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (UserDefaults)

- (NSString *)getDomain;

- (void)setDomain:(NSString *)domain;

- (NSString *)getServiceType;

- (void)setServiceType:(NSString*)serviceType;

- (NSString *)getNumber;

- (void)setNumber:(NSString*)roomNumber;

- (NSString *)getVodPassword;

- (void)setVodPassword:(NSString *)watchPassword;

@end
