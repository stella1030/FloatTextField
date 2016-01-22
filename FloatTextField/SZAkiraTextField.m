//
//  SZAkiraTextField.m
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import "SZAkiraTextField.h"
#import "NSString+Validation.h"

@interface SZAkiraTextField(){
    CGPoint _placeHolderInsets;
    CGPoint _textFieldInsets;
    
    CALayer *_borderLayer;
    
    CGFloat _borderSizeActive;
    CGFloat _borderSizeInactive;
}


/**
 * Indicates whether or not to drop the baseline when entering text. Setting to YES (not the default) means the standard greyed-out placeholder will be aligned with the entered text
 * Defaults to NO (standard placeholder will be above whatever text is entered)
 */
@property (nonatomic, assign) BOOL keepBaseline;

@end

@implementation SZAkiraTextField
//private let borderSize : (active: CGFloat, inactive: CGFloat) = (1, 2)
//private let borderLayer = CALayer()

- (void)initialize{
    [super initialize];
    
    _placeholderColor = [UIColor blackColor];
    _placeholderFontScale = 0.8f;
    
    _placeHolderInsets = CGPointMake(6, 0);
    _textFieldInsets = CGPointMake(6, 0);
    
    _borderLayer = [CALayer new];
    self.placeholderLabel.backgroundColor = [UIColor whiteColor];
    
    _borderSizeActive = 1;
    _borderSizeInactive = 2;
    
    _adjustsClearButtonRect = YES;
}

/**
 The color of the border.
 
 This property applies a color to the bounds of the control. The default value for this property is a clear color.
 */
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self updateBorder];
    
}

/**
 The color of the placeholder text.
 
 This property applies a color to the complete placeholder string. The default value for this property is a  black color.
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self updatePlaceholder];
}

/**
 The scale of the placeholder font.
 
 This property determines the size of the placeholder label relative to the font size of the text field.
 */

- (void)setPlaceholderFontScale:(CGFloat)placeholderFontScale{
    _placeholderFontScale = placeholderFontScale;
    [self updatePlaceholder];
}

- (void)setPlaceholder:(NSString *)placeholder{
    [super setPlaceholder:placeholder];
    [self updatePlaceholder];
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    [self updateBorder];
}

// MARK: TextFieldEffects

- (void)drawViewsForRect:(CGRect)rect{
    CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    self.placeholderLabel.frame = CGRectInset(frame, _placeHolderInsets.x, _placeHolderInsets.y);
    
    [self updateBorder];
    [self updatePlaceholder];
    
    [self.layer addSublayer:_borderLayer];
    [self addSubview:self.placeholderLabel];
}

- (void)animateViewsForTextEntry{
    
    [UIView animateWithDuration:0.3f animations:^{
        
//        [self updatePlaceholder];
         self.placeholderLabel.frame = CGRectMake(_placeHolderInsets.x, _borderLayer.frame.origin.y - self.placeholderLabel.bounds.size.height/2.0f, self.placeholderLabel.frame.size.width, self.placeholderLabel.frame.size.height);
        [self updateBorder];
    }];
}

- (void)animateViewsForTextDisplay{
    
    [UIView animateWithDuration:0.3f animations:^{
        [self updateBorder];
        [self updatePlaceholder];
    }];
}


// MARK: Private

- (void)updatePlaceholder{
//    self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    self.placeholderLabel.textColor = self.placeholderColor;
    self.placeholderLabel.textAlignment = self.textAlignment;
    
    [self.placeholderLabel sizeToFit];
    [self layoutPlaceholderInTextRect];
}

- (void)updateBorder{
    _borderLayer.frame = [self rectForBounds:self.bounds];
    _borderLayer.borderWidth = (self.isFirstResponder|| [NSString isNotEmpty:self.text]) ? _borderSizeActive : _borderSizeInactive;
    _borderLayer.borderColor = _borderColor.CGColor;
}

- (UIFont*)placeholderFontFromFont:(UIFont*)font{
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize * _placeholderFontScale];
    return smallerFont;
}

- (CGFloat)placeholderHeight{
    return _placeHolderInsets.y + [self placeholderFontFromFont:self.font].lineHeight;
}

- (CGRect)rectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x, bounds.origin.y + [self placeholderHeight]/2.0f, bounds.size.width, bounds.size.height - [self placeholderHeight]/2.0f);
}

// MARK: - Overrides

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    if(self.isFirstResponder || [NSString isNotEmpty:self.text]) {
        return CGRectMake(_placeHolderInsets.x, _placeHolderInsets.y, bounds.size.width, [self placeholderHeight]);
    } else {
        return [self textRectForBounds:bounds];
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds{
//    return CGRectOffset([self rectForBounds:bounds], _textFieldInsets.x, _textFieldInsets.y + [self placeholderHeight]/4);
    return CGRectOffset([self rectForBounds:bounds], _textFieldInsets.x, _textFieldInsets.y);
}

// MARK: - EXTEND
- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (0 != self.adjustsClearButtonRect) {
        if ([self.text length] || self.keepBaseline) {
            CGFloat topInset = ceilf(self.placeholderLabel.font.lineHeight/2.0f + _placeHolderInsets.y);
            topInset = MIN(topInset, [self maxTopInset]);
            rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
        }
    }
    return CGRectIntegral(rect);
}

- (CGFloat)maxTopInset
{
    return MAX(0, floorf(self.bounds.size.height - self.font.lineHeight - 4.0f));
}

- (void)layoutPlaceholderInTextRect{
    
    if([NSString isNotEmpty:self.text]){
        return;
    }
    
    CGRect textRect = [self textRectForBounds:self.bounds];
    CGFloat originX = textRect.origin.x;
    switch(self.textAlignment) {
    case NSTextAlignmentCenter:
            originX += textRect.size.width/2.0f - self.placeholderLabel.bounds.size.width/2.0f;
            break;
    case NSTextAlignmentRight:
            originX += textRect.size.width - self.placeholderLabel.bounds.size.width;
            break;
    default:
            break;
    }
    self.placeholderLabel.frame = CGRectMake(originX, textRect.size.height/2.0f, self.placeholderLabel.frame.size.width, self.placeholderLabel.frame.size.height);
}

@end
