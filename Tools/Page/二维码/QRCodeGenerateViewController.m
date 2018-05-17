//
//  QRCodeGenerateViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "QRCodeGenerateViewController.h"
#import <AYQRCodeManager/AYQRCodeGenerateManager.h>

@interface QRCodeGenerateViewController ()

@end

@implementation QRCodeGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    [self.view addSubview:imageView1];
    CGFloat scale = 0.2;
    imageView1.image = [AYQRCodeGenerateManager generateWithLogoQRCodeData:@"http://www.jianshu.com/p/821cca78f887" logoImageName:@"defaultUserIcon" logoScaleToSuperView:scale];


//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 200, 200)];
//    [self.view addSubview:imageView2];
//
//    imageView2.image = [AYQRCodeGenerateManager generateWithColorQRCodeData:@"http://www.jianshu.com/p/905e83e8f827" backgroundColor:[CIColor colorWithRed:0.2 green:0.3 blue:0.4] mainColor:[CIColor colorWithRed:1 green:1 blue:1]];
}



@end
