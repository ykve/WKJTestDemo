//
//  DaShenViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/7/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "DaShenViewController.h"
#import "DaShenListViewController.h"
#import "ForrowListCtrl.h"
@interface DaShenViewController ()

@end

@implementation DaShenViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"跟单大厅";
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        *norColor = [[CPTThemeConfig shareManager] genDanHallTitleNormalColr];
        *selColor = [[CPTThemeConfig shareManager] genDanHallTitleSelectColr];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"forrowlist") style:UIBarButtonItemStylePlain target:self action:@selector(forrowlistClick)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


// 添加所有子控制器
- (void)setUpAllViewController
{
    NSArray *ids = @[[[CPTBuyDataManager shareManager] allLotteryIds],@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_PaiLie35),@(CPTBuyTicketType_HaiNanQiXingCai),@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_3D),@(CPTBuyTicketType_QiLecai)];
    
    for (int i = 0; i < ids.count; i++) {
        
//        DaShenListViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"DaShenListViewController"];
         DaShenListViewController *vc = [[DaShenListViewController alloc] init];

        if (i == 0) {
            vc.title = @"全部";
            vc.allLottery_ids = [NSArray arrayWithArray:ids[0]];
            
        }else{
            CPTBuyTicketType type = [ids[i] integerValue];
            vc.title = [[CPTBuyDataManager shareManager] changeTypeToString:type];
            vc.lottery_id = type;
        }
        
        [self addChildViewController:vc];

    }
}

-(void)forrowlistClick {
    
    ForrowListCtrl *vc = [[ForrowListCtrl alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
