//
//  CAKeyframeAnimationController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/20.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "CAKeyframeAnimationController.h"

@interface CAKeyframeAnimationController ()

@end

@implementation CAKeyframeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 250, 500)];
    UIView *animView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 70, 70)];
    animView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animView];
    
    CAKeyframeAnimation *orbitAnim = [[CAKeyframeAnimation alloc] init];
    orbitAnim.keyPath = @"position";
    orbitAnim.duration = 5;
    orbitAnim.path = path.CGPath;
    orbitAnim.calculationMode = kCAAnimationPaced;
    orbitAnim.fillMode = kCAFillModeForwards;
    orbitAnim.repeatCount = HUGE_VALF;
    orbitAnim.rotationMode = kCAAnimationRotateAutoReverse;
    [animView.layer addAnimation:orbitAnim forKey:@"orbitAnim"];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 0.5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
}



@end
