//
//  TabBarController.m
//  Tools
//
//  Created by 张书孟 on 2017/11/14.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "ViewController.h"
#import "NetworkViewController.h"
#import "PlayerTableViewController.h"

static CGFloat const CYLTabBarControllerHeight = 40.f;

@interface TabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation TabBarController

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        
        CYLTabBarController *tabBarController = [CYLTabBarController
                                    tabBarControllerWithViewControllers:self.viewControllers
                                                  tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                            imageInsets:imageInsets
                                                titlePositionAdjustment:titlePositionAdjustment];
        
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
        
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    ViewController *firstViewController = [[ViewController alloc] init];
    UIViewController *firstNavigationController = [[BaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
//    NetworkViewController *secondViewController = [[NetworkViewController alloc] init];
//    UIViewController *secondNavigationController = [[BaseNavigationController alloc]
//                                                    initWithRootViewController:secondViewController];
    
    PlayerTableViewController *thirdViewController = [[PlayerTableViewController alloc] init];
    UIViewController *thirdNavigationController = [[BaseNavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
//                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"home_normal",
                                                 CYLTabBarItemSelectedImage : @"home_highlight",
                                                 };
//    NSDictionary *secondTabBarItemsAttributes = @{
//                                                  CYLTabBarItemTitle : @"第二",
//                                                  CYLTabBarItemImage : @"mycity_normal",
//                                                  CYLTabBarItemSelectedImage : @"mycity_highlight",
//                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"第三",
                                                  CYLTabBarItemImage : @"account_normal",
                                                  CYLTabBarItemSelectedImage : @"account_highlight",
                                                  };

    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
//                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
