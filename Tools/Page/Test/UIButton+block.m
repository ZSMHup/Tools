//
//  UIButton+block.m
//  Tools
//
//  Created by 张书孟 on 2018/5/24.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/runtime.h>

@implementation UIButton (block)

static NSString *keyOfMethod;
static NSString *keyOfBlock;

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock {
    UIButton *button = [[UIButton alloc]init];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(button , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return button;
}

- (void)buttonClick:(UIButton *)button {

    ActionBlock block1 = (ActionBlock)objc_getAssociatedObject(button, &keyOfMethod);
    if(block1){
        block1(button);
    }
    
    ActionBlock block2 = (ActionBlock)objc_getAssociatedObject(button, &keyOfBlock);
    if(block2){
        block2(button);
    }
}

- (void)setActionBlock:(ActionBlock)actionBlock {
    
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    objc_setAssociatedObject(self, &keyOfBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
}

- (ActionBlock)actionBlock {
    return objc_getAssociatedObject(self ,&keyOfBlock);
}

@end
