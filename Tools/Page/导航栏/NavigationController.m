//
//  NavigationController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NavigationController.h"
#import "NavigationControllerTest1.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(saveToCameraRoll)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)saveToCameraRoll {
    NavigationControllerTest1 *t1 = [[NavigationControllerTest1 alloc] init];
    [self.navigationController pushViewController:t1 animated:YES];
}


@end
