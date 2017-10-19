//
//  RecorderViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "RecorderViewController.h"
#import "SCRecorderViewController.h"

@interface RecorderViewController ()

@end

@implementation RecorderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"视频录制" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)btnClick {
    SCRecorderViewController *sc = [[SCRecorderViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
}



@end
