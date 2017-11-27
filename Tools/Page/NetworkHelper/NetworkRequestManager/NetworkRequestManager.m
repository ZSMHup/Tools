//
//  NetworkRequestManager.m
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestManager.h"
#import "NetworkRequestCode.h"
#import <YYModel/YYModel.h>
#import "LiveListModel.h"
#import "MBProgressHUD+NH.h"
#define kWindow [UIApplication sharedApplication].delegate.window

@implementation NetworkRequestManager


#pragma mark - 请求的公共方法
+ (NSURLSessionTask *)postRequestWithParameters:(NSDictionary *)parameter
                                     modelClass:(Class)modelClass
                                        success:(HttpRequestSuccess)success
                                        failure:(HttpRequestFailed)failure {
    NetworkRequestManager *manager = [[NetworkRequestManager alloc] init];
    parameter = [self configParameters:parameter];
    manager.modelClass = modelClass;
    return [NetworkHelper POST:kApiPrefix parameters:parameter success:^(id responseObject) {
        id object = [manager convertToModel:[responseObject yy_modelToJSONString]];
        if (success) {
            success(object);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSURLSessionTask *)postRequestWithParameters:(NSDictionary *)parameter
                                     modelClass:(Class)modelClass
                                  responseCaches:(HttpRequestCache)responseCaches
                                        success:(HttpRequestSuccess)success
                                        failure:(HttpRequestFailed)failure {
    
//    [MBProgressHUD showMessage:@"loading..." ToView:kWindow];
    
    NetworkRequestManager *manager = [[NetworkRequestManager alloc] init];
    parameter = [self configParameters:parameter];
    manager.modelClass = modelClass;
    
    return [NetworkHelper POST:kApiPrefix parameters:parameter responseCache:^(id responseCache) {
        
        if (responseCache) {
            id object = [manager convertToModel:[responseCache yy_modelToJSONString]];
            
            if (responseCaches) {
                responseCaches(object);
            }
        }
    } success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        id object = [manager convertToModel:[responseObject yy_modelToJSONString]];
        if (success) {
            success(object);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if (failure) {
            failure(error);
        }
    }];
}


+ (NSDictionary *)configParameters:(NSDictionary *)parameters {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    NSString *accessToken = @"7e5958a30295d4beab9e27ef8bdb5f";
    if (accessToken) {
        [mDic setObject:accessToken forKey:@"accessToken"];
    } else {
        [mDic setObject:@"" forKey:@"accessToken"];
    }
    [mDic setObject:@"3.0.0" forKey:@"version"];
    [mDic setObject:@"1" forKey:@"deviceType"];
    for (NSString *key in parameters.allKeys) {
        NSString *value = parameters[key];
        [mDic setObject:value forKey:key];
    }
    return mDic;
}

- (id)convertToModel:(NSString *)JSONString {
    NSDictionary *resultDic = [self dictionaryWithJSON:JSONString];
    NSDictionary *object = resultDic[@"object"];
    NetworkRequestModel *model = [[NetworkRequestModel alloc] init];
    if ([object isKindOfClass:[NSDictionary class]]) {
        model = [self.modelClass yy_modelWithJSON:[object yy_modelToJSONString]];
    } else if ([object isKindOfClass:[NSArray class]]) {
        model = [[self.modelClass alloc] init];
        model.responseResultList = [NSArray yy_modelArrayWithClass:self.modelClass json:[object yy_modelToJSONString]];
    } else if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
        model = [[self.modelClass alloc] init];
        model.responseResultString = (NSString *)object;
    } else {
        model = [[self.modelClass alloc] init];
    }
    
    if (resultDic[@"msg"]) {
        model.msg = resultDic[@"msg"];
    }
    if (resultDic[@"statusCode"]) {
        model.statusCode = resultDic[@"statusCode"];
    }
    return model;
}

- (NSDictionary *)dictionaryWithJSON:(NSString *)string {
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
    if (result != nil && error == nil) {
        return result;
    } else {
        // 解析错误
        return nil;
    }
}

@end
