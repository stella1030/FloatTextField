//
//  SZTextFieldEffect.m
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import "SZTextFieldEffect.h"

@implementation SZTextFieldEffect

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _placeholderLabel = [UILabel new];
}

/**
 Creates all the animations that are used to leave the textfield in the "entering text" state.
 */
- (void)animateViewsForTextEntry{
//    fatalError("\(__FUNCTION__) must be overridden");
}

/**
 Creates all the animations that are used to leave the textfield in the "display input text" state.
 */
- (void)animateViewsForTextDisplay{
//    fatalError("\(__FUNCTION__) must be overridden")
}

/**
 Draws the receiver’s image within the passed-in rectangle.
 
 - parameter rect:	The portion of the view’s bounds that needs to be updated.
 */
- (void)drawViewsForRect:(CGRect)rect{
//    fatalError("\(__FUNCTION__) must be overridden")
}

- (void)updateViewsForBoundsChange:(CGRect)bounds{
//    fatalError("\(__FUNCTION__) must be overridden")
}

// MARK: - Overrides

- (void)drawRect:(CGRect)rect{
    [self drawViewsForRect:rect];
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    // Don't draw any placeholders
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (text&&text.length>0) {
        [self animateViewsForTextEntry];
    }else{
        [self animateViewsForTextDisplay];
    }
}

// MARK: - UITextField Observing

- (void)willMoveToSuperview:(UIView*)newSuperview{
    if(newSuperview!=nil){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

/**
 The textfield has started an editing session.
 */
- (void)textFieldDidBeginEditing{
    [self animateViewsForTextEntry];
}

/**
 The textfield has ended an editing session.
 */
- (void)textFieldDidEndEditing{
    [self animateViewsForTextDisplay];
}

// MARK: - Interface Builder

- (void)prepareForInterfaceBuilder{
    [self drawViewsForRect:self.frame];
}

@end
