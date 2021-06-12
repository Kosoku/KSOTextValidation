//
//  KSOEmailAddressValidator.m
//  KSOTextValidation
//
//  Created by William Towe on 9/3/17.
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

#import "KSOEmailAddressValidator.h"
#import "NSString+KSOTextValidationExtensions.h"

@implementation KSOEmailAddressValidator

+ (instancetype)emailAddressValidator {
    return [[self alloc] initWithValidateBlock:^BOOL(KSOBlockTextValidator * _Nonnull textValidator, NSString * _Nullable text, NSError * _Nullable __autoreleasing * _Nullable error) {
        return [text KSO_isValidEmailAddressWithError:error];
    }];
}

@end
