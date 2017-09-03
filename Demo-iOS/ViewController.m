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

@interface ViewController ()
@property (strong,nonatomic) KDITextField *emailTextField;
@property (strong,nonatomic) KSOFormattedTextField *phoneNumberTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEmailTextField:[[KDITextField alloc] initWithFrame:CGRectZero]];
    [self.emailTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.emailTextField setPlaceholder:@"Email"];
    [self.emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.emailTextField setTextContentType:UITextContentTypeEmailAddress];
    [self.emailTextField setRightViewEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    [self.emailTextField setKSO_textValidator:[[KSOBlockTextValidator alloc] initWithBlock:^BOOL(KSOBlockTextValidator * _Nonnull textValidator, NSString * _Nullable text, NSError * _Nullable __autoreleasing * _Nullable error) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^.+@.+\\..+$" options:0 error:NULL];
        
        if (text.length > 0 &&
            [regex firstMatchInString:text options:0 range:NSMakeRange(0, text.length)] != nil) {
            
            return YES;
        }
        
        if (text.length > 0) {
            *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Enter a valid email address"}];
        }
        
        return NO;
    }]];
    [self.view addSubview:self.emailTextField];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.emailTextField}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.emailTextField, @"top": self.topLayoutGuide}]];
    
    [self setPhoneNumberTextField:[[KSOFormattedTextField alloc] initWithFrame:CGRectZero]];
    [self.phoneNumberTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.phoneNumberTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.phoneNumberTextField setKeyboardType:UIKeyboardTypePhonePad];
    [self.phoneNumberTextField setTextContentType:UITextContentTypeTelephoneNumber];
    [self.phoneNumberTextField setPlaceholder:@"Phone Number"];
    [self.phoneNumberTextField setFormatter:[[ECPhoneNumberFormatter alloc] init]];
    [self.view addSubview:self.phoneNumberTextField];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|" options:0 metrics:nil views:@{@"view": self.phoneNumberTextField}]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[view]" options:0 metrics:nil views:@{@"view": self.phoneNumberTextField, @"top": self.emailTextField}]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.emailTextField becomeFirstResponder];
}

@end
