//
//  AYMFMessageViewController.m
//  TouyansheLive
//
//  Created by 张书孟 on 2017/8/25.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "AYMFMessageViewController.h"

@interface AYMFMessageViewController ()

@end

@implementation AYMFMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearanceWhenContainedIn:[AYMFMessageViewController class], nil]
     setBarTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
