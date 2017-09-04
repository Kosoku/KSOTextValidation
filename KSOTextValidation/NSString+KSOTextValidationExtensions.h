//
//  NSString+KSOTextValidationExtensions.h
//  KSOTextValidation
//
//  Created by William Towe on 9/4/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
