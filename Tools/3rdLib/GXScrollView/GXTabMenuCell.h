//
//  GXTabMenuCell.h
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/13.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXTabMenuModel : NSObject

@property (nonatomic, strong) UIColor *backgroundLayerColor;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *underlineColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL deselectDisabled;

@end

@interface GXTabMenuCell : UICollectionViewCell

@property (nonatomic, strong) GXTabMenuModel *model;

@end
