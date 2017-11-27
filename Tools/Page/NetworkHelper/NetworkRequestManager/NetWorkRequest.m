//
//  NetWorkRequest.m
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetWorkRequest.h"
#import "NetworkRequestManager.h"
#import "LiveListModel.h"
#import "TwoModel.h"

@implementation NetWorkRequest

+ (void)requestLiveListWithParameters:(NSDictionary *)parameters
                       responseCaches:(void (^)(LiveListModel *model))responseCaches
                              success:(void (^)(LiveListModel *model))success
                              failure:(void (^)(NSError *error))failure {
    
    [NetworkRequestManager postRequestWithParameters:parameters modelClass:[LiveListModel class] responseCaches:^(id responseCache) {
        LiveListModel *model = (LiveListModel *)responseCache;
        if (responseCaches) {
            responseCaches(model);
        }
    } success:^(id responseObject) {
        LiveListModel *model = (LiveListModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)requestAnalysListWithParameters:(NSDictionary *)parameters
                       responseCaches:(void (^)(TwoModel *model))responseCaches
                              success:(void (^)(TwoModel *model))success
                              failure:(void (^)(NSError *error))failure {
    
    [NetworkRequestManager postRequestWithParameters:parameters modelClass:[TwoModel class] responseCaches:^(id responseCache) {
        TwoModel *model = (TwoModel *)responseCache;
        if (responseCaches) {
            responseCaches(model);
        }
    } success:^(id responseObject) {
        TwoModel *model = (TwoModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
