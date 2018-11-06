//
//  TestToViewController.m
//  Tools
//
//  Created by 张书孟 on 2018/9/21.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "TestToViewController.h"

@interface TestToViewController ()

@end

@implementation TestToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [back setTitle:@"返回" forState:(UIControlStateNormal)];
    [back setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(backClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
}

- (void)backClick {
    
    CATransition *transtion = [CATransition animation];
    transtion.type = @"rippleEffect";
    transtion.subtype = kCATransitionFromLeft;//kCATransitionFromLeft  kCATransitionFromRight
    transtion.duration = 1;
    [self.navigationController.view.layer addAnimation:transtion forKey:@"transtion"];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
