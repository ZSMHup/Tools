//
//  TestViewController.m
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "TestViewController.h"
#import "HYBImageCliped.h"
#import <Masonry.h>
#import <NSDate+AYDate.h>
#import <Macro/AYMacro.h>
#import <UIView+AYView.h>
#import <Macro/AYNotification.h>
#import <AYTextHelper/UILabel+AYLabelTextHelper.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UINavigationController+Additions.h"
#import <AYMenuView/AYMenuView.h>

#import "UIImage+Category.h"
#import "UIButton+block.h"
#import <objc/runtime.h>
#import <OBShapedButton/OBShapedButton.h>

#import "DownloadViewController.h"

@interface TestViewController () <AYMenuViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(100, 64, 100, 100)];
////    [test hyb_setImage:[UIImage imageNamed:@"0"] size:CGSizeMake(100, 100) cornerRadius:50.0 rectCorner:(UIRectCornerAllCorners) backgroundColor:[UIColor whiteColor] isEqualScale:NO onCliped:^(UIImage *clipedImage) {
////
////    }];
//    test.backgroundColor = [UIColor redColor];
//    [test hyb_addCorner:UIRectCornerAllCorners cornerRadius:20];
//    [self.view addSubview:test];
    
//    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
//    sc.contentSize = CGSizeMake(4 * self.view.frame.size.width, 0);
//    [self.view addSubview:sc];
//
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"labellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabellabel";
//    [sc addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(sc);
//    }];
//
//    NSLog(@"%@", kSystemVersion);
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 100)];
//
//    [label drawLineWidth:1 lineLength:5 lineSpacing:5 lineColor:[UIColor redColor] fillColor:[UIColor greenColor] cornerRadius:2];
//
//    [self.view addSubview:label];
//
//    NotificationRegister(self, @selector(qqq), TEST, nil);
//
//    kPostNotificationName(TEST);
    
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    [self.view addSubview:label];
//
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self.view);
//    }];
//
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
//
//    NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"因为解析的数据里面有html标签，就使用下面的代码把字符串转换成data，初始化时再用HTML类型，转换为富文本" attributes:
//                                @{NSForegroundColorAttributeName: [UIColor redColor]}];
//    NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:@"qwertyuiopasdfghjjkl" attributes:
//                                @{
//                                  NSLinkAttributeName: @"qwe",
//                                  NSForegroundColorAttributeName: [UIColor greenColor],
//                                  }];
//
//    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//    attch.image = [UIImage imageNamed:@"0"];
//    CGFloat pointSize = label.font.pointSize;
//    attch.bounds = CGRectMake(0, 0, 30, 30);
//
//    NSAttributedString *att3 = [NSAttributedString attributedStringWithAttachment:attch];
//
//    [attString appendAttributedString:att1];
//    [attString appendAttributedString:att2];
//    [attString appendAttributedString:att3];
//
//    label.attributedText = attString;
//
//    [label setAy_tapBlock:^(NSInteger index, NSAttributedString *charAttributedString) {
//        NSRange range = NSMakeRange(0, 1);
//        NSString *link = [charAttributedString attribute:NSLinkAttributeName atIndex:0 effectiveRange:&range];
//        NSString *attch = [charAttributedString attribute:NSAttachmentAttributeName atIndex:0 effectiveRange:&range];
//        NSLog(@"%ld -- %@ -- %@ -- %@", (long)index, charAttributedString, link, attch);
//    }];
    
    
    
//    dispatch_after(dispatch_time_delay(1.5), dispatch_get_main_queue(), ^{
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
//        imgView.userInteractionEnabled = YES;
//        [self.view addSubview:imgView];
//        imgView.image = [UIImage ay_imageNamed:@"0"];
////        [imgView sd_setImageWithURL:[NSURL URLWithString:@"https://goss.veer.com/creative/vcg/veer/800water/veer-154679128.jpg"] placeholderImage:[UIImage imageNamed:@"0"] options:(SDWebImageRefreshCached)];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//        tap.numberOfTouchesRequired = 1;
//        [imgView addGestureRecognizer:tap];
//    });
    self.view.backgroundColor = [UIColor lightGrayColor];
    OBShapedButton *btn1 = [[OBShapedButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:@"一键呼叫"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    OBShapedButton *btn2 = [[OBShapedButton alloc] init];
    [btn2 setImage:[UIImage imageNamed:@"佑拜商城"] forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn2];
    
    OBShapedButton *btn3 = [[OBShapedButton alloc] init];
    [btn3 setImage:[UIImage imageNamed:@"远程祭扫"] forState:(UIControlStateNormal)];
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn3];
    
    OBShapedButton *btn4 = [[OBShapedButton alloc] init];
    [btn4 setImage:[UIImage imageNamed:@"纪念堂"] forState:(UIControlStateNormal)];
    [btn4 addTarget:self action:@selector(btn4Click) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn4];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-81);
        make.size.mas_equalTo(CGSizeMake(159, 159));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(81);
        make.size.mas_equalTo(CGSizeMake(159, 159));
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-81);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(159, 159));
    }];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(81);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(159, 159));
    }];
    
}

- (void)qqq {
    NSLog(@"test");
}

- (void)btn1Click {
    NSLog(@"1");
    DownloadViewController *test = [[DownloadViewController alloc] init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:test animated:NO];
}

- (void)btn2Click {
    NSLog(@"2");
}

- (void)btn3Click {
    NSLog(@"3");
}

- (void)btn4Click {
    NSLog(@"4");
}


- (void)tapAction {
    [AYMenuView menuWithTitles:@[@"0", @"1", @"2", @"3"] images:@[@"0", @"1", @"2", @"3"] frame:CGRectMake(150, 478, 100, 150) direction:(AYMenuViewArrowDirectionTopCenter) delegate:self];
}
    
- (void)menuView:(AYMenuView *)menuView didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}
    
@end
