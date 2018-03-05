//
//  TestViewController.m
//  Tools
//
//  Created by 张书孟 on 2018/3/5.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "TestViewController.h"
#import "NSDate+Extension.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    NSString *dateStr = @"2018-03-05 10:47:00";
    label.text = [NSDate jk_timeInfoWithDateString:dateStr];
    
    
    
    
    
    
    
    
    
    
    
    
    
}




@end
