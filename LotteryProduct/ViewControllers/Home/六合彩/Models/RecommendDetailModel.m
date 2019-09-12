//
//  RecommendDetailModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RecommendDetailModel.h"

@implementation RecommendDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"contentDTOList":@"ContentDTOList"};
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

+ (CGFloat)heightForHeader:(RecommendDetailModel *)model{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributedString.length)];
    

    CGFloat height = [self getAttributedStringHeightWithText:attributedString andWidth:SCREEN_WIDTH - 20 andFont:[UIFont systemFontOfSize:14]] + 0;
    if (height < 35.0) {
        height = 35.0;
    }
    return  height;
}

+(CGFloat)heightForRowWithisShow:(RecommendDetailModel *)model
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithData:[model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
        
    CGFloat height = [self getAttributedStringHeightWithText:str andWidth:SCREEN_WIDTH - 20 andFont:[UIFont systemFontOfSize:15]] + 0;
    
    if (height < 35.0) {
        height = 35.0;
    }
    
    return  height;
    
}

@end

@implementation LhcXsRecommendContent

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
@implementation ContentDTOList

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
