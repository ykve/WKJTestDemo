//
//  NSString+IsBlankString.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/2.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (IsBlankString)

/*  判断字符串是否为空  */
+ (BOOL)isBlankString:(NSString *)aStr ;

/*  富文本转字符串  */
+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri;

/*  字符串转富文本  */
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr;

@end

NS_ASSUME_NONNULL_END
