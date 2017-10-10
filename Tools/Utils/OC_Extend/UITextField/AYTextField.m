//
//  AYTextField.m
//  TouyansheLive
//
//  Created by hsuyelin on 2017/7/19.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "AYTextField.h"

@interface AYTextField ()

@property (nonatomic, copy) AYTextFieldHandler changeHandler;
@property (nonatomic, copy) AYTextFieldHandler maxHandler;

@end

@implementation AYTextField

#pragma mark - super Methods
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending) {
        [self layoutIfNeeded];
    }
    
    [self initialize];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initialize];
    return self;
}

- (BOOL)becomeFirstResponder
{
    BOOL become = [super becomeFirstResponder];
    
    // 成为第一响应者时注册通知监听文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    return become;
}

- (BOOL)resignFirstResponder
{
    BOOL resign = [super resignFirstResponder];
    
    // 注销第一响应者时移除文本变化的通知, 以免影响其它的`UITextField`对象.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    return resign;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _changeHandler = NULL;
    _maxHandler = NULL;
}

#pragma mark - private
- (void)initialize
{
    _canBeCopied      = NO;
    _canBePasted      = NO;
    _canBeCut         = NO;
    _canBeSelected    = YES;
    _canBeAllSelected = NO;
    
    if (_maxLength == 0 || _maxLength == NSNotFound) _maxLength = NSUIntegerMax;
}

#pragma mark - overwrite
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    // 复制功能
    if (action == @selector(copy:)) {
        if (_canBeCopied) {
            return YES;
        } else {
            return NO;
        }
    }
    
    // 粘贴功能
    if (action == @selector(paste:)) {
        if (_canBePasted) {
            return YES;
        } else {
            return NO;
        }
    }
    
    if (action == @selector(cut:)) {
        if (_canBeCut) {
            return YES;
        } else {
            return NO;
        }
    }
    
    // 选择功能
    if (action == @selector(select:)) {
        if (_canBeSelected) {
            return YES;
        } else {
            return NO;
        }
    }
    
    // 全选功能
    if (action == @selector(selectAll:)) {
        if (_canBeAllSelected) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - public
- (void)addTextDidChangeHandler:(AYTextFieldHandler)changeHandler
{
    _changeHandler = [changeHandler copy];
}

- (void)addTextLengthDidMaxHandler:(AYTextFieldHandler)maxHandler
{
    _maxHandler = [maxHandler copy];
}

#pragma mark - notification
- (void)textFieldDidChange:(NSNotification *)notification
{
    // 通知回调的实例的不是当前实例的话直接返回
    if (notification.object != self) return;
    
    // 禁止第一个字符输入空格或者换行
    if (self.text.length == 1) {
        if ([self.text isEqualToString:@" "] || [self.text isEqualToString:@"\n"]) {
            self.text = @"";
        }
    }
    
    // 只有当maxLength字段的值不为无穷大整型也不为0时才计算限制字符数.
    if (_maxLength != NSUIntegerMax && _maxLength != 0 && self.text.length > 0) {
        if (!self.markedTextRange && self.text.length > _maxLength) {
            _maxHandler ? _maxHandler(self) : NULL; // 回调达到最大限制的Block.
            self.text = [self.text substringToIndex:_maxLength]; // 截取最大限制字符数.
        }
    }
    
    // 回调文本改变的Block.
    _changeHandler ? _changeHandler(self) : NULL;
}

@end
