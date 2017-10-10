//
//  UIView+Extension.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/11.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

- (CGFloat)left;
- (void)setLeft:(CGFloat)x;
- (CGFloat)top;
- (void)setTop:(CGFloat)y;
- (CGFloat)right;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)getX;
- (CGFloat)getY;
- (CGFloat)getWidth;
- (CGFloat)getHeight;
- (CGFloat)getMaxX;
- (CGFloat)getMaxY;

- (void)updateX:(CGFloat)X;
- (void)updateY:(CGFloat)Y;
- (void)updateWidth:(CGFloat)width;
- (void)updateHeight:(CGFloat)height;

- (void)updateSize:(CGSize)size;

@end
