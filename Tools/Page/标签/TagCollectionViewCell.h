//
//  TagCollectionViewCell.h
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *contentString;

@property (nonatomic, copy) void(^deleteBtnActionBlock)(void);

@end
