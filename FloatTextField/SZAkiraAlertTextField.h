//
//  SZAkiraAlertTextField.h
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import "SZAkiraTextField.h"
IB_DESIGNABLE

@interface SZAkiraAlertTextField : SZAkiraTextField

@property (nonatomic, strong) IBInspectable NSString* alertString;

@property (nonatomic) IBInspectable UIColor *alertColor;
@end
