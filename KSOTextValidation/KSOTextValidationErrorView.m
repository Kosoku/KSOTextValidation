//
//  KSOTextValidationErrorView.m
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
        KSOTooltipViewController *viewController = [[KSOTooltipViewController alloc] init];
        KSOTooltipTheme *theme = [viewController.theme copy];
        
        [theme setFillColor:UIColor.redColor];
        [theme setTextStyle:UIFontTextStyleFootnote];
        
        [viewController setTheme:theme];
        [viewController setText:self.error.KST_alertMessage];
        [viewController setSourceView:self];
        [viewController setAllowedArrowDirections:KSOTooltipArrowDirectionLeft|KSOTooltipArrowDirectionRight];
        
        [[UIAlertController KDI_viewControllerForPresenting] presentViewController:viewController animated:YES completion:nil];
#else
        [UIAlertController KDI_presentAlertControllerWithError:self.error];
#endif
    }
}

@end
