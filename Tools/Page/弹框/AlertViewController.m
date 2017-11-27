//
//  AlertViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "AlertViewController.h"
#import "AlertView.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(150, 100, 100, 30)];
    [btn1 setTitle:@"提示弹框" forState:(UIControlStateNormal)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
}

- (void)btn1Click:(UIButton *)sender {
//    [AlertView showAlertViewWithTitle:@"提示弹框提示弹框提示弹框提示弹框提示弹框提示弹框提示弹框提示弹框提示弹框提示弹框提示弹框" block:^(NSInteger index) {
//        if (index == 0) {
//            NSLog(@"取消");
//        } else {
//            NSLog(@"确定：%ld",index);
//        }
//    }];
    
    [AlertView showAlertViewWithTitle:@"标题" content:@"啦啦啦啦啦啦啦啦啦" tips:nil block:^(NSInteger index) {
        if (index == 0) {
            NSLog(@"取消");
        } else {
            NSLog(@"确定：%ld",index);
        }
    }];
}


@end
