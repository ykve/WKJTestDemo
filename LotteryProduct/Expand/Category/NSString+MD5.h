//
//  NSString+MD5.h
//  MingJie
//
//  Created by wang ding on 16/2/17.
//  Copyright © 2016年 wang ding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)MD5;
/**
 文字竖排
 */
- (NSString *)VerticalString;

+ (BOOL)isIncludeChineseInString:(NSString*)str;
+ (BOOL)isBlankString:(NSString *)str;

@end
