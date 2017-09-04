//
//  KSOTextFormatter.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol describing a text formatter object.
 */
@protocol KSOTextFormatter <NSObject>
@required
/**
 Returns the unformatted text from the text that was edited. For example, when formatting phone numbers, this might return the phone number with all non digit characters removed.
 
 @param editingText The text that was edited
 @return The unformatted text
 */
- (nullable NSString *)textForEditingText:(nullable NSString *)editingText;
/**
 Returns the formatted text for editing from the unformatted text. For example, when formatting phone numbers, this might return the base phone number with additional characters making it easier to read (e.g. @"1234567890" -> @"(123) 456-7890").
 
 @param text The unformatted text
 @return The text that should be displayed for editing
 */
- (nullable NSString *)editingTextForText:(nullable NSString *)text;
@optional
/**
 Returns the attributed text for the provided text value. If certain formatting should be applied to the plain text value, this method should create and return an attributed string with those additional attributes. It should first apply the *defaultAttributes*.
 
 @param text The text to turn into an attributed string
 @param defaultAttributes The default attributes to apply to the return attributed string
 @return The attributed string
 */
- (nullable NSAttributedString *)attributedTextForText:(nullable NSString *)text defaultAttributes:(NSDictionary<NSString *,id> *)defaultAttributes;
/**
 Returns YES if the proposed *editedText* is acceptable, which contains the new string after edits have been applied. *editedSelectedRange* contains the new selected range of the receiver. If you return NO, you can return a new string by reference to *editedText* and a new selected range by reference to *editedSelectedRange*.
 
 @param editedText A pointer to what will be the text of the receiver
 @param editedSelectedRange A pointer to what will be the selected range of receiver
 @param text The current text of the receiver
 @param selectedRange The current selected range of the receiver
 @return YES if the proposed edits should be applied with adjustment, otherwise NO
 */
- (BOOL)isEditedTextValid:(NSString * _Nonnull * _Nonnull)editedText editedSelectedRange:(NSRangePointer)editedSelectedRange text:(NSString *)text selectedRange:(NSRange)selectedRange;
@end

NS_ASSUME_NONNULL_END
