//
//  AlertViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "AlertViewController.h"
#import "AlertView.h"
#import "AYAlertView.h"

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
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 100, 30)];
    [btn2 setTitle:@"系统提示弹框" forState:(UIControlStateNormal)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(150, 200, 100, 30)];
    [btn3 setTitle:@"弹框" forState:(UIControlStateNormal)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn3];
    
}

- (void)btn1Click:(UIButton *)sender {
    [AlertView showAlertViewWithTitle:nil content:@"啦啦啦啦啦啦啦啦啦" tips:nil block:^(NSInteger index) {
        if (index == 0) {
            NSLog(@"取消");
        } else {
            NSLog(@"确定：%ld", index);
        }
    }];
}

- (void)btn2Click:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"titletitletitletitletitletitletitletitle" message:@"messagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessage" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)btn3Click:(UIButton *)sender {
    [AYAlertView showWithTitle:@"title"];
}


@end
