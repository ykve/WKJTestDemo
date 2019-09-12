//
//  PersonStatementsViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/21.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PersonStatementsViewController.h"

@interface PersonStatementsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *outpricelab;

@property (weak, nonatomic) IBOutlet UILabel *addpricelab;

@property (weak, nonatomic) IBOutlet UILabel *backpricelab;

@property (weak, nonatomic) IBOutlet UILabel *activitypricelab;

@property (weak, nonatomic) IBOutlet UILabel *tuilab;

@property (weak, nonatomic) IBOutlet UILabel *genlab;

@property (weak, nonatomic) IBOutlet UILabel *viplab;

@property (weak, nonatomic) IBOutlet UILabel *fenlab;

@property (weak, nonatomic) IBOutlet UILabel *xianglab;

@property (weak, nonatomic) IBOutlet UILabel *pricelab;

@end

@implementation PersonStatementsViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"开奖日历") style:UIBarButtonItemStylePlain target:self action:@selector(dateClick)];
    
    NSString *time = [Tools getlocaletime];
    
    [self initDataWithstart:time Withend:time];
}

-(void)initDataWithstart:(NSString *)startDate Withend:(NSString *)endDate {
    @weakify(self)
    [WebTools postWithURL:@"/memberFund/reportForms.json" params:@{@"startDate":startDate,@"endDate":endDate} success:^(BaseData *data) {
        @strongify(self)
        self.outpricelab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"betAmount"]floatValue]];
        self.addpricelab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"winAmount"]floatValue]];
        self.backpricelab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"backAmount"]floatValue]];
        self.activitypricelab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"activityAmount"]floatValue]];
        self.tuilab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"orderPushBonus"]floatValue]];
        self.genlab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"orderFollowBonus"]floatValue]];
        self.viplab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"vipUpgradeAwards"]floatValue]];
        self.fenlab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"shareAward"]floatValue]];
        self.xianglab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"shareBack"]floatValue]];
        self.pricelab.text = [NSString stringWithFormat:@"%.2f",[data.data[@"profitAmount"]floatValue]];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)dateClick {
    @weakify(self)
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    [alert builddateView:^(NSString *date) {
        @strongify(self)
        [self initDataWithstart:date Withend:date];
    }];
    [alert show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
