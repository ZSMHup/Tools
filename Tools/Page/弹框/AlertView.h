//
//  AlertView.h
//  Tools
//
//  Created by 张书孟 on 2017/10/19.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

+ (void)showAlertViewWithTitle:(NSString *)title block:(void(^)(NSInteger index))block;



@end
