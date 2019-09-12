//
//  NSString+IsBlankString.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/2.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "NSString+IsBlankString.h"

@implementation NSString (IsBlankString)

+ (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/**
 *  富文本转html字符串
 */
+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length)
                         documentAttributes:tempDic
                                      error:nil];
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

/**
 *  字符串转富文本
 */
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}


@end
