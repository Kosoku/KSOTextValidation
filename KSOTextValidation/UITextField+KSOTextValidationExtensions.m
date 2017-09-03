//
//  UITextField+KSOTextValidationExtensions.m
//  KSOTextValidation
//
//  Created by William Towe on 4/9/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UITextField+KSOTextValidationExtensions.h"
#import "KSOTextValidationErrorView.h"

#import <Stanley/KSTScopeMacros.h>

#import <objc/runtime.h>

@interface KSOTextFieldTextValidatorWrapper : NSObject
@property (strong,nonatomic) id<KSOTextValidator> textValidator;
@property (weak,nonatomic) UITextField *textField;

- (instancetype)initWithTextValidator:(id<KSOTextValidator>)textValidator textField:(UITextField *)textField;
@end

@implementation KSOTextFieldTextValidatorWrapper

- (instancetype)initWithTextValidator:(id<KSOTextValidator>)textValidator textField:(UITextField *)textField; {
    if (!(self = [super init]))
        return nil;
    
    _textValidator = textValidator;
    _textField = textField;
    
    [_textField addTarget:self action:@selector(_textFieldAction:) forControlEvents:UIControlEventAllEditingEvents];
    
    return self;
}

- (IBAction)_textFieldAction:(id)sender {
    NSError *outError;
    BOOL retval = [self.textValidator validateText:self.textField.text error:&outError];
    
    if (retval) {
        [self.textField setRightView:nil];
    }
    else if (outError != nil) {
        if ([self.textValidator respondsToSelector:@selector(rightAccessoryView)] &&
            [self.textValidator rightAccessoryView] != nil) {
            
            UIView *rightAccessoryView = [self.textValidator rightAccessoryView];
            
            [rightAccessoryView sizeToFit];
            
            [self.textField setRightView:rightAccessoryView];
            [self.textField setRightViewMode:UITextFieldViewModeAlways];
        }
        else {
            KSOTextValidationErrorView *rightAccessoryView = [[KSOTextValidationErrorView alloc] initWithError:outError];
            
            [self.textField setRightView:rightAccessoryView];
            [self.textField setRightViewMode:UITextFieldViewModeAlways];
        }
    }
    else {
        [self.textField setRightView:nil];
    }
}

@end

static void *kKSOTextFieldTextFormatterWrapperObservingContext = &kKSOTextFieldTextFormatterWrapperObservingContext;

@interface KSOTextFieldFormatterWrapper : NSObject <UITextFieldDelegate>
@property (strong,nonatomic) NSFormatter *formatter;
@property (weak,nonatomic) UITextField *textField;
@property (weak,nonatomic) id<UITextFieldDelegate> realDelegate;

- (instancetype)initWithFormatter:(NSFormatter *)formatter textField:(UITextField *)textField;
@end

@implementation KSOTextFieldFormatterWrapper

- (void)dealloc {
    [_textField removeObserver:self forKeyPath:@kstKeypath(_textField,delegate) context:kKSOTextFieldTextFormatterWrapperObservingContext];
}

- (instancetype)initWithFormatter:(NSFormatter *)formatter textField:(UITextField *)textField {
    if (!(self = [super init]))
        return nil;
    
    _formatter = formatter;
    _textField = textField;
    
    [_textField addObserver:self forKeyPath:@kstKeypath(_textField,delegate) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:kKSOTextFieldTextFormatterWrapperObservingContext];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == kKSOTextFieldTextFormatterWrapperObservingContext) {
        if ([keyPath isEqualToString:@kstKeypath(self.textField,delegate)]) {
            id<UITextFieldDelegate> new = change[NSKeyValueChangeNewKey];
            
            if (new == self) {
                return;
            }
            
            if ([new isEqual:[NSNull null]]) {
                [self setRealDelegate:nil];
                [self.textField setDelegate:self];
            }
            else {
                [self setRealDelegate:new];
                [self.textField setDelegate:self];
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

@end

@implementation UITextField (KSOTextValidationExtensions)

static void const *kKSOTextValidatorKey = &kKSOTextValidatorKey;
@dynamic KSO_textValidator;
- (id<KSOTextValidator>)KSO_textValidator {
    KSOTextFieldTextValidatorWrapper *wrapper = objc_getAssociatedObject(self, kKSOTextValidatorKey);
    
    return wrapper.textValidator;
}
- (void)setKSO_textValidator:(id<KSOTextValidator>)KSO_textValidator {
    KSOTextFieldTextValidatorWrapper *wrapper = [[KSOTextFieldTextValidatorWrapper alloc] initWithTextValidator:KSO_textValidator textField:self];
    
    objc_setAssociatedObject(self, kKSOTextValidatorKey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void const *kKSOFormatterKey = &kKSOFormatterKey;
@dynamic KSO_formatter;
- (NSFormatter *)KSO_formatter {
    KSOTextFieldFormatterWrapper *wrapper = objc_getAssociatedObject(self, kKSOFormatterKey);
    
    return wrapper.formatter;
}
- (void)setKSO_formatter:(NSFormatter *)KSO_formatter {
    KSOTextFieldFormatterWrapper *wrapper = [[KSOTextFieldFormatterWrapper alloc] initWithFormatter:KSO_formatter textField:self];
    
    objc_setAssociatedObject(self, kKSOFormatterKey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
