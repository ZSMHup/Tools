//
//  RealReachabilityController.m
//  Tools
//
//  Created by 张书孟 on 2017/10/17.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "RealReachabilityController.h"
#import "RealReachability.h"

@interface RealReachabilityController ()

@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UIButton *reachabilityBtn;

@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation RealReachabilityController

- (void)dealloc {
    NSLog(@"RealReachabilityController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
    self.flagLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.flagLabel];
    
    self.reachabilityBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    self.reachabilityBtn.backgroundColor = [UIColor redColor];
    [self.reachabilityBtn setTitle:@"reachabilityBtn" forState:(UIControlStateNormal)];
    [self.reachabilityBtn addTarget:self action:@selector(testAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.reachabilityBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    NSLog(@"Initial reachability status:%@",@(status));
    
    if (status == RealStatusNotReachable) {
        self.flagLabel.text = @"Network unreachable!";
    }
    
    if (status == RealStatusViaWiFi) {
        self.flagLabel.text = @"Network wifi! Free!";
    }
    
    if (status == RealStatusViaWWAN) {
        self.flagLabel.text = @"Network WWAN! In charge!";
    }
    
    self.alert = [[UIAlertView alloc] initWithTitle:@"RealReachability" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
}

- (void)testAction:(id)sender {
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status)
        {
            case RealStatusNotReachable:
            {
                self.alert.message = @"Nothing to do! offlineMode";
                [self.alert show];
                
                break;
            }
                
            case RealStatusViaWiFi:
            {
                self.alert.message = @"Do what you want! free!";
                [self.alert show];
                
                break;
            }
                
            case RealStatusViaWWAN:
            {
                self.alert.message = @"Take care of your money! You are in charge!";
                [self.alert show];
                
                WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
                if (accessType == WWANType2G) {
                    self.flagLabel.text = @"RealReachabilityStatus2G";
                } else if (accessType == WWANType3G) {
                    self.flagLabel.text = @"RealReachabilityStatus3G";
                } else if (accessType == WWANType4G) {
                    self.flagLabel.text = @"RealReachabilityStatus4G";
                } else {
                    self.flagLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
                }
                
                break;
            }
                
            default:
                break;
        }
    }];
}

- (void)networkChanged:(NSNotification *)notification {
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    
    if (status == RealStatusNotReachable) {
        self.flagLabel.text = @"Network unreachable!";
    }
    
    if (status == RealStatusViaWiFi) {
        self.flagLabel.text = @"Network wifi! Free!";
    }
    
    if (status == RealStatusViaWWAN) {
        self.flagLabel.text = @"Network WWAN! In charge!";
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN) {
        if (accessType == WWANType2G) {
            self.flagLabel.text = @"RealReachabilityStatus2G";
        } else if (accessType == WWANType3G) {
            self.flagLabel.text = @"RealReachabilityStatus3G";
        } else if (accessType == WWANType4G) {
            self.flagLabel.text = @"RealReachabilityStatus4G";
        } else {
            self.flagLabel.text = @"Unknown RealReachability WWAN Status, might be iOS6";
        }
    }
}


@end
