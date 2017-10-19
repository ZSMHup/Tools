//
//  SCTouchDetector.m
//  SCRecorderT
//
//  Created by 张书孟 on 2017/10/18.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "SCTouchDetector.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation SCTouchDetector

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enabled) {
        self.state = UIGestureRecognizerStateBegan;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enabled) {
        self.state = UIGestureRecognizerStateEnded;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.enabled) {
        self.state = UIGestureRecognizerStateEnded;
    }
}

@end
