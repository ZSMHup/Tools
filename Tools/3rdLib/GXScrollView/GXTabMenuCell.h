//
//  GXTabMenuCell.h
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXTabMenuCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *tabMenuTitleNormalColor;
@property (nonatomic, strong) UIColor *tabMenuTitleSelectedColor;
@property (nonatomic, assign) BOOL lineHidden;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) BOOL showBadge;

@end
