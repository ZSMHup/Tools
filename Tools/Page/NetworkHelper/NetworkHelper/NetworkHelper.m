//
//  NetworkHelper.m
//  TestNetWorking
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"


#ifdef DEBUG
#define DeBugLog(...) printf("[%s] %s [第%d行]: %s\n",__TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define DeBugLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation NetworkHelper

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(NetworkStatusUnknown) : nil;
//                if (_isOpenLog)
                    DeBugLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(NetworkStatusNotReachable) : nil;
//                if (_isOpenLog)
                    DeBugLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(NetworkStatusReachableViaWWAN) : nil;
//                if (_isOpenLog)
                    DeBugLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(NetworkStatusReachableViaWiFi) : nil;
//                if (_isOpenLog)
                    DeBugLog(@"WIFI");
                break;
        }
    }];
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

+(void)cancelAllRequest {
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) return;
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
              parameters:(id)parameters
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure {
    
    return  [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
               parameters:(id)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}
#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
              parameters:(id)parameters
            responseCache:(HttpRequestCache)responseCache
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure {
    //读取缓存
    responseCache != nil ? responseCache([NetworkCache getHttpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (_isOpenLog)
            DeBugLog(@"responseObject = %@",responseObject);
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [NetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (_isOpenLog)
            DeBugLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    return sessionTask;
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
               parameters:(id)parameters
             responseCache:(HttpRequestCache)responseCache
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure {
    //读取缓存
    responseCache != nil ? responseCache([NetworkCache getHttpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        if (_isOpenLog)
            DeBugLog(@"responseObject = %@",responseObject);
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [NetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (_isOpenLog)
            DeBugLog(@"error = %@",error);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject: sessionTask] : nil;
    
    return sessionTask;
}
#pragma mark - 上传文件
#pragma mark - 上传多张图片
#pragma mark - 下载文件
/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [NSMutableArray array];
    }
    return _allSessionTask;
}
#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}
#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(RequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==RequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(ResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==ResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


#pragma mark - NSDictionary,NSArray的分类

/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

@implementation NSArray (NetworkHelper)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (NetworkHelper)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
