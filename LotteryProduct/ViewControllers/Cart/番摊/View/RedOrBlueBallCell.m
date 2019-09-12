//
//  RedOrBlueBallCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RedOrBlueBallCell.h"
#import "BallTool.h"
@implementation RedOrBlueBallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNum:(NSString *)num isRed:(BOOL)isRed opening:(BOOL)isOpening{
    [_ballBtn setTitle:num forState:UIControlStateNormal];
    if(_isHistory){
        _ballWidth.constant = 30/SCAL;
        _ballHeight.constant = 30/SCAL;
    }else{
        _ballWidth.constant = 35/SCAL;
        _ballHeight.constant = 35/SCAL;
    }
    
//    _ballBtn.bounds = CGRectMake(0, 0, 40/SCAL, 40/SCAL);
    if(isRed){
        if(_isNN){
            _ballWidth.constant = 25/SCAL;
            _ballHeight.constant = 25/SCAL;
            _ballBtn.backgroundColor = [BallTool getColorWithNum:num.integerValue];
            [_ballBtn setBackgroundImage:nil forState:UIControlStateNormal];
        }else{
            NSString *sel = [[CPTThemeConfig shareManager] RedballImg_sel];
            [_ballBtn setBackgroundImage:[UIImage imageNamed:sel] forState:UIControlStateNormal];
        }
        _ballBtn.type = CPTOpenButtonType_RedBall;
    }else{
        _ballBtn.type = CPTOpenButtonType_BludBall;
        NSString *sel = [[CPTThemeConfig shareManager] BlueballImg_sel];
        [_ballBtn setBackgroundImage:[UIImage imageNamed:sel] forState:UIControlStateNormal];
    }
    if(!_isNN){
        if(isOpening){
            [_ballBtn showOpenGif];
        }else{
            [_ballBtn dismissOpenGif];
        }
    }
    
}
@end
