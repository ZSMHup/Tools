//
//  LiveListModel.h
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface LiveListModel : NetworkRequestModel

@property (nonatomic, copy) NSString *industry_name; // 行业名称
@property (nonatomic, copy) NSString *maxAttendees; // 最大报名人数
@property (nonatomic, copy) NSString *entry_count; // 报名人数
@property (nonatomic, copy) NSString *post_name; // 职位名称
@property (nonatomic, copy) NSString *subject; // 直播标题
@property (nonatomic, copy) NSString *is_melive; // 是否是当前用户直播数据 1是 2不是
@property (nonatomic, copy) NSString *is_free; // 是否免费 1收费 2免费
@property (nonatomic, copy) NSString *name; // 嘉宾名称
@property (nonatomic, copy) NSString *startTime; // 开始时间 yyyy-MM-dd HH:mm:ss 2017-06- 27 10:20:00
@property (nonatomic, copy) NSString *liveId; // 直播数据ID
@property (nonatomic, copy) NSString *state; // 直播状态 1直播未开始 2直播开始 3直播结束
@property (nonatomic, copy) NSString *is_signup; // 是否报名 1已报名 2未报名
@property (nonatomic, copy) NSString *p_post_name; // 个人信息职位
@property (nonatomic, copy) NSString *company_profile; // 公司名称
@property (nonatomic, copy) NSString *org_name; // 券商名称
@property (nonatomic, copy) NSString *score; // 评分
@property (nonatomic, copy) NSString *dialing_number; // 拨号号码 多个，号分割
@property (nonatomic, copy) NSString *room_number; //房间号码
@property (nonatomic, copy) NSString *room_pwd; // 密码
@property (nonatomic, copy) NSString *live_type; // 1 为白名单直播，2 是普通直播
@property (nonatomic, copy) NSString *type; //
@property (nonatomic, copy) NSString *live_img_path;
@property (nonatomic, copy) NSString *up_down; //直播上下架状态 1已上架 2已下架
@property (nonatomic, copy) NSString *isUpDown; //是否显示上下架按钮

@end
