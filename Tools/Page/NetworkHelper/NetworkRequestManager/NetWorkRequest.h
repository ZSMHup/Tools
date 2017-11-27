//
//  NetWorkRequest.h
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveListModel;
@class TwoModel;

@interface NetWorkRequest : NSObject

+ (void)requestLiveListWithParameters:(NSDictionary *)parameters
                       responseCaches:(void (^)(LiveListModel *model))responseCaches
                              success:(void (^)(LiveListModel *model))success
                              failure:(void (^)(NSError *error))failure;

+ (void)requestAnalysListWithParameters:(NSDictionary *)parameters
                         responseCaches:(void (^)(TwoModel *model))responseCaches
                                success:(void (^)(TwoModel *model))success
                                failure:(void (^)(NSError *error))failure;

@end
