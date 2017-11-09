//
//  PlayerTableViewCell.h
//  Tools
//
//  Created by 张书孟 on 2017/11/9.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayer.h"
#import "VideoModel.h"

@interface PlayerTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *videoView;
@property (nonatomic, strong) VideoModel *model;

@property (nonatomic, copy) void (^playBlock)(UIButton *sender);

@end
