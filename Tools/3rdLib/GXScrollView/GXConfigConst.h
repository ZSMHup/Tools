//
//  GXConfigConst.h
//  Home&ContentDemo
//
//  Created by 高翔 on 2017/7/17.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#ifndef GXConfigConst_h
#define GXConfigConst_h

#define gx_kScreenWidth [UIScreen mainScreen].bounds.size.width
#define gx_kScreenHeight [UIScreen mainScreen].bounds.size.height

#define gx_kScrollToTopNotificationName @"scrollToTop"
#define gx_kLeaveFromTopNotificationName @"leaveFromTop"
#define gx_kCanScrollKey @"canScroll"
#define gx_kOrientationKey @"orientation"
#define gx_kPositionKey @"position"

#define gx_kTabMenuOffsetTop 0
#define gx_kTabMenuHeight 44
#define gx_kTabMenuBackgroundColor [UIColor whiteColor]

#define gx_kTabMenuTitleOffset 20
#define gx_kTabMenuTitleMaxLength 120
#define gx_kTabMenuTitleFont [UIFont systemFontOfSize:14.0]
#define gx_kTabMenuTitleNormalColor [UIColor ay_fragmentNormalColor]
#define gx_kTabMenuTitleSelectedColor [UIColor ay_fragmentSelectedColor]

#define gx_kTabMenuUnderlineHeight 1.5
#define gx_kTabMenuUnderlineOffset 16
#define gx_kTabMenuUnderlineColor [UIColor ay_fragmentSelectedColor]

#endif /* GXConfigConst_h */
