//
//  TagAddCollectionViewCell.h
//  Tools
//
//  Created by 张书孟 on 2018/3/6.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagAddCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *contentString;
@property (nonatomic, copy) void(^addBtnActionBlock)(void);

@end
