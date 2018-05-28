//
//  UIButton+block.h
//  Tools
//
//  Created by 张书孟 on 2018/5/24.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIButton *button);

@interface UIButton (block)

@property (nonatomic,copy) ActionBlock actionBlock;

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock; 

@end
