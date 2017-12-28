//
//  DownloadTestCell.h
//  FileDownloadManagerTest
//
//  Created by 张书孟 on 2017/12/26.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadTestCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *config;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) void(^downloadBtnClick)(UIButton *sender ,UILabel *label);
@property (nonatomic, copy) void(^deleteBtnClick)(UILabel *label);

@end
