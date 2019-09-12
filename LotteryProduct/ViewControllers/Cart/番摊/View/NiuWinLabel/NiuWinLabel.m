//
//  NiuWinLabel.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "NiuWinLabel.h"

@implementation NiuWinLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.font = [UIFont systemFontOfSize:13];
        self.textAlignment = NSTextAlignmentCenter;
        SKinThemeType sKinThemeType = [[AppDelegate shareapp] sKinThemeType];
        self.layer.borderWidth = 0.5;
        if(sKinThemeType == SKinType_Theme_Dark){//
            self.textColor = [UIColor colorWithHex:@"DD612F"];
            self.backgroundColor = [UIColor colorWithHex:@"22252B"];
            self.layer.borderColor = [UIColor clearColor].CGColor;
        }else if (sKinThemeType == SKinType_Theme_White){
            self.textColor = [UIColor colorWithHex:@"999999"];
            self.backgroundColor = [UIColor colorWithHex:@"FFFFFF"];
            self.layer.borderColor = [UIColor colorWithHex:@"999999"].CGColor;
        }
    }
    return self;
}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        // [[CPTThemeConfig shareManager] Buy_fantanTimeColor];
//        self.layer.cornerRadius = 2;
//        self.layer.masksToBounds = YES;
//        self.textColor = [UIColor colorWithHex:@"DD612F"];
//        self.backgroundColor = [UIColor colorWithHex:@"22242A"];
//    }
//    return self;
//}
@end
