//
//  NSString+KSOTextValidationExtensions.m
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
            
            *error = [NSError errorWithDomain:KSOTextValidationErrorDomain code:KSOTextValidationErrorCodeInvalidEmailAddress userInfo:@{NSLocalizedDescriptionKey: NSLocalizedStringWithDefaultValue(@"string.error.invalid-email-address", nil, [NSBundle KSO_textValidationFrameworkBundle], @"Enter a valid email address", @"Enter a valid email address")}];
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
            
            *error = [NSError errorWithDomain:KSOTextValidationErrorDomain code:KSOTextValidationErrorCodeInvalidPhoneNumber userInfo:@{NSLocalizedDescriptionKey: NSLocalizedStringWithDefaultValue(@"string.error.invalid-phone-number", nil, [NSBundle KSO_textValidationFrameworkBundle], @"Enter a valid phone number", @"Enter a valid phone number")}];
        }
    }
    
    return retval;
}

@end
