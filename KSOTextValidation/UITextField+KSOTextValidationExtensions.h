//
//  UITextField+KSOTextValidationExtensions.h
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

#import <KSOTextValidation/KSOTextValidator.h>
#import <KSOTextValidation/KSOTextFormatter.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (KSOTextValidationExtensions)

/**
 Set and get the text validator of the receiver.
 
 @see KSOTextValidator
 */
@property (strong,nonatomic,nullable) id<KSOTextValidator> KSO_textValidator;

/**
 Set and get the text formatter of the receiver.
 
 @see KSOTextFormatter
 */
@property (strong,nonatomic,nullable) id<KSOTextFormatter> KSO_textFormatter;
/**
 Get the unformatted text of the receiver. If `KSO_textFormatter` is non-nil, returns the result of `textForEditingText:` with `self.text`, otherwise returns `self.text`.
 */
@property (readonly,nonatomic,nullable) NSString *KSO_unformattedText;

@end

NS_ASSUME_NONNULL_END
