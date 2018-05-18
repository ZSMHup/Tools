//
//  NetworkRequestManager.h
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequestModel.h"
#import "NetworkHelper.h"

@interface NetworkRequestManager : NSObject

@property (nonatomic, strong) Class modelClass;

+ (NSURLSessionTask *)postRequestWithParameters:(NSDictionary *)parameter
                                     modelClass:(Class)modelClass
                                 responseCaches:(HttpRequestCache)responseCaches
                                        success:(HttpRequestSuccess)success
                                        failure:(HttpRequestFailed)failure;


@end
