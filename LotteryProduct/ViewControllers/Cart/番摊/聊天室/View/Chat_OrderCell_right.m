//
//  Chat_OrderCell_right.m
//  LotteryProduct
//
//  Created by pt c on 2019/5/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "Chat_OrderCell_right.h"

@implementation Chat_OrderCell_right

{
    ChatMessageModel *_model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *img = [UIImage imageNamed:@"bg-tuidan_right"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 30) resizingMode:UIImageResizingModeStretch];
    self.contentBgImgView.image = img;
}
- (void)setDataWithModel:(ChatMessageModel *)model{
    _model = model;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"mrtx"]];

    _nameLabel.text = model.nickname;

    _playNameLabel.text = [NSString stringWithFormat:@"%@第%@期",model.orderModel.lotteryName,model.orderModel.issue];
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",model.orderModel.betAmount];
    _winPercentLabel.text = [NSString stringWithFormat:@"+%@%@",model.orderModel.showProfitRate,@"%"];
    _lab1.text = [NSString stringWithFormat:@" #%@ ",model.orderModel.playName];
    _lab2.text = [NSString stringWithFormat:@" #保障赔率%@ ",model.orderModel.ensureOdds];
    _lab3.text = [NSString stringWithFormat:@" #分红%@%@ ",model.orderModel.bonusScale,@"%"];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
//关注
- (IBAction)followClick:(UIButton *)sender {
    if(_model.userId.integerValue == [Person person].uid.integerValue){
        if(self.showErrorMessage){
            self.showErrorMessage(@"不能关注自己");
        }
    }else{
        @weakify(self);
        [WebTools postWithURL:@"/wechat/addFollow.json" params:@{@"otherId":_model.orderModel.godId} success:^(BaseData *data) {
            @strongify(self);
            if(data.status.integerValue == 1){
                if(self.didReceiveRet){
                    self.didReceiveRet(data);
                }
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
}
//跟单
- (IBAction)orderClick:(UIButton *)sender {
    //    {
    //        betAmount = 3;
    //        bonusScale = 5;
    //        ensureOdds = 2;
    //        gdCount = 0;
    //        godAnalyze = "\U5927\U795e\U4e0d\U89e3\U91ca";
    //        godId = 14;
    //        heads = "http://47.75.199.227:8051/adminEntry/appMember/toUpdateMember.html?id=109";
    //        issue = 2019039;
    //        lotteryId = 1201;
    //        lotteryName = "\U516d\U5408\U5f69";
    //        nickname = "\U5f88\U6e9c";
    //        odds = "48.5";
    //        playName = "\U7279\U7801";
    //        pushOrderId = 35;
    //        secretStatus = 1;
    //        showRate = "0.0";
    //        userId = 109;
    //    }
    //    NSDictionary *dic = @{@"godPushId":_model.trackId,@"orderBetId":_model.orderModel.orderBetId,@"userId":_model.userId,@"orderAmount":_model.orderModel.betAmount};
    
    if(self.didPushOrder){
        PushOrderModel *model = [[PushOrderModel alloc] init];
        model.betAmount = _model.orderModel.betAmount;
        model.bonusScale = _model.orderModel.bonusScale.floatValue/100;
        model.ensureOdds = _model.orderModel.ensureOdds.floatValue/100;
        model.godId = _model.orderModel.godId.integerValue;
        //        model.gdCount = _model.orderModel.godId;
        model.heads = _model.head;
        model.issue = _model.orderModel.issue;
        model.lotteryId = _model.orderModel.lotteryId;
        model.lotteryName = _model.orderModel.lotteryName;
        model.nickname = _model.nickname;
        model.odds = _model.orderModel.odds;
        model.playName = _model.orderModel.playName;
        model.pushOrderId = _model.trackId.integerValue;
        model.secretStatus = 1;
        model.showRate = @"0.0";
        model.userId = _model.userId.integerValue;
        if(model.userId == [Person person].uid.integerValue){
            if(self.showErrorMessage){
                self.showErrorMessage(@"不能跟单自己的订单");
            }
        }else{
            self.didPushOrder(model);
        }
        
    }
    //    @weakify(self);
    //    [WebTools postWithURL:@"/wechat/addFollow.json" params:dic success:^(BaseData *data) {
    //        @strongify(self);
    //        if(self.didReceiveRet){
    //            self.didReceiveRet(data);
    //        }
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
}


@end
