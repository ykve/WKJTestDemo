//
//  PushResultCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PushResultCtrl.h"

@interface PushResultCtrl ()

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_namelab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_playlab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_oddslab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_numberlab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_pricelab;
@property (weak, nonatomic) IBOutlet UILabel *winstatuslab;
@property (weak, nonatomic) IBOutlet UILabel *numbercountlab;
@property (weak, nonatomic) IBOutlet UILabel *addpricelab;
@property (weak, nonatomic) IBOutlet UILabel *bonuslab;
@property (weak, nonatomic) IBOutlet UILabel *desclab;


@end

@implementation PushResultCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"查看推荐";
    
    [self.headimgv sd_setImageWithURL:IMAGEPATH(self.model.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.namelab.text = self.model.nickname;
    self.lottery_namelab.text = [NSString stringWithFormat:@"%@第%@期",self.model.lotteryName,self.model.issue];
    self.lottery_playlab.text = self.model.playName;
    self.lottery_oddslab.text = self.model.odds;
    self.lottery_pricelab.text = [NSString stringWithFormat:@"%.2f",self.model.betAmount.floatValue];
    self.numbercountlab.text = INTTOSTRING(self.model.gdCount);
    self.addpricelab.text = [NSString stringWithFormat:@"%ld%@",self.model.bonusScale,@"%"];
    self.bonuslab.text = self.model.fenhongAmount.stringValue;
    self.winstatuslab.text = self.model.winAmount.floatValue == 0 ? @"未中奖" : self.model.winAmount.stringValue;
    
    self.desclab.text = self.model.godAnalyze;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
