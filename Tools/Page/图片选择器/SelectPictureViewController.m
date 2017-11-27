//
//  SelectPictureViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/22.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "SelectPictureViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface SelectPictureViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SelectPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 9 / 16)];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    _imageView = imageView;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [button setTitle:@"button" forState:(UIControlStateNormal)];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)btnClick {
    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    picker.allowCrop = YES;//是否允许裁剪
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 0;
    NSInteger widthHeight = self.view.frame.size.width;
    NSInteger top = self.view.frame.size.height / 2 - (widthHeight * 9 / 16 / 2) ;
    picker.cropRect = CGRectMake(left, top, widthHeight, widthHeight * 9 / 16);
    __weak typeof(self) weakSelf = self;
    [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        weakSelf.imageView.image = photos[0];
    }];
    [self presentViewController:picker animated:YES completion:nil];
}


@end
