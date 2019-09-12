//
//  NN_Happy_Xian_normalBtn.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "NN_Happy_Xian_normalBtn.h"

@implementation NN_Happy_Xian_normalBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.bounds = CGRectMake(0, 0, 38, 38);
        [self setTitle:@"" forState:UIControlStateNormal];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){
            [self setBackgroundImage:[UIImage imageNamed:@"k2"] forState:UIControlStateNormal];
        }else if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            [self setBackgroundImage:[UIImage imageNamed:@"k2_1"] forState:UIControlStateNormal];
        }
    }
    return self;
}
@end
