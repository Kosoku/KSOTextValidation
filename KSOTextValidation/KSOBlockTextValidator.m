//
//  KSOBlockTextValidator.m
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

#import "KSOBlockTextValidator.h"

NSString *const KSOBlockTextValidatorErrorDomain = @"KSOBlockTextValidatorErrorDomain";

@interface KSOBlockTextValidator ()
@property (copy,nonatomic) KSOBlockTextValidatorValidateBlock block;
@end

@implementation KSOBlockTextValidator

- (BOOL)validateText:(NSString *)text error:(NSError * _Nullable __autoreleasing *)error {
    NSError *outError;
    BOOL retval = self.block(self,text,&outError);
    
    if (retval &&
        self.minimumLength > 0 &&
        text.length < self.minimumLength) {
        
        retval = NO;
        outError = [NSError errorWithDomain:KSOBlockTextValidatorErrorDomain code:KSOBlockTextValidatorErrorCodeMinimumLength userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedString(@"The string must be at least %@ characters long", @"block text validator minimum length error message format"),[NSNumberFormatter localizedStringFromNumber:@(self.minimumLength) numberStyle:NSNumberFormatterDecimalStyle]]}];
    }
    
    if (retval &&
        self.maximumLength > 0 &&
        text.length > self.maximumLength) {
        
        retval = NO;
        outError = [NSError errorWithDomain:KSOBlockTextValidatorErrorDomain code:KSOBlockTextValidatorErrorCodeMaximumLength userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedString(@"The string cannot be more than %@ characters long", @"block text validator maximum length error message format"),[NSNumberFormatter localizedStringFromNumber:@(self.maximumLength) numberStyle:NSNumberFormatterDecimalStyle]]}];
    }
    
    if (!retval &&
        error != NULL) {
        
        *error = outError;
    }
    
    return retval;
}

- (instancetype)initWithConfigureBlock:(KSOBlockTextValidatorConfigureBlock)configureBlock validateBlock:(KSOBlockTextValidatorValidateBlock)validateBlock {
    if (!(self = [super init]))
        return nil;
    
    _block = [validateBlock copy];
    
    if (configureBlock != nil) {
        configureBlock(self);
    }
    
    return self;
}
- (instancetype)initWithValidateBlock:(KSOBlockTextValidatorValidateBlock)validateBlock {
    return [self initWithConfigureBlock:nil validateBlock:validateBlock];
}

@end
