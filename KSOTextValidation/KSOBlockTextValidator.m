//
//  KSOBlockTextValidator.m
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

#import "KSOBlockTextValidator.h"
#import "NSBundle+KSOTextValidationPrivateExtensions.h"

NSString *const KSOBlockTextValidatorErrorDomain = @"com.kosoku.ksotextvalidation.error.ksoblocktextvalidator";

@interface KSOBlockTextValidator ()
@property (copy,nonatomic) KSOBlockTextValidatorValidateBlock block;
@end

@implementation KSOBlockTextValidator
#pragma mark *** Subclass Overrides ***
#pragma mark KSOTextValidator
- (BOOL)validateText:(NSString *)text error:(NSError * _Nullable __autoreleasing *)error {
    NSError *outError;
    BOOL retval = self.block(self,text,&outError);
    
    if (retval &&
        self.minimumLength > 0 &&
        text.length < self.minimumLength) {
        
        retval = NO;
        outError = [NSError errorWithDomain:KSOBlockTextValidatorErrorDomain code:KSOBlockTextValidatorErrorCodeMinimumLength userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"text.validator.error.minimum-length", nil, [NSBundle KSO_textValidationFrameworkBundle], @"The text must have at least %lu character(s)", @"Also translate text.validator.error.minimum-length in .stringsdict file if necessary"),self.minimumLength]}];
    }
    
    if (retval &&
        self.maximumLength > 0 &&
        text.length > self.maximumLength) {
        
        retval = NO;
        outError = [NSError errorWithDomain:KSOBlockTextValidatorErrorDomain code:KSOBlockTextValidatorErrorCodeMaximumLength userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"text.validator.error.maximum-length", nil, [NSBundle KSO_textValidationFrameworkBundle], @"The text cannot have more than %lu character(s)", @"Also translate text.validator.error.maximum-length in .stringsdict file if necessary"),self.maximumLength]}];
    }
    
    if (!retval &&
        error != NULL) {
        
        *error = outError;
    }
    
    return retval;
}
#pragma mark *** Public Methods ***
- (instancetype)initWithConfigureBlock:(KSOBlockTextValidatorConfigureBlock)configureBlock validateBlock:(KSOBlockTextValidatorValidateBlock)validateBlock {
    if (!(self = [super init]))
        return nil;
    
    _block = [validateBlock copy];
    
    if (_block == nil) {
        _block = ^BOOL(KSOBlockTextValidator *v, NSString *t, NSError **e){
            return YES;
        };
    }
    
    if (configureBlock != nil) {
        configureBlock(self);
    }
    
    return self;
}
- (instancetype)initWithValidateBlock:(KSOBlockTextValidatorValidateBlock)validateBlock {
    return [self initWithConfigureBlock:nil validateBlock:validateBlock];
}

@end
