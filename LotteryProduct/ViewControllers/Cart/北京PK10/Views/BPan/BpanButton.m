//
//  BpanButton.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/31.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "BpanButton.h"
#import "UIImage+color.h"

@implementation BpanButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self setBackgroundImage:[UIImage imageWithColor:[[CPTThemeConfig shareManager] Buy_LotteryItemNormalBackgroundColor] size:self.size] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[[CPTThemeConfig shareManager] Buy_LotteryItemSelectBackgroundColor] size:self.size] forState:UIControlStateSelected];
        
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;

        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
        titleLbl.text = @"111";
        titleLbl.font = [UIFont systemFontOfSize:15];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLbl];
        
        UILabel *subTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLbl.frame), titleLbl.y, 40, titleLbl.height)];
        subTitleLbl.font = [UIFont systemFontOfSize:13];
        subTitleLbl.textColor = [UIColor lightGrayColor];
        subTitleLbl.textAlignment = NSTextAlignmentCenter;
        subTitleLbl.text = @"222";
        
        [self addSubview:subTitleLbl];
    }
    
    return self;
}


@end
