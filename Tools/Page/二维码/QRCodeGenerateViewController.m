//
//  QRCodeGenerateViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "QRCodeGenerateViewController.h"
#import "QRCodeGenerateManager.h"

@interface QRCodeGenerateViewController ()

@end

@implementation QRCodeGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 300, 200, 200)];
    [self.view addSubview:imageView1];
    CGFloat scale = 0.2;
    // 2、将最终合得的图片显示在UIImageView上
    imageView1.image = [QRCodeGenerateManager generateWithLogoQRCodeData:@"http://www.jianshu.com/p/821cca78f887" logoImageName:@"defaultUserIcon" logoScaleToSuperView:scale];
    
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(150, 400, 200, 200)];
//    [self.view addSubview:imageView2];
    
    // 2、将二维码显示在UIImageView上
    imageView2.image = [QRCodeGenerateManager generateWithColorQRCodeData:@"http://www.jianshu.com/p/905e83e8f827" backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8] mainColor:[CIColor colorWithRed:0.3 green:0.2 blue:0.4]];
}



@end
