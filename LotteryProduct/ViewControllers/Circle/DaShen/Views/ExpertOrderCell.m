//
//  ExpertOrderCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ExpertOrderCell.h"

@implementation ExpertOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, -M_PI_4);
    self.resultstautlView.transform = transform;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFinishStatus:(NSInteger)finishStatus {
    
    _finishStatus = finishStatus;
    
    if (finishStatus == 1) {
        
        [self.publishBtn setBackgroundColor:[UIColor darkTextColor]];
        [self.publishBtn setTitle:@"立即跟单" forState:UIControlStateNormal];
        self.resultstautlView.alpha = 0;
    }
    else{
        [self.publishBtn setBackgroundColor:CLEAR];
        [self.publishBtn setTitle:@"查看订单详情 >" forState:UIControlStateNormal];
        self.resultstautlView.alpha = 1;
        self.publishBtn.hidden = YES;
    }
}
-(void)setModel:(PushOrderModel *)model {
    
    _model = model;
    
//    self.secretlab.text = model.secretStatus == 1 ? @"跟单后公开" : @"开奖后公开";
    
    self.publishBtn.hidden = [Person person].uid.integerValue == model.userId ? YES : NO;
    if (self.finishStatus == 3) {
        
        self.publishBtn.hidden = NO;
    }
    self.lottery_playlab.text = model.playName;
    self.lottery_oddslab.text = model.odds;
    self.lottery_namelab.text = model.lotteryName;
    self.lottery_pricelab.text = [NSString stringWithFormat:@"%.2f",model.betAmount.floatValue];
    self.addpricelab.text = [NSString stringWithFormat:@"%.2f%@",model.bonusScale,@"%"];
    self.safelab.text = [NSString stringWithFormat:@"%.2f",model.ensureOdds];
    self.totalpricelab.text = [NSString stringWithFormat:@"%.2f",model.betAmount.floatValue];
    self.numbercountlab.text = INTTOSTRING(model.gdCount);
    
    if (model.issue.length > 8) {
        
        self.lottery_issuelab.text = [model.issue substringFromIndex:model.lotteryId == 3 ? 9 : 8];
    }
    else {
        self.lottery_issuelab.text = model.issue;
    }
    if (model.winAmount.floatValue == 0) {
        
        self.resultimgv.image = IMAGE(@"weizhongjiang");
        self.resultpricelab.hidden = YES;
    }
    else {
        self.resultimgv.image = IMAGE(@"zhongjiang");
        self.resultpricelab.hidden = NO;
        self.resultpricelab.text = [NSString stringWithFormat:@"%.2f元",model.winAmount.floatValue];
    }
}

- (IBAction)publishClick:(UIButton *)sender {
    
    if (self.publishBlock) {
        
        self.publishBlock();
    }
}


@end
