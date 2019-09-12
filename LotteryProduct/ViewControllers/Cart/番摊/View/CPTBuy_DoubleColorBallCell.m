//
//  CPTBuy_DoubleColorBallCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/12.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "CPTBuy_DoubleColorBallCell.h"

@implementation CPTBuy_DoubleColorBallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setNumWith:(NSInteger)num isRed:(BOOL)isRed andSelect:(BOOL)isSelected{
    if(num<10){
        [_ballBtn setTitle:[NSString stringWithFormat:@"0%ld",(long)num] forState:UIControlStateNormal];
    }else{
        [_ballBtn setTitle:[NSString stringWithFormat:@"%ld",(long)num] forState:UIControlStateNormal];
    }
    [_ballBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    if(isRed){
        [_ballBtn setBackgroundImage:[UIImage imageNamed:[[CPTThemeConfig shareManager] RedballImg_normal]] forState:UIControlStateNormal];
        [_ballBtn setBackgroundImage:[UIImage imageNamed:[[CPTThemeConfig shareManager] RedballImg_sel]] forState:UIControlStateSelected];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            [_ballBtn setTitleColor:[UIColor colorWithHex:@"DB2B38"] forState:UIControlStateNormal];
            [_ballBtn setTitleColor:[UIColor colorWithHex:@"FFFFFF"] forState:UIControlStateSelected];
        }else{
            [_ballBtn setTitleColor:[UIColor colorWithHex:@"DB2B38"] forState:UIControlStateNormal];
        }
        
    }else{
        [_ballBtn setBackgroundImage:[UIImage imageNamed:[[CPTThemeConfig shareManager] BlueballImg_normal]] forState:UIControlStateNormal];
        [_ballBtn setBackgroundImage:[UIImage imageNamed:[[CPTThemeConfig shareManager] BlueballImg_sel]] forState:UIControlStateSelected];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            [_ballBtn setTitleColor:[UIColor colorWithHex:@"344CC3"] forState:UIControlStateNormal];
            [_ballBtn setTitleColor:[UIColor colorWithHex:@"FFFFFF"] forState:UIControlStateSelected];
        }else{
            [_ballBtn setTitleColor:[UIColor colorWithHex:@"344CC3"] forState:UIControlStateNormal];
        }
        
    }
    if(isSelected){
        _ballBtn.selected = YES;
    }else{
        _ballBtn.selected = NO;
    }
    
}
- (IBAction)clickBall:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(self.didClick){
        self.didClick(sender);
    }
}


@end
