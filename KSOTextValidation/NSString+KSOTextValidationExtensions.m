//
//  NSString+KSOTextValidationExtensions.m
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

#import "NSString+KSOTextValidationExtensions.h"
#import "KSOTextValidationDefines.h"
#import "NSBundle+KSOTextValidationPrivateExtensions.h"

@implementation NSString (KSOTextValidationExtensions)

- (BOOL)KSO_isValidEmailAddress {
    return [self KSO_isValidEmailAddressWithError:NULL];
}
- (BOOL)KSO_isValidEmailAddressWithError:(NSError *__autoreleasing *)error {
    BOOL retval = self.length > 0 && [[NSRegularExpression regularExpressionWithPattern:@"^.+@.+\\..+$" options:0 error:NULL] firstMatchInString:self options:0 range:NSMakeRange(0, self.length)] != nil;
    
    if (error != nil) {
        if (!retval &&
            self.length > 0) {
            
            *error = [NSError errorWithDomain:KSOTextValidationErrorDomain code:KSOTextValidationErrorCodeInvalidEmailAddress userInfo:@{NSLocalizedDescriptionKey: NSLocalizedStringWithDefaultValue(@"string.error.invalid-email-address", nil, [NSBundle KSO_textValidationFrameworkBundle], @"Enter a valid email address", @"email address validator error message")}];
        }
    }
    
    return retval;
}

- (BOOL)KSO_isValidPhoneNumber {
    return [self KSO_isValidPhoneNumberWithError:NULL];
}
- (BOOL)KSO_isValidPhoneNumberWithError:(NSError *__autoreleasing *)error {
    BOOL retval = self.length > 0 && [[NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:NULL] firstMatchInString:self options:0 range:NSMakeRange(0, self.length)] != nil;
    
    if (error != nil) {
        if (!retval &&
            self.length > 0) {
            
            *error = [NSError errorWithDomain:KSOTextValidationErrorDomain code:KSOTextValidationErrorCodeInvalidPhoneNumber userInfo:@{NSLocalizedDescriptionKey: NSLocalizedStringWithDefaultValue(@"string.error.invalid-phone-number", nil, [NSBundle KSO_textValidationFrameworkBundle], @"Enter a valid phone number", @"phone number validator error message")}];
        }
    }
    
    return retval;
}

@end
