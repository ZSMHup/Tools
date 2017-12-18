//
//  QRCodeDemoViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "QRCodeDemoViewController.h"
#import "QRCodeGenerateViewController.h"
#import "QRCodeScanningViewController.h"
#import "QRCodeScanningSuccessVC.h"

@interface QRCodeDemoViewController ()

@end

@implementation QRCodeDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES));
    
    UIButton *generate = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    generate.backgroundColor = [UIColor redColor];
    [generate setTitle:@"生成二维码" forState:(UIControlStateNormal)];
    [generate addTarget:self action:@selector(generateClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:generate];
    
    UIButton *scanning = [[UIButton alloc] initWithFrame:CGRectMake(100, 260, 100, 30)];
    scanning.backgroundColor = [UIColor redColor];
    [scanning setTitle:@"扫描二维码" forState:(UIControlStateNormal)];
    [scanning addTarget:self action:@selector(scanningClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:scanning];
}

- (void)generateClick {
//    QRCodeGenerateViewController *generateVC = [[QRCodeGenerateViewController alloc] init];
//    generateVC.title = @"生成二维码";
//    [self.navigationController pushViewController:generateVC animated:YES];
    
    QRCodeScanningSuccessVC *vc = [[QRCodeScanningSuccessVC alloc] init];
    vc.urlString = @"http://www.jianshu.com/p/167620343089";
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)scanningClick {
    QRCodeScanningViewController *scanningVC = [[QRCodeScanningViewController alloc] init];
    scanningVC.title = @"扫描二维码";
    [self.navigationController pushViewController:scanningVC animated:YES];
}

@end
