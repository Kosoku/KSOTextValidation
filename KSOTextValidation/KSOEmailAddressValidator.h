//
//  KSOEmailAddressValidator.h
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

#import <KSOTextValidation/KSOBlockTextValidator.h>

/**
 KSOEmailAddressValidator validates email addresses using NSRegularExpression and matching against the pattern @"^.+@.+\\..+$". It is not strict in any sense, but ensure the three main parts of an email have some text entered, which should be sufficient for most use cases.
 */
@interface KSOEmailAddressValidator : KSOBlockTextValidator

/**
 Convenience initializer to provide an instance of the receiver.
 
 @return An initialized instance
 */
+ (instancetype)emailAddressValidator;

@end
