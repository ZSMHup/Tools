//
//  AYTextView.h
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/21.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AYTextView;
typedef void(^AYTextViewHandler)(AYTextView *textView);

IB_DESIGNABLE

@interface AYTextView : UITextView

/** 最大限制文本长度, 默认不限制长度 */
@property (nonatomic, assign) IBInspectable NSUInteger maxLength;
/** 圆角半径 */
@property (nonatomic, assign) IBInspectable CGFloat    cornerRadius;
/** 边框宽度 */
@property (nonatomic, assign) IBInspectable CGFloat    borderWidth;
/** 边框颜色 */
@property (nonatomic, strong) IBInspectable UIColor    *borderColor;
/** placeholder */
@property (nonatomic, copy)   IBInspectable NSString   *placeholder;
/** placeholderColor颜色，默认为 #C7C7CD */
@property (nonatomic, strong) IBInspectable UIColor    *placeholderColor;
/** placeholderColor字体，字体默认和TextView一致 */
@property (nonatomic, strong) UIFont *placeholderFont; ///< placeholder文本字体, 默认为UITextView的默认字体.
/**  该属性返回一个经过处理的 `self.text` 的值, 去除了首位的空格和换行 */
@property (nonatomic, readonly) NSString *formatText;

/** 能否被复制 默认为NO */
@property (nonatomic, assign) BOOL canBeCopied;
/** 能否被粘贴 默认为NO */
@property (nonatomic, assign) BOOL canBePasted;
/** 能否被剪切 默认为NO */
@property (nonatomic, assign) BOOL canBeCut;
/** 能否被选择 默认为YES */
@property (nonatomic, assign) BOOL canBeSelected;
/** 能否被全选 默认为NO */
@property (nonatomic, assign) BOOL canBeAllSelected;

/**
 快捷构造方法

 @return 实例化的textView
 */
+ (instancetype)textView;

/**
 设定文本改变Block回调

 @param eventHandler 回调
 */
- (void)addTextDidChangeHandler:(AYTextViewHandler)eventHandler;

/**
 设定文本达到最大长度的回调

 @param maxHandler 回调
 */
- (void)addTextLengthDidMaxHandler:(AYTextViewHandler)maxHandler;

@end
