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

#import <KSOTextValidation/KSOTextValidation.h>

@interface ViewController ()
@property (strong,nonatomic) UITextField *emailTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *emailTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    [emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [emailTextField setPlaceholder:@"Email"];
    [emailTextField setKSO_textValidator:[[KSOBlockTextValidator alloc] initWithBlock:^BOOL(KSOBlockTextValidator * _Nonnull textValidator, NSString * _Nullable text, NSError * _Nullable __autoreleasing * _Nullable error) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" options:0 error:NULL];
        
        if (text.length == 0 ||
            [regex firstMatchInString:text options:0 range:NSMakeRange(0, text.length)] != nil) {
            
            return YES;
        }
        
        if (text.length > 0) {
            *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Enter a valid email address"}];
        }
        
        return NO;
    }]];
    
    [self.view addSubview:emailTextField];
    [self setEmailTextField:emailTextField];
}
- (void)viewWillLayoutSubviews {
    [self.emailTextField setFrame:CGRectMake(8, [self.topLayoutGuide length] + 8, CGRectGetWidth(self.view.bounds) - 16, [self.emailTextField sizeThatFits:CGSizeZero].height)];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.emailTextField.isFirstResponder) {
        [self.emailTextField becomeFirstResponder];
    }
}

@end
