//
//  ActivityDetailVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/10.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ActivityDetailVC.h"
#import "ActivityCell.h"
#import "SixRecommendCtrl.h"
#import "CPTBuyRootVC.h"
#import "CPTBuySexViewController.h"
#import "FootBallPlanCtrl.h"
#import "LoginAlertViewController.h"
#import "TopUpViewController.h"
#import "DaShenViewController.h"
#import "ActivityDetailFootView.h"
#import "HomeActivityAlertView.h"
#import "CircleDetailViewController.h"
#import "AddBanksteponeCtrl.h"
#import "ForrowListCtrl.h"

@interface ActivityDetailVC ()
@property (nonatomic,assign)NSInteger type;//1红包 2 活动
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *titlel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet AdView *adView;
@property (weak, nonatomic) IBOutlet UIView *hongbaoView;

@property (weak, nonatomic) IBOutlet UIScrollView *sscrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sscrollViewH;

///
@property (nonatomic, assign) BOOL isBankCard;

@end

@implementation ActivityDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)dealloc{
    if(_adView){
        [_adView endScroll];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"活动详情";
    self.topSS.constant = NAV_HEIGHT;
    if(self.dic){
        [self configUI];
    }else{
        @weakify(self)
        [WebTools postWithURL:@"/activity/getDetail.json" params:@{@"actId":self.acttID} success:^(BaseData *data) {
            @strongify(self)
            id some = data.data;
            if([some isKindOfClass:[NSString class]]){
                return ;
            }else if ([some isKindOfClass:[NSDictionary class]]){
                self.dic = some;
                [self configUI];

            }
        } failure:^(NSError *error) {
            //        @strongify(self)
        } showHUD:YES];
    }
    
    [self getBankCarListData];
}

- (void)configUI{
    NSNumber * atID = self.dic[@"id"] ;
    
    NSNumber * actTypeNumber = self.dic[@"actType"] ;
    NSNumber * actStatusNumber = self.dic[@"actStatus"] ;
    NSInteger actType = [actTypeNumber integerValue];
    NSInteger actStatus = [actStatusNumber integerValue];
    if(actType == 1 && actStatus ==0){//1红包 2 活动
        self.type = 1;
        self.hongbaoView.hidden = NO;
        self.adView.atID = atID;
        self.adView.type =  CPTADType_hb;
        self.adView.cellHeight = 26;
        [self.adView loadTableView];
        [self.adView reloadData];
        [self checkHB];
    }else{
        self.type = 2;
        self.hongbaoView.hidden = YES;
    }
    
    __weak __typeof(self)weakSelf = self;
    [self.imgv sd_setImageWithURL:[NSURL URLWithString:self.dic[@"actInBanner"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        if (image) {
            CGFloat imageYW = CGImageGetWidth(image.CGImage);
            CGFloat imageYH = CGImageGetHeight(image.CGImage);
            if(imageURL.absoluteString.length>10){
                //            strongSelf.sscrollViewH.constant = (image.size.height/2)/(image.size.width/2/strongSelf.imgv.frame.size.width)+30;
                strongSelf.sscrollViewH.constant = imageYH/2/(imageYW/2/strongSelf.imgv.frame.size.width)+30;
            }
        }
        
    }];
    
    NSString *time = self.dic[@"actEndTime"];
    self.titlel.text = [Tools chuototimedian2:[time doubleValue]/1000];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time1=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    if(time1<[self.dic[@"actEndTime"] doubleValue]){
        if(actStatus ==0){
            if(actType == 1 ){//1红包 2 活动
                [self.moreBtn setImage:IMAGE(@"领取红包") forState:UIControlStateNormal];
                [self.moreBtn addTarget:self action:@selector(checkIsHadHongbao) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [self.moreBtn setImage:IMAGE(@"立即前往") forState:UIControlStateNormal];
                [self.moreBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
            [self.moreBtn setImage:IMAGE(@"已结束") forState:UIControlStateNormal];
        }
        
    }else{
        [self.moreBtn setImage:IMAGE(@"已结束") forState:UIControlStateNormal];
    }
}


#pragma mark -  查询用户绑定的银行号列表
-(void)getBankCarListData {
    
    @weakify(self)
    [WebTools postWithURL:@"/withdraw/finduserBankcard.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            self.isBankCard = NO;
        } else {
            self.isBankCard = YES;
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -  添加银行卡
-(void)addCardAction {
    [MBProgressHUD showError:@"你还没有银行卡, 请先添加银行卡"];
//    AddBanksteponeCtrl *steponeVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"AddBanksteponeCtrl"];
    
    AddBanksteponeCtrl *steponeVC = [[AddBanksteponeCtrl alloc] init];
    __weak __typeof(self)weakSelf = self;
    
    steponeVC.addBankBlock = ^(BOOL result) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (result) {
            strongSelf.isBankCard = YES;
        }
    };
    [self.navigationController pushViewController:steponeVC animated:YES];
 
}

-(void)checkIsHadHongbao {
   
    @weakify(self)
    NSNumber * atID = self.dic[@"id"] ;
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:^{
        }];
        [login setLoginBlock:^(BOOL result) {
            @strongify(self)
            [self checkIsHadHongbao];
        }];
        return ;
    }
    
    
    if (!self.isBankCard) {
        [self addCardAction];
        return;
    }
    [WebTools postWithURL:@"/activity/lotteryDraw.json" params:@{@"actId":atID,@"uid":[[Person person] uid] == nil ?@"":[[Person person] uid]} success:^(BaseData *data) {
        
        @strongify(self)
        id some = data.data;
        if([some isKindOfClass:[NSString class]]){
            return ;
        }else if ([some isKindOfClass:[NSNumber class]]){
            [self.moreBtn setBackgroundImage:IMAGE(@"已领取") forState:UIControlStateNormal];
            [self.moreBtn setImage:nil forState:UIControlStateNormal];
            NSNumber * money = (NSNumber *)some;
            CGFloat mon = [money floatValue];
            [self.moreBtn setTitle:[NSString stringWithFormat:@"已领取%.2f",mon] forState:UIControlStateNormal];
            [self.moreBtn removeTarget:self action:@selector(checkIsHadHongbao) forControlEvents:UIControlEventTouchUpInside];

            dispatch_async(dispatch_get_main_queue(), ^{
                HomeActivityAlertView *vc = [[[NSBundle mainBundle]loadNibNamed:@"HomeActivityAlertView" owner:self options:nil]firstObject];
                vc.actID = atID;
                vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                [vc showView:self.view some:money];
            });
            
        }
        
        
    } failure:^(NSError *error) {
        //        @strongify(self)
    } showHUD:NO];
}


- (void)clickBtn{

    //"actIntoPage"  进入页面 0心水推荐 1跟单大厅 2六合彩购彩 3足彩专家 4充值页面

    switch ([self.dic[@"actIntoPage"] integerValue]) {
        case 0:
            {
                SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
                recommend.lottery_oldID = 4;
                PUSH(recommend);
            }
        break;
        case 1:
        {
            DaShenViewController *dashen = [[DaShenViewController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            PUSH(dashen);
        }
            break;
        case 2:
        {
            CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
            vc.lotteryId = CPTBuyTicketType_LiuHeCai;
            CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
            six.type = CPTBuyTicketType_LiuHeCai;
            six.endTime = 60;
            [[CPTBuyDataManager shareManager] configType:six.type];
            six.lottery_type = CPTBuyTicketType_LiuHeCai;
            six.categoryId = 12;
            six.lotteryId = CPTBuyTicketType_LiuHeCai;
            vc.type = six.type;
            [vc loadVC:six title:@"六合彩"];
            PUSH(vc);
        }
            break;
        case 3:
        {
            FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
            PUSH(footVc);
        }
            break;
        case 4:
        {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    
                };
                return;
            }
            if ([Person person].payLevelId.length == 0) {
                [MBProgressHUD showError:@"无用户层级, 暂无法充值"];
                return;
            }
            TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            
            [self.navigationController pushViewController:topUpVC animated:YES];

        }
            break;
        case 5:{
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
                    [self.navigationController pushViewController:detail animated:YES];
                };
                
                return;
            }
            
            CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;

        default:
            break;
    }
    
}

-(void)refresh {
//    self.page = 1;
//    [self initData];
}

-(void)initData {
    NSNumber *acid = self.dic[@"id"];
    @weakify(self)
    [WebTools postWithURL:@"/activity/redEnvelopReceiveInfo.json" params:@{@"actId":acid} success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return;
        }
        NSArray * ar = data.data;
        if([ar isKindOfClass:[NSString class]]){
            return;
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:ar];
        [self.tableView reloadData];
        [self endRefresh:self.tableView WithdataArr:nil];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self endRefresh:self.tableView WithdataArr:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)checkHB {
    NSNumber * atID = self.dic[@"id"] ;
    
    
    
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:^{
        }];
        return ;
    }

    @weakify(self)
    [WebTools postWithURL:@"/activity/getMebReceiveAmount.json" params:@{@"actId":atID,@"uid":[[Person person] uid] == nil ?@"":[[Person person] uid]} success:^(BaseData *data) {
        
        @strongify(self)
        id some = data.data;
        if([some isKindOfClass:[NSString class]]){
            return ;
        }else if ([some isKindOfClass:[NSNumber class]]){
            NSInteger state = [some integerValue];
            if(state<0){
                [self.moreBtn setImage:IMAGE(@"领取红包") forState:UIControlStateNormal];
                [self.moreBtn addTarget:self action:@selector(checkIsHadHongbao) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [self.moreBtn setBackgroundImage:IMAGE(@"已领取") forState:UIControlStateNormal];
                [self.moreBtn setImage:nil forState:UIControlStateNormal];
                NSNumber * money = (NSNumber *)some;
                CGFloat mon = [money floatValue];
                [self.moreBtn setTitle:[NSString stringWithFormat:@"已领取%.2f",mon] forState:UIControlStateNormal];
                [self.moreBtn removeTarget:self action:@selector(checkIsHadHongbao) forControlEvents:UIControlEventTouchUpInside];
            }
            NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
            NSTimeInterval time1=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
            if(time1<[self.dic[@"actEndTime"] doubleValue]){

                
            }else{
                [self.moreBtn setImage:IMAGE(@"已结束") forState:UIControlStateNormal];
            }
        }
    } failure:^(NSError *error) {
        //        @strongify(self)
    } showHUD:NO];
}

@end
