//
//  RecommendlistModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RecommendlistModel.h"

@implementation RecommendlistModel

+(NSDictionary*)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}
/**
 *  计算富文本的高度
 */
- (CGFloat)getAttributedStringHeightWithText:(NSAttributedString *)attributedString andWidth:(CGFloat)width andFont:(UIFont *)font {
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

-(CGFloat)heightForRowWithisShow:(RecommendlistModel *)model
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [str attributedSubstringFromRange:NSMakeRange(str.length - 2, 2)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, str.length)];

    self.rowHeight = [self getAttributedStringHeightWithText:str andWidth:SCREEN_WIDTH - 20 andFont:[UIFont systemFontOfSize:16]] + 81 + 20;
    
    return  self.rowHeight;
   
}


//- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
//    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
//    detailLabel.font = [UIFont systemFontOfSize:fontSize];
//    detailLabel.text = value;
//    detailLabel.numberOfLines = 0;
//    CGSize deSize = [detailLabel sizeThatFits:CGSizeMake(width,1)];
//    return deSize.height;
//}

@end
