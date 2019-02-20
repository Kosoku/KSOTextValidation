//
//  KSOBlockTextFormatter.h
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
 */
typedef void(^KSOBlockTextFormatterFormatEditedTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString *_Nonnull * _Nonnull editedText, NSRangePointer editedSelectedRange, NSString * _Nullable text, NSRange selectedRange);

/**
 KSOBlockTextFormatter is designed to be set as the `KSO_textFormatter` of a UITextField.
 */
@interface KSOBlockTextFormatter : NSObject <KSOTextFormatter>

/**
 Set and get the maximum length of the formatted text. If > 0, edits that would make the text greater than maximumLength are not permitted.
 */
@property (assign,nonatomic) NSInteger maximumLength;

/**
 Set and get the allowed character set of the receiver. If non-nil, any edit containing characters that are not part of the provided character set are not allowed.
 
 The default is nil.
 */
@property (copy,nonatomic,nullable) NSCharacterSet *allowedCharacterSet;

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
 
 @see KSOBlockTextFormatterFormatEditedTextBlock
 */
@property (copy,nonatomic) KSOBlockTextFormatterFormatEditedTextBlock formatEditedTextBlock;

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
