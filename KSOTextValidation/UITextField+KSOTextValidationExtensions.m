//
//  UITextField+KSOTextValidationExtensions.m
//  KSOTextValidation
//
//  Created by William Towe on 4/9/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "UITextField+KSOTextValidationExtensions.h"
#import "KSOTextValidationErrorView.h"

#import <Stanley/Stanley.h>
#import <Ditko/Ditko.h>

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
    
    if (textValidator == nil) {
        return nil;
    }
    
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
        [self.textField setRightViewMode:UITextFieldViewModeNever];
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
        [self.textField setRightViewMode:UITextFieldViewModeNever];
    }
}

@end

@interface KSOTextFieldTextFormatterWrapper : NSObject <UITextFieldDelegate>
@property (strong,nonatomic) id<KSOTextFormatter> textFormatter;
@property (weak,nonatomic) UITextField *textField;
@property (weak,nonatomic) id<UITextFieldDelegate> delegate;
@property (copy,nonatomic) NSDictionary<NSString *, id> *defaultTextAttributes;
@property (assign,nonatomic) unsigned int delegateMethodsCount;
@property (assign,nonatomic) struct objc_method_description *delegateMethods;

- (instancetype)initWithTextFormatter:(id<KSOTextFormatter>)textFormatter textField:(UITextField *)textField;
@end

@implementation KSOTextFieldTextFormatterWrapper

- (void)dealloc {
    free(_delegateMethods);
}
// does the real delegate respond to the selector and is the selector part of the UITextFieldDelegate protocol
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        for (unsigned int i=0; i<self.delegateMethodsCount; i++) {
            if (self.delegateMethods[i].name == aSelector) {
                return YES;
            }
        }
        return NO;
    }
    return [super respondsToSelector:aSelector];
}
// only forward if the selector is part of the UITextField protocol
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        for (unsigned int i=0; i<self.delegateMethodsCount; i++) {
            if (self.delegateMethods[i].name == aSelector) {
                return self.delegate;
            }
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL retval = YES;
    
    if ([self.delegate respondsToSelector:_cmd]) {
        retval = [self.delegate textFieldShouldBeginEditing:textField];
    }
    
    if (retval) {
        NSString *text = [self.textFormatter editingTextForText:textField.text];
        NSAttributedString *attrEditingText = [self.textFormatter respondsToSelector:@selector(attributedTextForText:defaultAttributes:)] ? [self.textFormatter attributedTextForText:text defaultAttributes:self.defaultTextAttributes] : nil;
        
        if (attrEditingText == nil) {
            [textField setText:text];
        }
        else {
            [textField setAttributedText:attrEditingText];
        }
    }
    
    return retval;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL retval = YES;
    
    NSString *editedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSRange editedRange = NSMakeRange(range.location + string.length, 0);
    
    if ([self.textFormatter respondsToSelector:@selector(formatEditedText:editedSelectedRange:text:selectedRange:)]) {
        retval = NO;
        
        [self.textFormatter formatEditedText:&editedText editedSelectedRange:&editedRange text:textField.text selectedRange:KDISelectedRangeFromTextInput(textField)];
        
        NSAttributedString *attrEditedText = [self.textFormatter respondsToSelector:@selector(attributedTextForText:defaultAttributes:)] ? [self.textFormatter attributedTextForText:editedText defaultAttributes:self.defaultTextAttributes] : nil;
        
        if (attrEditedText == nil) {
            [textField setText:editedText];
        }
        else {
            [textField setAttributedText:attrEditedText];
        }
        
        [textField setSelectedTextRange:KDITextRangeFromTextInputRange(textField, editedRange)];
        
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    }
    else if ([self.textFormatter respondsToSelector:@selector(attributedTextForText:defaultAttributes:)]) {
        retval = NO;
        
        NSAttributedString *attrEditedText = [self.textFormatter respondsToSelector:@selector(attributedTextForText:defaultAttributes:)] ? [self.textFormatter attributedTextForText:editedText defaultAttributes:self.defaultTextAttributes] : nil;
        
        if (attrEditedText == nil) {
            [textField setText:editedText];
        }
        else {
            [textField setAttributedText:attrEditedText];
        }
        
        [textField setSelectedTextRange:KDITextRangeFromTextInputRange(textField, editedRange)];
        
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    }
    
    if (retval &&
        [self.delegate respondsToSelector:_cmd]) {
        
        retval = [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return retval;
}

- (instancetype)initWithTextFormatter:(id<KSOTextFormatter>)textFormatter textField:(UITextField *)textField {
    if (!(self = [super init]))
        return nil;
    
    if (textFormatter == nil) {
        return nil;
    }
    
    _textFormatter = textFormatter;
    _textField = textField;
    _defaultTextAttributes = @{NSFontAttributeName: _textField.font ?: [UIFont preferredFontForTextStyle:UIFontTextStyleBody], NSForegroundColorAttributeName: _textField.textColor ?: UIColor.blackColor};
    _delegateMethods = protocol_copyMethodDescriptionList(@protocol(UITextFieldDelegate), NO, YES, &_delegateMethodsCount);
    _delegate = _textField.delegate;
    
    [_textField setDelegate:self];
    
    return self;
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

static void const *kKSOTextFormatterKey = &kKSOTextFormatterKey;
@dynamic KSO_textFormatter;
- (id<KSOTextFormatter>)KSO_textFormatter {
    KSOTextFieldTextFormatterWrapper *wrapper = objc_getAssociatedObject(self, kKSOTextFormatterKey);
    
    return wrapper.textFormatter;
}
- (void)setKSO_textFormatter:(id<KSOTextFormatter>)KSO_textFormatter {
    KSOTextFieldTextFormatterWrapper *wrapper = [[KSOTextFieldTextFormatterWrapper alloc] initWithTextFormatter:KSO_textFormatter textField:self];
    
    objc_setAssociatedObject(self, kKSOTextFormatterKey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)KSO_unformattedText {
    return self.KSO_textFormatter == nil ? self.text : [self.KSO_textFormatter textForEditingText:self.text];
}

@end
