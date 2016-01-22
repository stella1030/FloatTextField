//
//  NSString+Validation.m
//  TestAFNetworking
//
//  Created by chen on 16/1/22.
//  Copyright © 2016年 ding. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)
+ (BOOL)isEmpty:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNotEmpty:(NSString *)string
{
    return ![self isEmpty:string];
}
@end
