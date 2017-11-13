//
//  NavigationControllerTest3.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NavigationControllerTest3.h"

@interface NavigationControllerTest3 ()

@end

@implementation NavigationControllerTest3

- (void)viewDidLoad {
    [super viewDidLoad];
    /**------------------------旋转动画-------------------------------------*/
    UIView *rorationViewX = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 70, 70)];
    rorationViewX.backgroundColor = [UIColor redColor];
    [self.view addSubview:rorationViewX];
    CABasicAnimation *rotationAnimX = [[CABasicAnimation alloc] init];
    rotationAnimX.keyPath = @"transform.rotation.x";
    rotationAnimX.beginTime = 0.0;
    rotationAnimX.toValue = @(M_PI);
    rotationAnimX.duration = 1.5;
    rotationAnimX.repeatCount = HUGE_VALF;//循环次数  HUGE_VALF：无限循环
    [rorationViewX.layer addAnimation:rotationAnimX forKey:@"rotationAnimX"];
    
    UIView *rorationViewY = [[UIView alloc] initWithFrame:CGRectMake(150, 30, 70, 70)];
    rorationViewY.backgroundColor = [UIColor redColor];
    [self.view addSubview:rorationViewY];
    CABasicAnimation *rotationAnimY = [[CABasicAnimation alloc] init];
    rotationAnimY.keyPath = @"transform.rotation.y";
    rotationAnimY.beginTime = 0.0;
    rotationAnimY.toValue = @(M_PI);
    rotationAnimY.duration = 1.5;
    rotationAnimY.repeatCount = HUGE_VALF;
    [rorationViewY.layer addAnimation:rotationAnimY forKey:@"rotationAnimY"];
    
    UIView *rorationViewZ = [[UIView alloc] initWithFrame:CGRectMake(280, 30, 70, 70)];
    rorationViewZ.backgroundColor = [UIColor redColor];
    [self.view addSubview:rorationViewZ];
    CABasicAnimation *rotationAnimZ = [[CABasicAnimation alloc] init];
    rotationAnimZ.keyPath = @"transform.rotation.z";
    rotationAnimZ.beginTime = 5.0;
    rotationAnimZ.toValue = @(M_PI);
    rotationAnimZ.duration = 1.5;
    rotationAnimZ.repeatCount = HUGE_VALF;
    [rorationViewZ.layer addAnimation:rotationAnimZ forKey:@"rotationAnimY"];
    
    /**------------------------移动动画-------------------------------------*/
    UIView *moveView = [[UIView alloc] initWithFrame:CGRectMake(20, 170, 70, 70)];
    moveView.backgroundColor = [UIColor redColor];
    moveView.center = CGPointMake(40, 170);
    moveView.layer.cornerRadius = 35;
    moveView.layer.masksToBounds = YES;
    [self.view addSubview:moveView];
    
    CABasicAnimation *moveAnim = [[CABasicAnimation alloc] init];
    moveAnim.keyPath = @"position";
    moveAnim.fromValue = @(CGPointMake(40, 170));
    moveAnim.toValue = @(CGPointMake(self.view.frame.size.width - 40, 170));
    moveAnim.duration = 2;
    moveAnim.repeatCount = HUGE_VALF;
    moveAnim.autoreverses = YES;//动画结束时是否执行逆动画
    // 以下两句 控制View动画结束后，停留在动画结束的位置
//    [moveAnim setRemovedOnCompletion:NO];
//    moveAnim.fillMode = kCAFillModeForwards;
    [moveView.layer addAnimation:moveAnim forKey:@"moveAnim"];
    
    /**------------------------背景颜色变化动画--------------------------colorView-----------*/
//    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(20, 240, 70, 70)];
//    colorView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:colorView];
//
//    CABasicAnimation *colorAnim = [[CABasicAnimation alloc] init];
//    colorAnim.keyPath = @"backgroundColor";
//    colorAnim.fromValue = (id)([UIColor greenColor].CGColor);
//    colorAnim.toValue = (id)([UIColor orangeColor].CGColor);
//    colorAnim.autoreverses = YES;
//    colorAnim.duration = 1.5;
//    colorAnim.repeatCount = HUGE_VALF;
//    [colorView.layer addAnimation:colorAnim forKey:@"colorAnim"];
    
    /**------------------------内容变化动画-------------------------------------*/
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 240, 70, 70)];
    imageView.image = [UIImage imageNamed:@"0"];
    [self.view addSubview:imageView];
    
    CABasicAnimation *contentsAnim = [[CABasicAnimation alloc] init];
    contentsAnim.keyPath = @"contents";
    contentsAnim.fromValue = (id)([UIImage imageNamed:@"1"].CGImage);
    contentsAnim.toValue = (id)([UIImage imageNamed:@"5"].CGImage);
    contentsAnim.autoreverses = YES;
    contentsAnim.duration = 1.5;
    contentsAnim.repeatCount = HUGE_VALF;
    [imageView.layer addAnimation:contentsAnim forKey:@"contentsAnim"];
    
    /**------------------------圆角变化动画-------------------------------------*/
    UIView *cornerRadiusView = [[UIView alloc] initWithFrame:CGRectMake(280, 240, 70, 70)];
    cornerRadiusView.backgroundColor = [UIColor redColor];
    cornerRadiusView.layer.masksToBounds = YES;
    [self.view addSubview:cornerRadiusView];
    
    CABasicAnimation *cornerRadiusAnim = [[CABasicAnimation alloc] init];
    cornerRadiusAnim.keyPath = @"cornerRadius";
    cornerRadiusAnim.fromValue = @(35);
    cornerRadiusAnim.toValue = @(2);
    cornerRadiusAnim.duration = 2;
    cornerRadiusAnim.repeatCount = HUGE_VALF;
    cornerRadiusAnim.autoreverses = YES;//动画结束时是否执行逆动画
    [cornerRadiusView.layer addAnimation:cornerRadiusAnim forKey:@"cornerRadiusAnim"];
    
    
    /**------------------------透明动画-------------------------------------*/
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(20, 380, 70, 70)];
    alphaView.backgroundColor = [UIColor redColor];
    [self.view addSubview:alphaView];
    
    CABasicAnimation *alphaAnim = [[CABasicAnimation alloc] init];
    alphaAnim.keyPath = @"opacity";
    alphaAnim.fromValue = @(0.3);
    alphaAnim.toValue = @(1);
    alphaAnim.duration = 0.6;
    alphaAnim.repeatCount = HUGE_VALF;
    alphaAnim.autoreverses = YES;//动画结束时是否执行逆动画
    [alphaView.layer addAnimation:alphaAnim forKey:@"alphaAnim"];
}



@end
