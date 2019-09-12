//
//  ForrowOrderViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ForrowOrderViewController.h"

@interface ForrowOrderViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *lotterynamelab;
@property (weak, nonatomic) IBOutlet UILabel *playnamelab;
@property (weak, nonatomic) IBOutlet UILabel *oddslab;
@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (weak, nonatomic) IBOutlet UILabel *addpricelab;
@property (weak, nonatomic) IBOutlet UILabel *safelab;
@property (weak, nonatomic) IBOutlet UILabel *secretlab;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *countlab;
@property (weak, nonatomic) IBOutlet UILabel *lotterycountlab;
@property (weak, nonatomic) IBOutlet UILabel *totalpricelab;
@property (weak, nonatomic) IBOutlet UILabel *remarklab;
@property (weak, nonatomic) IBOutlet UILabel *commentlab;



@end

@implementation ForrowOrderViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"跟单";
    
    [self.headimgv sd_setImageWithURL:IMAGEPATH(self.model.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.namelab.text = self.model.nickname;
    self.lotterynamelab.text = [NSString stringWithFormat:@"%@第%@期",self.model.lotteryName,self.model.issue];
    self.playnamelab.text = self.model.playName;
    self.oddslab.text = self.model.odds;
    self.pricelab.text = [NSString stringWithFormat:@"%.2f",self.model.betAmount.floatValue];
    self.addpricelab.text = [NSString stringWithFormat:@"%.2f%@",self.model.bonusScale,@"%"];
    self.safelab.text = [NSString stringWithFormat:@"%.2f",self.model.ensureOdds];
    self.secretlab.text = self.model.secretStatus == 1 ? @"跟单后公开" : @"开奖后公开";
    self.totalpricelab.text = [NSString stringWithFormat:@"%.2f",self.model.betAmount.floatValue];
    self.commentlab.text = self.model.godAnalyze;
}

- (IBAction)delClick:(UIButton *)sender {
    
    NSInteger count = self.countlab.text.integerValue;
    
    count -- ;
    
    if (count <= 1) {
        
        count = 1;
    }
    
    CGFloat price = self.model.betAmount.floatValue * count;
    
    self.totalpricelab.text = [NSString stringWithFormat:@"%.2f",price];
    
    self.countlab.text = INTTOSTRING(count);
}
- (IBAction)addClick:(UIButton *)sender {
    
    NSInteger count = self.countlab.text.integerValue;
    
    count ++ ;
    
    CGFloat price = self.model.betAmount.floatValue * count;
    
    self.totalpricelab.text = [NSString stringWithFormat:@"%.2f",price];
    
    self.countlab.text = INTTOSTRING(count);
}

- (IBAction)publishClick:(UIButton *)sender {
    
    @weakify(self)
    [WebTools postWithURL:@"/order/orderFollow.json" params:@{@"godPushId":@(self.model.pushOrderId),@"userId":[Person person].uid,@"orderAmount":self.totalpricelab.text} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
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
