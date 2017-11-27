//
//  TwoModel.h
//  Tools
//
//  Created by 张书孟 on 2017/11/21.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface TwoModel : NetworkRequestModel

@property (nonatomic, copy) NSString *auth_org_name;
@property (nonatomic, copy) NSString *post;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *frist_pinyin;
@property (nonatomic, copy) NSString *post_name;
@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *auth_org_id;
@property (nonatomic, copy) NSString *industry_name;
@property (nonatomic, copy) NSString *org_name;

@end
