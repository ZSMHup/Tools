//
//  UIViewController+Nav.m
//  Touyanshe
//
//  Created by hsuyelin on 2017/6/26.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import "UIViewController+Nav.h"

@implementation UIViewController (Nav)

- (UINavigationController *)myNavigationController
{
    UINavigationController *nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    } else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = ((UITabBarController*)self).selectedViewController.myNavigationController;
        } else {
            nav = self.navigationController;
        }
    }
    return nav;
}

- (void)backToRootViewController
{
    if (self.presentingViewController) {
        if ([self.presentingViewController isKindOfClass:[AYTabBarController class]]) {
            [self dismissViewControllerAnimated:NO completion:^{
                AYTabBarController *mainVC = (AYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                UINavigationController *nav = [mainVC.selectedViewController isKindOfClass:[UINavigationController class]] ? (UINavigationController *)mainVC.selectedViewController : mainVC.selectedViewController.navigationController;
                if (nav.viewControllers.count > 1) {
                    [nav popToRootViewControllerAnimated:NO];
                }
                mainVC.selectedIndex = 0;
                [mainVC.customTabBar selectAtIndex:0];
            }];
        }
        else {
            UIViewController *vc = self.presentingViewController;
            [self dismissViewControllerAnimated:NO completion:^{
                [vc backToRootViewController];
            }];
        }
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
