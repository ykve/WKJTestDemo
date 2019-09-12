//
//  Fantan_Button.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/7.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "Fantan_Button.h"

@implementation Fantan_Button


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = 0;
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    //角
    SKinThemeType sKinThemeType = [[AppDelegate shareapp] sKinThemeType];
    NSArray *jiaoArr = @[@(0),@(4),@(21),@(25)];
    if([jiaoArr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        
        if(sKinThemeType == SKinType_Theme_White){//
            normalImgName = @"3-4j_1";
            selectImgName = @"xz_3n2_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"3-4j";
            selectImgName = @"xz_3n2";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    //念-大
    NSArray *nianArr = @[@(1),@(3),@(5),@(9),@(16),@(20),@(22),@(24)];
    if([nianArr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        if(sKinThemeType == SKinType_Theme_White){//
            normalImgName = @"3n-4_1";
            selectImgName = @"xz_3n2_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"3n-4";
            selectImgName = @"xz_3n2";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    //正
    NSArray *zhengArr = @[@(2),@(10),@(15),@(23)];
    if([zhengArr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        if(sKinThemeType == SKinType_Theme_White){//
            normalImgName = @"z3_1";
            selectImgName = @"xz_3n2_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"z3";
            selectImgName = @"xz_3n2";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    //念—小
    NSArray *nian2Arr = @[@(6),@(8),@(17),@(19)];
    if([nian2Arr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        if(sKinThemeType == SKinType_Theme_White){
            normalImgName = @"3-4j_1";
            selectImgName = @"xz_3n2_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"4n2";
            selectImgName = @"xz_3n2";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    //番3+番1  宽长
    NSArray *fan13Arr = @[@(7),@(18)];
    if([fan13Arr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        if(sKinThemeType == SKinType_Theme_White){//
            normalImgName = @"f1_1";
            selectImgName = @"xz_ds_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"f1";
            selectImgName = @"xz_ds";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    //番2 + 番4
    NSArray *fan24Arr = @[@(11),@(14)];
    if([fan24Arr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        if(sKinThemeType == SKinType_Theme_White){//
            normalImgName = @"f4_1";
            selectImgName = @"xz_f4_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"f4";
            selectImgName = @"xz_f2";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    //单双
    NSArray *danshuangArr = @[@(12),@(13)];
    if([danshuangArr containsObject:@(self.tag)]){
        NSString *normalImgName;
        NSString *selectImgName;
        if(sKinThemeType == SKinType_Theme_White){//
            normalImgName = @"ds_1";
            selectImgName = @"xz_ds_1";
        }else if (sKinThemeType == SKinType_Theme_Dark){
            normalImgName = @"ds";
            selectImgName = @"xz_ds";
        }
        [self setBackgroundImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:selectImgName] forState:UIControlStateSelected];
    }
    
}


@end
