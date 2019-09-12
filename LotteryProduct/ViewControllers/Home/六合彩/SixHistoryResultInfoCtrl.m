//
//  SixHistoryResultInfoCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixHistoryResultInfoCtrl.h"

@interface SixHistoryResultInfoCtrl ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlab1s;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlab2s;
/**
 正四：
 */
@property (weak, nonatomic) IBOutlet UILabel *fourlab;
/**
 正五：
 */
@property (weak, nonatomic) IBOutlet UILabel *fivelab;
/**
 特码：
 */
@property (weak, nonatomic) IBOutlet UILabel *temalab;
/**
 总和：
 */
@property (weak, nonatomic) IBOutlet UILabel *totallab;
/**
 推荐正四：
 */
@property (weak, nonatomic) IBOutlet UILabel *remandfourlab;
/**
 推荐正五：
 */
@property (weak, nonatomic) IBOutlet UILabel *remandfivelab;
/**
 推荐正四中：
 */
@property (weak, nonatomic) IBOutlet UILabel *remandfourstatuslab;
/**
 推荐正五中：
 */
@property (weak, nonatomic) IBOutlet UILabel *remandfivestatuslab;

/**
 推荐特码：
 */
@property (weak, nonatomic) IBOutlet UILabel *remandtemalab;
/**
 ***年**月**日****期
 */
@property (weak, nonatomic) IBOutlet UILabel *versionlab;

/**
 ***年**月**日****期推荐
 */
@property (weak, nonatomic) IBOutlet UILabel *remandversionlab;

@end

@implementation SixHistoryResultInfoCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
