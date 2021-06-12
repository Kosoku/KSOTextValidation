//
//  KSOBlockTextValidator.h
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

#import <UIKit/UIKit.h>

#import <KSOTextValidation/KSOTextValidator.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Error codes for errors generated by KSOBlockTextValidator instances.
 */
typedef NS_ENUM(NSInteger, KSOBlockTextValidatorErrorCode) {
    /**
     The validated text.length < self.minimumLength.
     */
    KSOBlockTextValidatorErrorCodeMinimumLength = 1,
    /**
     The validated text.length > self.maximumLength.
     */
    KSOBlockTextValidatorErrorCodeMaximumLength
};
/**
 Error domain for errors generated by KSOBlockTextValidator instances.
 */
FOUNDATION_EXPORT NSString *const KSOBlockTextValidatorErrorDomain;

@class KSOBlockTextValidator;

/**
 Block that is invoked to configure an instance of the receiver within init.
 
 @param validator The allocated instance
 */
typedef void(^KSOBlockTextValidatorConfigureBlock)(__kindof KSOBlockTextValidator *validator);
/**
 Block that is invoked whenever there is text to validate.
 
 @param validator The text validator
 @param text The text to validate
 @param error A pointer to an optional NSError describing the reason for failed validation
 @return YES if the text validates, otherwise NO
 */
typedef BOOL(^KSOBlockTextValidatorValidateBlock)(__kindof KSOBlockTextValidator *validator, NSString * _Nullable text, NSError * __autoreleasing * error);

/**
 KSOBlockTextValidator is designed to be set as the *KSO_textValidator* of a UITextField. The provided block is called to perform text validation.
 */
@interface KSOBlockTextValidator : NSObject <KSOTextValidator>

/**
 Set and get the minimum length of text validated by the receiver.
 
 The default is 0, which means no minimum.
 */
@property (assign,nonatomic) NSInteger minimumLength;
/**
 Set and get the maximum length of text validated by the receiver.
 
 The default is 0, which means no maximum.
 */
@property (assign,nonatomic) NSInteger maximumLength;

/**
 Set and get the rightAccessoryView of the receiver. Set this to a non-nil value before returning from an invocation of the block to have it displayed within the associated UITextField.
 */
@property (strong,nonatomic,nullable) __kindof UIView *rightAccessoryView;

/**
 Creates and returns a block text validator instance.
 
 @param configureBlock The block to invoke to configure the receiver within init
 @param validateBlock The block to invoke when validating text
 @return The initialized instance
 */
- (instancetype)initWithConfigureBlock:(nullable KSOBlockTextValidatorConfigureBlock)configureBlock validateBlock:(nullable KSOBlockTextValidatorValidateBlock)validateBlock NS_DESIGNATED_INITIALIZER;
/**
 Creates and returns a block text validator instance.
 
 @param validateBlock The block to invoke when validating text
 @return The initialized instance
 */
- (instancetype)initWithValidateBlock:(KSOBlockTextValidatorValidateBlock)validateBlock;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
