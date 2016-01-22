//
//  SZTextFieldEffect.h
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTextFieldEffect : UITextField
/**
 UILabel that holds all the placeholder information
 */
@property (nonatomic,readonly) UILabel* placeholderLabel;

- (void)initialize;

/**
 Creates all the animations that are used to leave the textfield in the "entering text" state.
 */
- (void)animateViewsForTextEntry;

/**
 Creates all the animations that are used to leave the textfield in the "display input text" state.
 */
- (void)animateViewsForTextDisplay;

/**
 Draws the receiver’s image within the passed-in rectangle.
 
 - parameter rect:	The portion of the view’s bounds that needs to be updated.
 */
- (void)drawViewsForRect:(CGRect)rect;

- (void)updateViewsForBoundsChange:(CGRect)bounds;

@end
