//
//  UIViewController+Nav.h
//  Touyanshe
//
//  Created by hsuyelin on 2017/6/26.
//  Copyright © 2017年 hsuyelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Nav)

@property(nonatomic, strong, readonly) UINavigationController *myNavigationController;

- (void)backToRootViewController;

@end
