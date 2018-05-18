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

@interface TestViewController ()

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
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    [self.view addSubview:imgView];
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"https://goss.veer.com/creative/vcg/veer/800water/veer-154679128.jpg"] placeholderImage:[UIImage imageNamed:@"0"] options:(SDWebImageRefreshCached)];
    
}

- (void)qqq {
    NSLog(@"test");
}

@end
