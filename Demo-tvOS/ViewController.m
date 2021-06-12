//
//  ViewController.m
//  Demo-tvOS
//
//  Created by William Towe on 4/10/17.
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
    [emailTextField setKSO_textValidator:[[KSOBlockTextValidator alloc] initWithValidateBlock:^BOOL(__kindof KSOBlockTextValidator * _Nonnull validator, NSString * _Nullable text, NSError * _Nullable __autoreleasing * _Nullable error) {
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
