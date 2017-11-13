//
//  VideoModel.m
//  Tools
//
//  Created by 张书孟 on 2017/11/9.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // 转换系统关键字description
    if ([key isEqualToString:@"description"]) {
        self.video_description = [NSString stringWithFormat:@"%@",value];
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"playInfo"]) {
        self.playInfo = @[].mutableCopy;
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dataDic in value) {
            VideoResolution *resolution = [[VideoResolution alloc] init];
            [resolution setValuesForKeysWithDictionary:dataDic];
            [array addObject:resolution];
        }
        [self.playInfo removeAllObjects];
        [self.playInfo addObjectsFromArray:array];
    } else if ([key isEqualToString:@"title"]) {
        self.title = value;
    } else if ([key isEqualToString:@"playUrl"]) {
        self.playUrl = value;
    } else if ([key isEqualToString:@"coverForSharing"]) {
        self.coverForSharing = value;
    } else if ([key isEqualToString:@"coverForFeed"]) {
        self.coverForFeed = value;
    } else if ([key isEqualToString:@"icon"]) {
        self.icon = value;
    }
    
}

@end
