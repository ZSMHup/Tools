//
//  UINavigationController+Additions.h
//  allinone
//
//  Created by Johnil on 16/3/4.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Additions)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *full_popGestureRecognizer;

@end