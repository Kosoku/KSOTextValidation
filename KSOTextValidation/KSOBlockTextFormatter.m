//
//  KSOBlockTextFormatter.m
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

#import "KSOBlockTextFormatter.h"

@interface KSOBlockTextFormatter ()
@property (readwrite,copy,nonatomic) KSOBlockTextFormatterTextForEditingTextBlock textBlock;
@property (readwrite,copy,nonatomic) KSOBlockTextFormatterEditingTextForTextBlock editingTextBlock;
@end

@implementation KSOBlockTextFormatter

- (NSString *)textForEditingText:(NSString *)editingText {
    return self.textBlock(self,editingText);
}
- (NSString *)editingTextForText:(NSString *)text {
    return self.editingTextBlock(self,text);
}

- (NSAttributedString *)attributedTextForText:(NSString *)text defaultAttributes:(NSDictionary<NSString *,id> *)defaultAttributes {
    if (self.attributedTextForTextBlock == nil) {
        return nil;
    }
    return self.attributedTextForTextBlock(self,text,defaultAttributes);
}

- (BOOL)isEditedTextValid:(NSString *__autoreleasing  _Nonnull *)editedText editedSelectedRange:(NSRangePointer)editedSelectedRange text:(NSString *)text selectedRange:(NSRange)selectedRange {
    if (self.validateEditedTextBlock != nil) {
        return self.validateEditedTextBlock(self,editedText,editedSelectedRange,text,selectedRange);
    }
    return YES;
}

- (instancetype)initWithConfigureBlock:(KSOBlockTextFormatterConfigureBlock)configureBlock textBlock:(KSOBlockTextFormatterTextForEditingTextBlock)textBlock editingTextBlock:(KSOBlockTextFormatterEditingTextForTextBlock)editingTextBlock {
    if (!(self = [super init]))
        return nil;
    
    _textBlock = [textBlock copy];
    _editingTextBlock = [editingTextBlock copy];
    
    if (_textBlock == nil) {
        _textBlock = ^NSString*(KSOBlockTextFormatter *s, NSString *text){
            return text;
        };
    }
    if (_editingTextBlock == nil) {
        _editingTextBlock = ^NSString*(KSOBlockTextFormatter *s, NSString *editingText){
            return editingText;
        };
    }
    
    if (configureBlock != nil) {
        configureBlock(self);
    }
    
    return self;
}
- (instancetype)initWithTextBlock:(KSOBlockTextFormatterTextForEditingTextBlock)textBlock editingTextBlock:(KSOBlockTextFormatterEditingTextForTextBlock)editingTextBlock {
    return [self initWithConfigureBlock:nil textBlock:textBlock editingTextBlock:editingTextBlock];
}

@end
