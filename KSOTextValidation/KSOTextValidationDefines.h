//
//  KSOTextValidationDefines.h
//  KSOTextValidation
//
//  Created by William Towe on 9/4/17.
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

#ifndef __KSO_TEXT_VALIDATION_DEFINES__
#define __KSO_TEXT_VALIDATION_DEFINES__

#import <Foundation/Foundation.h>

/**
 Typedef describing possible KSOTextValidation errors.
 */
typedef NS_ENUM(NSInteger, KSOTextValidationErrorCode) {
    /**
     The email address was invalid.
     */
    KSOTextValidationErrorCodeInvalidEmailAddress = 1,
    /**
     The phone number was invalid.
     */
    KSOTextValidationErrorCodeInvalidPhoneNumber
};
/**
 Error domain for any KSOTextValidation errors.
 */
static NSString *const KSOTextValidationErrorDomain = @"com.kosoku.ksotextvalidation.error";

#endif
