//
//  SZAkiraAlertTextField.m
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import "SZAkiraAlertTextField.h"
#import "NSString+Validation.h"

@interface SZAkiraAlertTextField(){
    
    UILabel *_alertLabel;
    CGPoint _alertInsets;
}

@end
@implementation SZAkiraAlertTextField

- (void)initialize{
    [super initialize];
    
    _alertLabel = [UILabel new];
    _alertLabel.alpha = 0.0f;
    _alertInsets = CGPointMake(6, 0);
    
}


- (void)setAlertString:(NSString *)alertString{
    _alertString = alertString;
    _alertLabel.text = self.alertString;
}

- (void)setAlertColor:(UIColor *)alertColor{
    _alertColor = alertColor;
    _alertLabel.textColor = alertColor;
}

- (void)updateAlertLabel{
    _alertLabel.frame = [self alertRectForBounds:self.bounds];
    _alertLabel.text = self.alertString;
    _alertLabel.font = self.font;
    _alertLabel.textColor = self.alertColor;
    _alertLabel.textAlignment = self.textAlignment;
}

- (CGRect)alertRectForBounds:(CGRect)bounds{
    
    return [self textRectForBounds:bounds];
}

- (CGFloat)alertHeight{
    return _alertInsets.y + self.font.lineHeight;
}

// MARK: TextFieldEffects

- (void)drawViewsForRect:(CGRect)rect{
    [super drawViewsForRect:rect];
    
    [self updateAlertLabel];
    
    [self addSubview:_alertLabel];
}

- (void)animateViewsForTextEntry{
    [super animateViewsForTextEntry];
    if([NSString isEmpty:self.text]){
        
        [UIView animateWithDuration:0.3f animations:^{
            _alertLabel.alpha = 1.0f;
        }];
    }
}

- (void)animateViewsForTextDisplay{
    [super animateViewsForTextDisplay];
    [UIView animateWithDuration:0.3f animations:^{
        _alertLabel.alpha = 0.0f;
    }];
}

- (void)willMoveToSuperview:(UIView*)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if(newSuperview!=nil){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)textFieldTextDidChange{
    if ([NSString isNotEmpty:self.text]) {
        _alertLabel.alpha = 0.0f;
    }else{
        _alertLabel.alpha = 1.0f;
    }
}
@end
