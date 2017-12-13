//
//  PageViewController.m
//  Tools
//
//  Created by 张书孟 on 2017/12/12.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "PageViewController.h"
#import "SwitchVCContentView.h"

@interface PageViewController ()

@property (nonatomic, strong) SwitchVCContentView *contentView;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
}

- (SwitchVCContentView *)contentView {
    if (!_contentView) {
        NSArray *controllers = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourViewController"];
        _contentView = [[SwitchVCContentView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 200) titleArray:@[@"000",@"1111",@"22",@"33333"] controllersArray:controllers];
    }
    return _contentView;
}

@end
