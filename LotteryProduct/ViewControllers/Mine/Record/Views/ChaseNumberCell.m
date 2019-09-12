//
//  ChaseNumberCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChaseNumberCell.h"

@implementation ChaseNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(BettingModel *)model {
    _model = model;
    NSString * imageName = [NSString stringWithFormat:@"%ld",(long)model.lotteryId];
    self.iconimgv.image = IMAGE(imageName);
    if (model.lotteryId == CPTBuyTicketType_SSC) {//重庆时时彩
        self.iconimgv.image = IMAGE(@"home_1");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_XJSSC) {//新疆时时彩
        self.iconimgv.image = IMAGE(@"home_4");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_TJSSC){
        self.iconimgv.image = IMAGE(@"天津时时彩");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_FFC) {//比特币分分彩
        self.iconimgv.image = IMAGE(@"home_6");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 9 ? [model.issue substringFromIndex:9] : model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_LiuHeCai) {//香港六合彩
        self.iconimgv.image = IMAGE(@"home_2");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_PCDD) {//PC蛋蛋
        self.iconimgv.image = IMAGE(@"home_7");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_PK10) {//北京PK10
        self.iconimgv.image = IMAGE(@"home_3");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    else if (model.lotteryId == CPTBuyTicketType_XYFT)  {//幸运飞艇
        self.iconimgv.image = IMAGE(@"home_5");
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue];
    }else{
        self.lottery_issuelab.text = [NSString stringWithFormat:@"第%@期",model.issue];
    }
    self.lottery_namelab.text = model.lotteryName;
    self.lottery_playlab.text = model.playName;
    if ([Tools hasChinese:model.betNumber] || [model.betNumber containsString:@":"]) {
        self.numberscrollView.hidden = YES;
        self.numberlab.hidden = NO;
        self.numberlab.text = model.betNumber;
    }
    else{
        self.numberlab.hidden = YES;
        self.numberscrollView.hidden = NO;
        for (id view in self.numberscrollView.subviews) {
            
            [view removeFromSuperview];
        }
        int i = 0;
        for (NSString *num in [self.model.betNumber componentsSeparatedByString:@","]) {
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectMake(25*i, 0, 25, 25) andTitle:num andTitleColor:WHITE andBackgroundImage:IMAGE(@"kj_orangeboll") andImage:nil andTarget:self andAction:nil andType:UIButtonTypeCustom];
            [self.numberscrollView addSubview:btn];
            i++;
            self.numberscrollView.contentSize = CGSizeMake(25 * i, 0);
        }
    }
    self.oddslab.text = [NSString stringWithFormat:@"赔率:%.2f",model.odds.floatValue];
    self.wincountlab.text = [NSString stringWithFormat:@"(%ld)",(long)model.winCount];
    self.winpricelab.text = [NSString stringWithFormat:@"彩金:￥%.2f",model.winAmount.floatValue];
    self.singlepricelab.text = [NSString stringWithFormat:@"单期金额:￥%.2f",model.currentBetPrice.floatValue];
    self.progresslab.text = [NSString stringWithFormat:@"进度:%ld/%ld",(long)model.appendedCount,(long)model.appendCount];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
