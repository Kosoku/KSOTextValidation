//
//  KSOTextValidator.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol describing a text validator object.
 */
@protocol KSOTextValidator <NSObject>
@required
/**
 Called whenever new text needs validation. The receiver should examine the provided text and return YES if it validates, otherwise NO. The receiver can provide an optional error describing the reason for failing validation.
 
 @param text The text to validate
 @param error A pointer to an NSError object that can be optionally populated
 @return YES if *text* validates, otherwise NO
 */
- (BOOL)validateText:(nullable NSString *)text error:(NSError * __autoreleasing *)error;
@optional
/**
 If the receiver responds to this method and returns a non-nil value, it will be displayed as the *rightView* of the associated UITextField.
 
 @return The right accessory view
 */
- (nullable UIView *)rightAccessoryView;
@end

NS_ASSUME_NONNULL_END
