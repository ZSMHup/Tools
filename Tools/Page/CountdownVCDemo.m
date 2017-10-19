//
//  CountdownVCDemo.m
//  Tools
//
//  Created by 张书孟 on 2017/10/16.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "CountdownVCDemo.h"
#import "UIButton+Countdown.h"

@interface CountdownVCDemo ()

@end

@implementation CountdownVCDemo

- (void)dealloc {
    NSLog(@"CountdownVCDemo dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn1 setTitle:@"10秒" forState:(UIControlStateNormal)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 140, 100, 30)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"10s" forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn3 setTitle:@"10s" forState:(UIControlStateNormal)];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 30)];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"10秒" forState:(UIControlStateNormal)];
    [btn4 addTarget:self action:@selector(btn4Click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn4];
}

- (void)btn1Click:(UIButton *)sender {
    [sender countdownWithSecond:10];
}

- (void)btn2Click:(UIButton *)sender {
    [sender countdownWithSec:10];
}

- (void)btn3Click:(UIButton *)sender {
    [sender countdownWithSec:10 completion:^{
        [sender setTitle:@"重新获取" forState:(UIControlStateNormal)];
    }];
}

- (void)btn4Click:(UIButton *)sender {
    [sender countdownWithSecond:10 completion:^{
        [sender setTitle:@"重新获取" forState:(UIControlStateNormal)];
    }];
}


@end
