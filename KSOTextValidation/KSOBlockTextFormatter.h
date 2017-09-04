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

typedef void(^KSOBlockTextFormatterConfigureBlock)(__kindof KSOBlockTextFormatter *formatter);

typedef NSString * _Nullable(^KSOBlockTextFormatterTextForEditingTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString * _Nullable editingText);
typedef NSString * _Nullable(^KSOBlockTextFormatterEditingTextForTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString * _Nullable text);

typedef NSAttributedString * _Nullable(^KSOBlockTextFormatterAttributedTextForTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString * _Nullable text, NSDictionary<NSString *,id> *defaultAttributes);

typedef BOOL(^KSOBlockTextFormatterValidateEditedTextBlock)(__kindof KSOBlockTextFormatter *formatter, NSString *_Nonnull * _Nonnull editedText, NSRangePointer editedSelectedRange, NSString * _Nullable text, NSRange selectedRange);

@interface KSOBlockTextFormatter : NSObject <KSOTextFormatter>

@property (readonly,copy,nonatomic) KSOBlockTextFormatterTextForEditingTextBlock textBlock;
@property (readonly,copy,nonatomic) KSOBlockTextFormatterEditingTextForTextBlock editingTextBlock;

@property (copy,nonatomic) KSOBlockTextFormatterAttributedTextForTextBlock attributedTextForTextBlock;

@property (copy,nonatomic) KSOBlockTextFormatterValidateEditedTextBlock validateEditedTextBlock;

- (instancetype)initWithConfigureBlock:(nullable KSOBlockTextFormatterConfigureBlock)configureBlock textBlock:(nullable KSOBlockTextFormatterTextForEditingTextBlock)textBlock editingTextBlock:(nullable KSOBlockTextFormatterEditingTextForTextBlock)editingTextBlock NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTextBlock:(nullable KSOBlockTextFormatterTextForEditingTextBlock)textBlock editingTextBlock:(nullable KSOBlockTextFormatterEditingTextForTextBlock)editingTextBlock;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
