//
//  NSString+KSOTextValidationExtensions.h
//  KSOTextValidation
//
//  Created by William Towe on 9/4/17.
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

#import <Foundation/Foundation.h>

@interface NSString (KSOTextValidationExtensions)

/**
 Returns the result of `[self KSO_isValidEmailAddressWithError:NULL]`.
 
 @return YES if the receiver is a valid email address, otherwise NO
 */
- (BOOL)KSO_isValidEmailAddress;
/**
 Returns YES if the receiver is a valid email address, otherwise NO. If NO, returns an NSError by reference describing the failure.
 
 @param error An NSError to return by reference if the method returns NO
 @return YES if the receiver is a valid email address, otherwise NO
 */
- (BOOL)KSO_isValidEmailAddressWithError:(NSError **)error;

/**
 Returns the result of `[self KSO_isValidPhoneNumberWithError:NULL]`.
 
 @return YES if the receiver is a valid phone number, otherwise NO
 */
- (BOOL)KSO_isValidPhoneNumber;
/**
 Returns YES if the receiver is a valid phone number, otherwise NO. If NO, returns an NSError by reference describing the failure.
 
 @param error An NSError to return by reference if the method returns NO
 @return YES if the receiver is a valid phone number, otherwise NO
 */
- (BOOL)KSO_isValidPhoneNumberWithError:(NSError **)error;

@end
