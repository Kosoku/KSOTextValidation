//
//  KSOBlockTextFormatter.h
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

#import <KSOTextValidation/KSOTextFormatter.h>

NS_ASSUME_NONNULL_BEGIN

@class KSOBlockTextFormatter;

/**
 Block that is invoked to configure an instance of the receiver.
 
 @param formatter The formatter invoking the block
 */
typedef void(^KSOBlockTextFormatterConfigureBlock)(__kindof KSOBlockTextFormatter *formatter);

/**
 Block that is invoked when `textForEditingText:` would normally be called.
 
 @param formatter The formatter invoking the block
 @param editingText The editing text
 @return The unformatted text
 */
typedef NSString * _Nullable(^KSOBlockTextFormatterTextForEditingTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString * _Nullable editingText);
/**
 Block that is invoked when `editingTextForText:` would normally be called.
 
 @param formatter The formatter invoking the block
 @param text The unformatted text
 @return The formatted editing text
 */
typedef NSString * _Nullable(^KSOBlockTextFormatterEditingTextForTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString * _Nullable text);

/**
 Block that is invoked when `attributedTextForText:defaultAttributes:` would normally be called.
 
 @param formatter The formatter invoking the block
 @param text The text to format
 @param defaultAttributes The default text attributes to apply to the return value
 @return The formatted text
 */
typedef NSAttributedString * _Nullable(^KSOBlockTextFormatterAttributedTextForTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString * _Nullable text, NSDictionary<NSString *,id> *defaultAttributes);

/**
 Block that is invoked when `isEditedTextValid:editedSelectedRange:text:selectedRange:` would normally be called.
 
 @param formatter The formatter invoking the block
 @param editedText The proposed edited text
 @param editedSelectedRange The proposed edited selected range
 @param text The current text
 @param selectedRange The current selected range
 @return YES if editedText and editedSelectedRange are acceptable, otherwise NO
 */
typedef BOOL(^KSOBlockTextFormatterValidateEditedTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString *_Nonnull * _Nonnull editedText, NSRangePointer editedSelectedRange, NSString * _Nullable text, NSRange selectedRange);

/**
 KSOBlockTextFormatter is designed to be set as the `KSO_textFormatter` as the UITextField.
 */
@interface KSOBlockTextFormatter : NSObject <KSOTextFormatter>

/**
 Set and get the maximum length of the formatted text. If > 0, edits that would make the text greater than maximumLength are not permitted.
 */
@property (assign,nonatomic) NSInteger maximumLength;

/**
 Get the text block of the receiver.
 
 @see KSOBlockTextFormatterTextForEditingTextBlock
 */
@property (readonly,copy,nonatomic) KSOBlockTextFormatterTextForEditingTextBlock textBlock;
/**
 Get the editing text block of the receiver.
 
 @see KSOBlockTextFormatterEditingTextForTextBlock
 */
@property (readonly,copy,nonatomic) KSOBlockTextFormatterEditingTextForTextBlock editingTextBlock;

/**
 Set and get the attributed text for text block of the receiver.
 
 @see KSOBlockTextFormatterAttributedTextForTextBlock
 */
@property (copy,nonatomic) KSOBlockTextFormatterAttributedTextForTextBlock attributedTextForTextBlock;

/**
 Set and get the validate edited text block of the receiver.
 
 @see KSOBlockTextFormatterValidateEditedTextBlock
 */
@property (copy,nonatomic) KSOBlockTextFormatterValidateEditedTextBlock validateEditedTextBlock;

/**
 Creates and return a block text formatter instance.
 
 @param configureBlock The block to configure the receiver
 @param textBlock The text block
 @param editingTextBlock The editing text block
 @return The initialized instance
 */
- (instancetype)initWithConfigureBlock:(nullable KSOBlockTextFormatterConfigureBlock)configureBlock textBlock:(nullable KSOBlockTextFormatterTextForEditingTextBlock)textBlock editingTextBlock:(nullable KSOBlockTextFormatterEditingTextForTextBlock)editingTextBlock NS_DESIGNATED_INITIALIZER;
/**
 Calls `initWithConfigureBlock:textBlock:editingTextBlock:`, passing nil, *textBlock*, and *editingTextBlock*.
 
 @param textBlock The text block
 @param editingTextBlock The editing text block
 @return The initialized instance
 */
- (instancetype)initWithTextBlock:(nullable KSOBlockTextFormatterTextForEditingTextBlock)textBlock editingTextBlock:(nullable KSOBlockTextFormatterEditingTextForTextBlock)editingTextBlock;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
