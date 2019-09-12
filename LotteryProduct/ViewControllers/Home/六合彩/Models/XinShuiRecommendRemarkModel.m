//
//  XinShuiRecommendRemarkModel.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/27.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "XinShuiRecommendRemarkModel.h"

@implementation XinShuiRecommendRemarkModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}


+(CGFloat)heightForRowWithReMarkContent:(XinShuiRecommendRemarkModel *)model
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithData:[model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    CGFloat height = [self getAttributedStringHeightWithText:str andWidth:SCREEN_WIDTH - 20 andFont:[UIFont systemFontOfSize:14]] + 30;
    
    if (height < 35.0) {
        height = 35.0;
    }
    
    return  height;
    
}

/**
 *  计算富文本的高度
 */
+ (CGFloat)getAttributedStringHeightWithText:(NSAttributedString *)attributedString andWidth:(CGFloat)width andFont:(UIFont *)font {
    static UILabel *stringLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//生成一个同于计算文本高度的label
        stringLabel = [[UILabel alloc] init];
        stringLabel.numberOfLines = 0;
    });
    stringLabel.font = font;
    stringLabel.attributedText = attributedString;
    
    return [stringLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)].height;;
}


@end
