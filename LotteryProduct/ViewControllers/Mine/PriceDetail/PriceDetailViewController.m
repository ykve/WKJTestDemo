//
//  PriceDetailViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PriceDetailViewController.h"
#import "PersonStatementsViewController.h"
#import "ZhangBianRecordViewController.h"
#import "TopUpRecordViewController.h"
#import "WithdrawRecordViewController.h"
#import "ActivityRecordViewController.h"
#import "BackPointRecordViewController.h"

@interface PriceDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QBZBImgView;
@property (weak, nonatomic) IBOutlet UIImageView *CZJLImgView;
@property (weak, nonatomic) IBOutlet UIImageView *TKJLImgView;
@property (weak, nonatomic) IBOutlet UIImageView *HDJLImgView;
@property (weak, nonatomic) IBOutlet UIImageView *CDFEJLImgView;

@end

@implementation PriceDetailViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
//        case 0: // 个人报表
//        {
//            PersonStatementsViewController *person = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonStatementsViewController"];
//
//            [self.navigationController pushViewController:person animated:YES];
//        }
//            break;
        case 0: // 钱包账变
        {
            ZhangBianRecordViewController *zhangbian = [self.storyboard instantiateViewControllerWithIdentifier:@"ZhangBianRecordViewController"];
            
            [self.navigationController pushViewController:zhangbian animated:YES];
        }
            break;
        case 1: // 充值记录
        {
            TopUpRecordViewController *topup = [self.storyboard instantiateViewControllerWithIdentifier:@"TopUpRecordViewController"];
            
            [self.navigationController pushViewController:topup animated:YES];
        }
            break;
        case 2: // 提款记录
        {
            WithdrawRecordViewController *withdraw = [self.storyboard instantiateViewControllerWithIdentifier:@"WithdrawRecordViewController"];
            
            [self.navigationController pushViewController:withdraw animated:YES];
        }
            break;
//        case 3: // 活动记录
//        {
//            ActivityRecordViewController *activity = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityRecordViewController"];
//            [self.navigationController pushViewController:activity animated:YES];
//        }
//            break;
        case 3: // 差额返点记录
        {
            BackPointRecordViewController *backPoint = [self.storyboard instantiateViewControllerWithIdentifier:@"BackPointRecordViewController"];
            
            [self.navigationController pushViewController:backPoint animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

@end
