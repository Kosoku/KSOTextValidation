//
//  ViewController.m
//  Demo-iOS
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

#import "ViewController.h"
#import "ECPhoneNumberFormatter.h"

#import <Ditko/Ditko.h>
#import <KSOTextValidation/KSOTextValidation.h>

@interface CustomTextField : KDITextField <UITextFieldDelegate>

@end

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self setDelegate:self];
    
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField setBackgroundColor:KDIColorW(0.9)];
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [textField setBackgroundColor:UIColor.whiteColor];
}

@end

@interface ViewController ()
@property (strong,nonatomic) KDITextField *emailTextField, *minMaxTextField, *onlyNumbersTextField, *phoneNumberTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEmailTextField:[[KDITextField alloc] initWithFrame:CGRectZero]];
    [self.emailTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.emailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.emailTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.emailTextField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [self.emailTextField setPlaceholder:@"Email"];
    [self.emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.emailTextField setTextContentType:UITextContentTypeEmailAddress];
    [self.emailTextField setRightViewEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    [self.emailTextField setKSO_textValidator:[KSOEmailAddressValidator emailAddressValidator]];
    [self.view addSubview:self.emailTextField];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.emailTextField}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.emailTextField, @"top": self.topLayoutGuide}]];
    
    [self setPhoneNumberTextField:[[CustomTextField alloc] initWithFrame:CGRectZero]];
    [self.phoneNumberTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.phoneNumberTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.phoneNumberTextField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [self.phoneNumberTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.phoneNumberTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.phoneNumberTextField setKeyboardType:UIKeyboardTypePhonePad];
    [self.phoneNumberTextField setTextContentType:UITextContentTypeTelephoneNumber];
    [self.phoneNumberTextField setPlaceholder:@"Phone Number"];
    [self.phoneNumberTextField setRightViewEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    [self.phoneNumberTextField setKSO_textValidator:[KSOPhoneNumberValidator phoneNumberValidator]];
    [self.phoneNumberTextField setKSO_textFormatter:[[ECPhoneNumberFormatter alloc] init]];
    [self.view addSubview:self.phoneNumberTextField];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.phoneNumberTextField}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.phoneNumberTextField, @"top": self.emailTextField}]];
    
    [self setMinMaxTextField:[[KDITextField alloc] initWithFrame:CGRectZero]];
    [self.minMaxTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.minMaxTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.minMaxTextField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [self.minMaxTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.minMaxTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.minMaxTextField setSecureTextEntry:YES];
    [self.minMaxTextField setPlaceholder:@"Password"];
    [self.minMaxTextField setKSO_textValidator:[[KSOBlockTextValidator alloc] initWithConfigureBlock:^(__kindof KSOBlockTextValidator * _Nonnull validator) {
        [validator setMinimumLength:8];
        [validator setMaximumLength:16];
    } validateBlock:nil]];
    [self.view addSubview:self.minMaxTextField];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.minMaxTextField}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.minMaxTextField, @"top": self.phoneNumberTextField}]];
    
    [self setOnlyNumbersTextField:[[KDITextField alloc] initWithFrame:CGRectZero]];
    [self.onlyNumbersTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.onlyNumbersTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.onlyNumbersTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.onlyNumbersTextField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [self.onlyNumbersTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.onlyNumbersTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.onlyNumbersTextField setPlaceholder:@"Only Numbers"];
    [self.onlyNumbersTextField setKSO_textFormatter:[[KSOBlockTextFormatter alloc] initWithConfigureBlock:^(__kindof KSOBlockTextFormatter * _Nonnull formatter) {
        [formatter setMaximumLength:8];
        [formatter setAllowedCharacterSet:NSCharacterSet.decimalDigitCharacterSet];
        [formatter setAttributedTextForTextBlock:^NSAttributedString * _Nullable(__kindof KSOBlockTextFormatter * _Nonnull formatter, NSString * _Nullable text, NSDictionary<NSString *,id> * _Nonnull defaultAttributes){
            NSMutableAttributedString *retval = [[NSMutableAttributedString alloc] initWithString:text attributes:defaultAttributes];
            unichar characters[retval.length];
            
            [retval.string getCharacters:characters range:NSMakeRange(0, retval.length)];
            
            for (NSUInteger i=0; i<retval.length; i++) {
                switch (characters[i]) {
                    case '0':
                    case '2':
                    case '4':
                    case '6':
                    case '8':
                        [retval addAttribute:NSForegroundColorAttributeName value:UIColor.blueColor range:NSMakeRange(i, 1)];
                        break;
                    default:
                        [retval addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(i, 1)];
                        break;
                }
            }
            
            return retval;
        }];
    } textBlock:nil editingTextBlock:nil]];
    [self.view addSubview:self.onlyNumbersTextField];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.onlyNumbersTextField}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.onlyNumbersTextField, @"top": self.minMaxTextField}]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.emailTextField becomeFirstResponder];
}

@end
