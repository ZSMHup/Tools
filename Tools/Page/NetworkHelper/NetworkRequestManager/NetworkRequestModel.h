//
//  NetworkRequestModel.h
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PageModel;
@interface NetworkRequestModel : NSObject

@property (nonatomic, copy) NSString *statusCode;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) PageModel *page;

@property (nonatomic, strong) NSArray *responseResultList; // the value for "result" key is array

@property (nonatomic, copy) NSString *responseResultString; // the value for "result" key is string

- (BOOL)success;

- (NSString *)responseMessage;

@end

@interface PageModel : NSObject

@property (nonatomic, copy) NSString *totalCount; // 总记录数
@property (nonatomic, copy) NSString *pageSize; // 每页记录数
@property (nonatomic, copy) NSString *totalPage; // 总页数
@property (nonatomic, copy) NSString *currPage; // 当前页数

@end
