//
//  KSOTextValidationErrorView.h
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
 KSOTextValidationErrorView displays an exclamation point in a red circle and can optionally display an NSError object if provided. It is meant to be returned as the *rightAccessoryView* of an object conforming to the KSOTextValidator protocol.
 */
@interface KSOTextValidationErrorView : UIView

/**
 Creates and returns an instance of the receiver representing the provided *error*.
 
 @param error The optional error to display
 @return The initialized instance
 */
- (instancetype)initWithError:(nullable NSError *)error NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
