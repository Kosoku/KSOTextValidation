//
//  KSOFormattedTextField.m
//  KSOTextValidation
//
//  Created by William Towe on 9/3/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "KSOFormattedTextField.h"

@interface KSOFormattedTextField () <UITextFieldDelegate>

@end

@implementation KSOFormattedTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [self setDelegate:self];
    
    return self;
}

- (NSString *)text {
    NSString *retval = [super text];
    
    if (!self.isEditing &&
        self.formatter != nil) {
        
        [self.formatter getObjectValue:&retval forString:retval errorDescription:NULL];
    }
    
    return retval;
}
- (void)setText:(NSString *)text {
    [super setText:self.formatter == nil || self.isEditing ? text : [self.formatter editingStringForObjectValue:text]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [textField setText:textField.text];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.formatter != nil) {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSRange newRange = range;
        
        if (string.length > 0) {
            newRange.location += string.length;
        }
        else {
            newRange.location -= string.length;
        }
        
        UITextPosition *beginning = textField.beginningOfDocument;
        UITextRange *textRange = textField.selectedTextRange;
        NSInteger location = [textField offsetFromPosition:beginning toPosition:textRange.start];
        NSInteger length = [textField offsetFromPosition:textRange.start toPosition:textRange.end];
        
        BOOL retval = [self.formatter isPartialStringValid:&newText proposedSelectedRange:&newRange originalString:textField.text originalSelectedRange:NSMakeRange(location, length) errorDescription:NULL];
        
        if (!retval) {
            [textField setText:newText];
            
            UITextPosition *start = [textField positionFromPosition:beginning offset:newRange.location];
            UITextPosition *end = [textField positionFromPosition:start offset:newRange.length];
            
            textRange = [textField textRangeFromPosition:start toPosition:end];
            
            [textField setSelectedTextRange:textRange];
            
            [textField sendActionsForControlEvents:UIControlEventEditingChanged];
        }
        
        return retval;
    }
    return YES;
}

@end
