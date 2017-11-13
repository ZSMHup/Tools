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

@end
