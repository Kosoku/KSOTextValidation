//
//  KSOBlockTextFormatter.m
//  KSOTextValidation
//
//  Created by William Towe on 9/3/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
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

#import "KSOBlockTextFormatter.h"

#import <Stanley/Stanley.h>

@interface KSOBlockTextFormatter ()
@property (readwrite,copy,nonatomic) KSOBlockTextFormatterTextForEditingTextBlock textBlock;
@property (readwrite,copy,nonatomic) KSOBlockTextFormatterEditingTextForTextBlock editingTextBlock;
@end

@implementation KSOBlockTextFormatter
#pragma mark *** Subclass Overrides ***
#pragma mark KSOTextFormatter
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

- (void)formatEditedText:(NSString *__autoreleasing  _Nonnull *)editedText editedSelectedRange:(NSRangePointer)editedSelectedRange text:(NSString *)text selectedRange:(NSRange)selectedRange {
    if (self.formatEditedTextBlock != nil) {
        self.formatEditedTextBlock(self,editedText,editedSelectedRange,text,selectedRange);
    }
    
    // if the editedText.length would exceed our maximumLength, prevent the edits
    if (self.maximumLength > 0 &&
        (*editedText).length > self.maximumLength) {
        
        *editedText = text;
        *editedSelectedRange = selectedRange;
    }
    
    // if our allowed character set is non-nil and the edited text contains characters that do not belong to it, strip the edited text of those characters, then proceed with the edit
    if (self.allowedCharacterSet != nil &&
        [(*editedText) rangeOfCharacterFromSet:self.allowedCharacterSet.invertedSet].length > 0) {
        
        *editedText = [*editedText KST_stringByRemovingCharactersInSet:self.allowedCharacterSet.invertedSet];
        *editedSelectedRange = NSMakeRange(selectedRange.location + (*editedText).length - text.length, selectedRange.length);
    }
}
#pragma mark *** Public Methods ***
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
