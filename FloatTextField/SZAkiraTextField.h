//
//  SZAkiraTextField.h
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import "SZTextFieldEffect.h"
IB_DESIGNABLE

@interface SZAkiraTextField : SZTextFieldEffect

/**
 The color of the border.
 
 This property applies a color to the bounds of the control. The default value for this property is a clear color.
 */
@property (nonatomic) IBInspectable UIColor *borderColor;

/**
 The color of the placeholder text.
 
 This property applies a color to the complete placeholder string. The default value for this property is a  black color.
 */
@property (nonatomic) IBInspectable UIColor *placeholderColor;

/**
 The scale of the placeholder font.
 
 This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) IBInspectable CGFloat placeholderFontScale;

/**
 * Indicates whether the clearButton position is adjusted to align with the text
 * Defaults to 1.
 */
@property (nonatomic, assign) IBInspectable BOOL adjustsClearButtonRect;


- (CGRect)textRectForBounds:(CGRect)bounds;

@end
