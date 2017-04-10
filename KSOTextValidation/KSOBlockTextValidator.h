//
//  KSOBlockTextValidator.h
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

#import <UIKit/UIKit.h>

#import <KSOTextValidation/KSOTextValidator.h>

NS_ASSUME_NONNULL_BEGIN

@class KSOBlockTextValidator;

/**
 Block that is invoked whenever there is text to validate.
 
 @param textValidator The text validator
 @param text The text to validate
 @param error A pointer to an optional NSError describing the reason for failed validation
 @return YES if the text validates, otherwise NO
 */
typedef BOOL(^KSOBlockTextValidatorBlock)(KSOBlockTextValidator *textValidator, NSString * _Nullable text, NSError * __autoreleasing * error);

/**
 KSOBlockTextValidator is designed to be set as the *KSO_textValidator* of a UITextField. The provided block is called to perform text validation.
 */
@interface KSOBlockTextValidator : NSObject <KSOTextValidator>

/**
 Set and get the rightAccessoryView of the receiver. Set this to a non-nil value before returning from an invocation of the block to have it displayed within the associated UITextField.
 */
@property (strong,nonatomic,nullable) __kindof UIView *rightAccessoryView;

/**
 Creates and returns a block text validator instance.
 
 @param block The block to invoke when validating text
 @return The initialized instance
 */
- (instancetype)initWithBlock:(KSOBlockTextValidatorBlock)block NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
