//
//  NSString+Validation.h
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isNotEmpty:(NSString *)string;
@end
