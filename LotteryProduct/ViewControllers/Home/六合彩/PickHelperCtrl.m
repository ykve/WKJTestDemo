//
//  PickHelperCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PickHelperCtrl.h"

@interface PickHelperCtrl ()

@property (weak, nonatomic) IBOutlet UIView *numbersView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;


@end

@implementation PickHelperCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topconst.constant = NAV_HEIGHT;
    
    self.titlestring = @"挑码助手";
    
    [self rigBtn:@"" Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildpickhelperInfoView];
        [alert show];
    }];
    
    //投注按钮
    [self buildBettingBtn];
}

- (IBAction)clearClick:(UIButton *)sender {
}

- (IBAction)copyClick:(UIButton *)sender {
}

- (IBAction)shareClick:(UIButton *)sender {
}

#pragma mark tag100-101 单、双
- (IBAction)type1Click:(UIButton *)sender {
}
#pragma mark tag200-201 大、小
- (IBAction)type2Click:(UIButton *)sender {
}
#pragma mark tag300-303 大单、大双、小单、小双
- (IBAction)type3Click:(UIButton *)sender {
}
#pragma mark tag400-404 金、木、水、火、土
- (IBAction)type4Click:(UIButton *)sender {
}
#pragma mark tag500-502 红波、蓝波、绿波
- (IBAction)type5Click:(UIButton *)sender {
}
#pragma mark tag600-601 家禽、野兽
- (IBAction)type6Click:(UIButton *)sender {
}
#pragma mark tag700-705 红单、红双、蓝单、蓝双、绿单、绿双
- (IBAction)type7Click:(UIButton *)sender {
}
#pragma mark tag800-811 鼠 ~ 猪
- (IBAction)type8Click:(UIButton *)sender {
}
#pragma mark tag900-911 0尾 ~ 小尾
- (IBAction)type9Click:(UIButton *)sender {
}
#pragma mark tag1000-1004 0头 ~ 4头
- (IBAction)type10Click:(UIButton *)sender {
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
