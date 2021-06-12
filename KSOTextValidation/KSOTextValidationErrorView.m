//
//  KSOTextValidationErrorView.m
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

#import "KSOTextValidationErrorView.h"

#import <Stanley/Stanley.h>
#import <Ditko/Ditko.h>
#if (TARGET_OS_IOS)
#import <KSOTooltip/KSOTooltip.h>
#endif

@interface KSOTextValidationErrorView ()
@property (strong,nonatomic) UIButton *button;

@property (strong,nonatomic) NSError *error;
@end

@implementation KSOTextValidationErrorView

- (CGSize)intrinsicContentSize {
    return [self sizeThatFits:CGSizeZero];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(24, 24);
}

- (instancetype)initWithError:(NSError *)error; {
    if (!(self = [super initWithFrame:CGRectMake(0, 0, [self intrinsicContentSize].width, [self intrinsicContentSize].height)]))
        return nil;
    
    _error = error;
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setUserInteractionEnabled:error != nil];
    [_button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_button setImage:({
        UIImage *retval;
        CGSize size = [self intrinsicContentSize];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
        
        [UIColor.redColor setFill];
        [[UIBezierPath bezierPathWithOvalInRect:rect] fill];
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        
        [style setAlignment:NSTextAlignmentCenter];
        
        NSString *string = @"!";
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSParagraphStyleAttributeName: style};
        CGSize stringSize = [string sizeWithAttributes:attributes];
        
        [string drawInRect:KSTCGRectCenterInRect(CGRectMake(0, 0, stringSize.width, stringSize.height),rect) withAttributes:attributes];
        
        retval = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        retval;
    }) forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _button}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _button}]];
    
    return self;
}

- (IBAction)_buttonAction:(id)sender {
    if (self.error != nil) {
#if (TARGET_OS_IOS)
        KSOTooltipView *viewController = [[KSOTooltipView alloc] initWithFrame:CGRectZero];
        KSOTooltipTheme *theme = [viewController.theme copy];
        
        [theme setFillColor:UIColor.redColor];
        [theme setTextStyle:UIFontTextStyleFootnote];
        
        [viewController setTheme:theme];
        [viewController setText:self.error.KST_alertMessage];
        [viewController setSourceView:self];
        [viewController presentAnimated:YES completion:nil];
#else
        [UIAlertController KDI_presentAlertControllerWithError:self.error];
#endif
    }
}

@end
