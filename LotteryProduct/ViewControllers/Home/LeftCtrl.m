//
//  LeftCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LeftCtrl.h"
#import "LeftHeadView.h"
#import "TopUpViewController.h"
#import "GetOutViewController.h"
#import "BettingRecordViewController.h"
#import "NavigationVCViewController.h"
#import "KeFuViewController.h"
#import "WalletViewController.h"

@interface LeftCtrl ()

@property (nonatomic, strong)LeftHeadView *headview;

@property (strong, nonatomic) UIControl *overlayView;

@end

@implementation LeftCtrl

static LeftCtrl *left=nil;

+(instancetype)share{
    
    left=[[LeftCtrl alloc]init];
    
    return left;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadview];
    }
    return self;
}

- (void)loadview {
    
    self.backgroundColor = [[CPTThemeConfig shareManager] Left_VC_CellBackgroundColor];
    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithHex:@"18191D"];
    _overlayView.alpha = 0.4;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH *0.73, SCREEN_HEIGHT + SAFE_HEIGHT) style:UITableViewStylePlain];
   
    self.tableView.backgroundColor = [[CPTThemeConfig shareManager] Left_VC_CellBackgroundColor];
    self.tableView.separatorColor = [UIColor hexStringToColor:@"#CDCDCD"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RJCellIdentifier];
    
    self.tableView.rowHeight = 53;
    self.headview = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LeftHeadView class]) owner:self options:nil]firstObject];
    CGFloat headheight = 270;
    self.headview.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.73, headheight);
    self.headview.backgroundColor = WHITE;
    self.tableView.tableHeaderView = self.headview;

    self.headview.vipImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"me_%@", [Person person].vip]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHead)];
    [self.headview.headimgv addGestureRecognizer:tap];
    [self addSubview:self.tableView];
    

    self.dataSource = @[
  @{@"title":@"我的钱包",@"icon":[[CPTThemeConfig shareManager] Left_VC_MyWalletImage]},
  @{@"title":@"安全中心",@"icon":[[CPTThemeConfig shareManager] Left_VC_SecurityCenterImage]},
  @{@"title":@"消息中心",@"icon":[[CPTThemeConfig shareManager] Left_VC_MessageCenterImage]},
  @{@"title":@"投注记录",@"icon":[[CPTThemeConfig shareManager] Left_VC_BuyHistoryImage]},
  @{@"title":@"我的报表",@"icon":[[CPTThemeConfig shareManager] Left_VC_MyTableImage]},
  @{@"title":@"设置中心",@"icon":[[CPTThemeConfig shareManager] Left_VC_SettingCenterImage]}];
    
    

    self.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH *0.73, SCREEN_HEIGHT + SAFE_HEIGHT);

    @weakify(self)
    self.headview.leftheadBlock = ^(NSInteger type) {
        @strongify(self)
        if ([Person person].uid == nil || [Person person].token == nil) {
            
            [self.vc showlogin:^(BOOL success) {
                @strongify(self)

                [self.headview.headimgv sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
                
                self.headview.pricelab.text = [NSString stringWithFormat:@"￥ %.2f",[Person person].balance];
                
                self.headview.nicknamelab.text = [Person person].nickname;

                self.headview.vipImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"me_%@", [Person person].vip]];
            }];
        }
        else {
            
            if (type == 0) { //充值
                if ([Person person].payLevelId.length == 0) {
                    [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
                    return;
                }
                TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
                self.vc.navigationController.navigationBar.hidden = NO;

                [self.vc.navigationController pushViewController:topUpVC animated:YES];
            }
            else if (type == 1) { //提现
                
                GetOutViewController *getoutVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"GetOutViewController"];
                self.vc.navigationController.navigationBar.hidden = NO;

                [self.vc.navigationController pushViewController:getoutVC animated:YES];
            }
            else { //客服
                
                KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
                [self.vc.navigationController pushViewController:kefuVc animated:YES];
                
//                if ([[ChatHelp shareHelper]login]){
//
//                    // 进入会话页面
//                    HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//                    [self.vc.navigationController pushViewController:chatVC animated:YES];
//                }
                
            }
            
        }
        
        [self dismiss];
    };
}
- (void)tapHead{
    [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"UserInfoViewController"] animated:YES];
    self.vc.navigationController.navigationBar.hidden = NO;
    [self dismiss];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.imageView.image = IMAGE(dic[@"icon"]);
    
    cell.backgroundColor = [[CPTThemeConfig shareManager] Left_VC_CellBackgroundColor];
    cell.textLabel.textColor = [[CPTThemeConfig shareManager] LeftCtrlCellTextColor];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([Person person].uid == nil || [Person person].token == nil) {
        
        [self.vc showlogin:^(BOOL success) {
            
        }];
    }
    
//    if ([Person person].Information) {
//
//        switch (indexPath.row) {
//            case 0:
//            {
//                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SafeViewController"] animated:YES];
//            }
//                break;
//            case 1:
//            {
//                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageCenterViewController"] animated:YES];
//            }
//                break;
//            case 2:
//            {
//                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateInitialViewController] animated:YES];
//            }
//                break;
//            default:
//                break;
//        }
//    }
//    else {
        switch (indexPath.row) {
            case 0:
            {
                WalletViewController *vc = [[WalletViewController alloc] init];
                [self.vc.navigationController pushViewController:vc animated:YES];
                
//                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"WalletViewController"] animated:YES];
            }
                break;
            case 1:
            {
                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SafeViewController"] animated:YES];
            }
                break;
            case 2:
            {
                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageCenterViewController"] animated:YES];
            }
                break;
            case 3:
            {
                UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
                
                BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
                
                [self.vc.navigationController pushViewController:bettingRecordVC animated:YES];
                
            }
                break;
            case 4:
            {
                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PersonStatementsViewController"] animated:YES];
            }
                break;
            case 5:
            {
                [self.vc.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateInitialViewController] animated:YES];
            }
                break;
            default:
                break;
        }
        
//    }
    
    self.vc.navigationController.navigationBar.hidden = NO;
    [self dismiss];
}

-(void)show:(RootCtrl *)viewcontroller {
    
    self.vc = viewcontroller;
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.vc.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGRect frame = self.frame;
    
    frame.origin.x = 0;
    @weakify(self)
    
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self)

        self.frame = frame;
    
    } completion:^(BOOL finished) {
        @strongify(self)
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        if ([Person person].uid == nil || [Person person].token == nil) {
            
            self.headview.headimgv.image = DEFAULTHEAD;
            self.headview.nicknamelab.text = @"未登录";
            self.headview.pricelab.text = @"￥0";
        }
        else {
            [self.headview.headimgv sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
            [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            self.headview.pricelab.text = [NSString stringWithFormat:@"￥ %.2f",[Person person].balance];
            self.headview.nicknamelab.text = [Person person].nickname;
            MBLog(@"%@-%@", [Person person].nickname,self.headview.nicknamelab.text);

        }
    }];
}

-(void)dismiss{
    
    CGRect frame = self.frame;
    
    frame.origin.x = -SCREEN_WIDTH;
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)

        self.frame = frame;
        
    } completion:^(BOOL finished) {
        @strongify(self)

        [_overlayView removeTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_overlayView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
