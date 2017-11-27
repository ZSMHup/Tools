//
//  VideoModel.h
//  Tools
//
//  Created by 张书孟 on 2017/11/9.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestModel.h"
#import "VideoResolution.h"

@interface VideoModel : NetworkRequestModel

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *video_description;
/** 视频地址 */
@property (nonatomic, copy) NSString *playUrl;
/** 封面图 */
@property (nonatomic, copy) NSString *coverForFeed;
@property (nonatomic, copy) NSString *coverForSharing;
@property (nonatomic, copy) NSString *icon;
/** 视频分辨率的数组 */
@property (nonatomic, strong) NSMutableArray *playInfo;

@end
