//
//  CPTBuyRootVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyRootVC.h"
#import "CPTBuySexViewController.h"
#import "ChatRoomCtrl.h"
#import "LoginAlertViewController.h"
#import "CPTBuyFantanCtrl.h"
#import "BettingRecordViewController.h"
#import "ZAlertViewManager.h"
#import "FormulaCtrl.h"
#import "SixRecommendCtrl.h"
#import "LiuHeDaShenViewController.h"
#import "SixAIPickCtrl.h"
#import "PCFreeRecommendCtrl.h"
#import "PK10VersionTrendCtrl.h"
#import "PCTodayStatisticsCtrl.h"
#import "GraphCtrl.h"
#import "IQKeyboardManager.h"
#import "NavigationVCViewController.h"
#import "KeFuViewController.h"
#import "LeftViewController.h"
#import "HongBaoRootVC.h"
#import "PublicInterfaceTool.h"
#import "CPTChatManager.h"

@interface CPTBuyRootVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UISegmentedControl *titleV;
@property (nonatomic, strong) RootCtrl *rVC;
@property (nonatomic, strong) LeftViewController *leftViewC; // 强引用，可以避免每次显示抽屉都去创建
@property (nonatomic, strong) UIButton *leftSegBtn;
@property (nonatomic, copy) NSString *leftTitle;

///
@property (nonatomic, strong) ChatRoomCtrl *chatRoomVC;


@end

@implementation CPTBuyRootVC

-(void)popback{
    for(UIViewController * vc in self.childViewControllers){
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
        if([vc isKindOfClass:[RootCtrl class]]){
            RootCtrl * rvc = (RootCtrl *)vc;
            if([rvc respondsToSelector:@selector(popback)]){
                [rvc popback];
            }
        }
    }

    [[CPTChatManager shareManager] cannelBlock];
    [self removeBlock];
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setshake];
}
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        BOOL isOn = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_shake"]boolValue];
        if(isOn){
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
            [self.rVC shakeM];
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if( [AppDelegate shareapp].chatSentHongbaoView){
//        [UIView animateWithDuration:0.3 animations:^{
//            [AppDelegate shareapp].chatSentHongbaoView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+keyBoardRect.size.height);
//        }];
//    }else{
        self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, IS_IPHONEX ? keyBoardRect.size.height+13 : keyBoardRect.size.height, 0);
        self.myScrollView.scrollEnabled = NO;
//    }

}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.myScrollView.scrollEnabled = YES;
    self.myScrollView.contentInset = UIEdgeInsetsZero;
}
- (LeftViewController *)leftViewC{
    if(!_leftViewC){
       _leftViewC  = [[LeftViewController alloc] init];
    }
    return _leftViewC;
}

- (void)showLeftView{
    [self.leftViewC show:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPTOpenLotteryManager shareManager] openSocket];

//    self.view.backgroundColor = [UIColor redColor];
    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
    [nav removepang];
    self.myScrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateChatNumber:) name:@"CHATROOMCountP" object:nil];
}

- (void)updateChatNumber:(NSNotification *)not{
    if(_titleV){
        NSString * leng = not.object;
        [_titleV setTitle:leng forSegmentAtIndex:1];
        CGFloat tmpW = [Tools createLableWidthWithString:leng andfontsize:15 andwithhigh:10];

        [_titleV setWidth:tmpW>=90. ? tmpW : 90. forSegmentAtIndex:1];
    }
}
- (void)loadVC:(RootCtrl *)vc title:(NSString *)title{
    if(!_myScrollView){
        _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT+SAFE_HEIGHT)];
        self.myScrollView.delegate = self;
        self.myScrollView.pagingEnabled = YES;
        self.myScrollView.bounces = NO;
        self.myScrollView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:self.myScrollView];
    }
    NSString *t = [NSString stringWithFormat:@"     %@",title];
    self.leftTitle =  t;

    CGFloat tmpW = [Tools createLableWidthWithString:t andfontsize:15 andwithhigh:10];
    if([title isEqualToString:@"德州时时彩番摊"]){
        t = [NSString stringWithFormat:@"   %@",title];
        tmpW = tmpW -20;
    }
    tmpW = tmpW>=90. ? tmpW : 90.;
    NSArray * playArray = @[t,@"聊天室"];
    if(!_titleV){
        _titleV = [[UISegmentedControl alloc]initWithItems:playArray];
        _titleV.frame = CGRectMake((SCREEN_WIDTH-tmpW*2)/2, (IS_IPHONEX ? 44:20)+(44-25)/2, tmpW*2, 25);
        _titleV.layer.cornerRadius = 25/2;
        _titleV.layer.masksToBounds = YES;
        _titleV.layer.borderWidth = 1.;
        NSString * leftSegBtnImageN = @"seg_sel";
        
        if([[AppDelegate shareapp] wkjScheme]== Scheme_LotterEight){
            _titleV.backgroundColor = [UIColor colorWithHex:@"#C21632"];
            _titleV.tintColor = WHITE;
            _titleV.layer.borderColor = WHITE.CGColor;
            leftSegBtnImageN = @"tw_seg_sel";
        }else{
            if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
                _titleV.backgroundColor = [UIColor colorWithHex:@"5DADFF"];
                _titleV.tintColor = WHITE;
                _titleV.layer.borderColor = WHITE.CGColor;
                leftSegBtnImageN = @"tw_seg_sel";
            }else {
                _titleV.backgroundColor = BLACK;
                _titleV.tintColor =  [UIColor colorWithHex:@"EACD91"];
                _titleV.layer.borderColor = [UIColor colorWithHex:@"EACD91"].CGColor;
            }
        }

        [self.view addSubview:_titleV];
        [_titleV addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        [_titleV setWidth:71 forSegmentAtIndex:1];
        if(!_leftSegBtn){
            _leftSegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.view addSubview:_leftSegBtn];
            [_leftSegBtn setBackgroundColor:CLEAR];// forState:(UIControlState)];
            [_leftSegBtn setFrame:CGRectMake((SCREEN_WIDTH-tmpW*2)/2,(IS_IPHONEX ? 44:20)+(44-25)/2, tmpW, 25)];
            [_leftSegBtn addTarget:self action:@selector(segmentTouchUp) forControlEvents:UIControlEventTouchUpInside];
            [_leftSegBtn setImage:IMAGE(leftSegBtnImageN) forState:UIControlStateNormal];
            [_leftSegBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, tmpW-40)];
        }
    }
    _titleV.selectedSegmentIndex = 0;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.myScrollView.bounds.size.height);
    [self.myScrollView addSubview:vc.view];
    [vc didMoveToParentViewController:self];

    
    ChatRoomCtrl *chatVC = [[ChatRoomCtrl alloc] init];
    
    chatVC.lotteryId = self.lotteryId;
    chatVC.roomName = title;
    [self addChildViewController:chatVC];
    chatVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.myScrollView.bounds.size.height);
    [self.myScrollView addSubview:chatVC.view];
    [chatVC didMoveToParentViewController:self];
    _chatRoomVC = chatVC;
    _chatRoomVC.selectedSegmentIndex = 1000;

    self.rVC = vc;
    [self showZhushou];
}

- (void)showZhushou{
    @weakify(self)
    [self rigBtn:@"助手" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:login animated:YES completion:nil];
            login.loginBlock = ^(BOOL result) {
                
            };
            return;
        }
        [self.showView showView];
    }];
}

- (void)showHongBaoJilu{
    @weakify(self)
    [self rigBtn:@"红包记录" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:login animated:YES completion:nil];
            login.loginBlock = ^(BOOL result) {
                
            };
            return;
        }
        HongBaoRootVC * vc = [[HongBaoRootVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    self.titleV.selectedSegmentIndex = index;
    if(index == 0){
        [IQKeyboardManager sharedManager].enable = YES;
        NSString * leftSegBtnImageN = @"seg_sel";
         if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
             leftSegBtnImageN = @"tw_seg_sel";
         }
        [_leftSegBtn setImage:IMAGE(leftSegBtnImageN) forState:UIControlStateNormal];
        [self showZhushou];
    }else{
        [IQKeyboardManager sharedManager].enable = NO;
        NSString * leftSegBtnImageN = @"seg_unSel";
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            leftSegBtnImageN = @"tw_seg_unSel";
        }
        [_leftSegBtn setImage:IMAGE(leftSegBtnImageN) forState:UIControlStateNormal];
        [self showHongBaoJilu];
    }
//    if(scrollView.contentOffset.x % SCREEN_WIDTH == 0. ){
//        [self.view endEditing:YES];
//    }
}


- (void)segmentTouchUp{
    if(_titleV.selectedSegmentIndex == 0){
        [self showLeftView];

    }else{
  
        _titleV.selectedSegmentIndex = 0;
        [self segmentClick:_titleV];
    }
}

- (void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:kGoInChatRoomMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)segmentClick:(UISegmentedControl *)seg{
    
     if(seg.selectedSegmentIndex == 1){
         __weak __typeof(self)weakSelf = self;
         [PublicInterfaceTool getWechatInfoSuccess:^(BaseData * _Nonnull data) {
             __strong __typeof(weakSelf)strongSelf = weakSelf;
             if ([data.data[@"chatRoom"] integerValue] == 1) {
                 [MBProgressHUD showError:kGoInChatRoomMessage];
                 seg.selectedSegmentIndex = 0;
                 strongSelf.chatRoomVC.selectedSegmentIndex = 1000;
             } else {
                 [strongSelf gotoChatRoom:seg];
                 strongSelf.chatRoomVC.selectedSegmentIndex = 1001;
             }
             
         } failure:^(NSError * _Nonnull error) {
             __strong __typeof(weakSelf)strongSelf = weakSelf;
             [MBProgressHUD showError:kGoInChatRoomMessage];
             seg.selectedSegmentIndex = 0;
             strongSelf.chatRoomVC.selectedSegmentIndex = 1000;
         }];
     } else {
          self.chatRoomVC.selectedSegmentIndex = 1000;
          [self gotoChatRoom:seg];
     }
 
    
}

- (void)gotoChatRoom:(UISegmentedControl *)seg {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.myScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*seg.selectedSegmentIndex, 0);
    }];
    if(seg.selectedSegmentIndex == 0){
        [IQKeyboardManager sharedManager].enable = YES;
        NSString * leftSegBtnImageN = @"seg_sel";
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            leftSegBtnImageN = @"tw_seg_sel";
        }
        [_leftSegBtn setImage:IMAGE(leftSegBtnImageN) forState:UIControlStateNormal];
        [self showZhushou];
    }else{
        [IQKeyboardManager sharedManager].enable = NO;
        NSString * leftSegBtnImageN = @"seg_unSel";
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            leftSegBtnImageN = @"tw_seg_unSel";
        }
        [self showHongBaoJilu];
    }
    [self.view endEditing:YES];
}

- (void)showChatVC{
    [self showChat];
}



- (void)showChat{
    self.titleV.selectedSegmentIndex = 1;
//    [UIView animateWithDuration:0.4 animations:^{
        self.myScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*1, 0);
//    }];
    [self.view endEditing:YES];
}

- (SQMenuShowView *)showView{
    
    if (_showView) {
        return _showView;
    }
    NSString *title = @"心水推荐";
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        title = @"小鱼论坛";
    }
    //@[@"遗漏",@"投注记录",@"在线客服",@"水心推荐",@"正码历史",@"特码历史"]
    NSArray * itmes = @[@"投注记录",@"在线客服"];
    if(self.type == CPTBuyTicketType_SSC||self.type == CPTBuyTicketType_XJSSC||self.type == CPTBuyTicketType_TJSSC||self.type == CPTBuyTicketType_FFC){
        itmes = @[@"投注记录",@"在线客服",@"今日统计",@"免费推荐",@"公式杀号",@"曲线图"];
    }else if (self.type == CPTBuyTicketType_PK10){
        itmes = @[@"投注记录",@"在线客服",@"免费推荐",@"公式杀号",@"横版走势"];
    }else if (self.type == CPTBuyTicketType_LiuHeCai){
        itmes = @[@"投注记录",@"在线客服",@"公式杀号",title,@"六合大神",@"AI智能选号"];
    }else if (self.type == CPTBuyTicketType_PCDD){
        itmes = @[@"投注记录",@"在线客服",@"今日统计",@"免费推荐"];
    }
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-10,NAV_HEIGHT+5,100,0}
                                               items:itmes
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = MAINCOLOR;
    _showView.itemTextColor = WHITE;
    @weakify(self)
    [_showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        @strongify(self)
        if (index == 0) {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:login animated:YES completion:nil];
                @weakify(self)
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
                    BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
                    [self.navigationController pushViewController:bettingRecordVC animated:YES];
                };
                return ;
            }
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
            [self.navigationController pushViewController:bettingRecordVC animated:YES];
        }
        else if (index == 1) {
            if ([Person person].uid == nil) {
                LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                @weakify(self)
                [self presentViewController:login animated:YES completion:nil];
                login.loginBlock = ^(BOOL result) {
                    @strongify(self)
                    // 在线客服
//                    if ([[ChatHelp shareHelper]login]){
//                        HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//                        [self.navigationController pushViewController:chatVC animated:YES];
//                    }
                    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
                    
                    PUSH(kefuVc);
                };
                return ;
            }
            // 在线客服
//            if ([[ChatHelp shareHelper]login]){
//                HDChatViewController *chatVC = [[HDChatViewController alloc] initWithConversationChatter:HX_IM]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
//                [self.navigationController pushViewController:chatVC animated:YES];
//            }
            KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
            
            PUSH(kefuVc);
        }
        switch (self.type) {
            case CPTBuyTicketType_LiuHeCai:{//@"公式杀号",@"心水推荐",@"六合大神",@"AI智能选号"
                if (index == 2) {
                    FormulaCtrl *formula = [[FormulaCtrl alloc]init];
                    formula.lottery_type = 4;
                    PUSH(formula);
                }
                else if (index == 3) {
                    SixRecommendCtrl *recommend = [[SixRecommendCtrl alloc]init];
                    PUSH(recommend);
                }
                else if (index == 4) {
                    LiuHeDaShenViewController *dashenVc = [[LiuHeDaShenViewController alloc]init];
                    PUSH(dashenVc);
                }
                else if (index == 5) {
                    SixAIPickCtrl *ai = [[SixAIPickCtrl alloc]initWithNibName:NSStringFromClass([SixAIPickCtrl class]) bundle:[NSBundle mainBundle]];
                    
                    PUSH(ai);
                }
                
            }
                break;
            case CPTBuyTicketType_PK10:{//@"免费推荐",@"公式杀号",@"横版走势"
                if (index == 2) {
                    PCFreeRecommendCtrl *recommend = [[PCFreeRecommendCtrl alloc]init];
                    PUSH(recommend);
                }
                else if (index == 3) {
                    FormulaCtrl *formula = [[FormulaCtrl alloc]init];
                    formula.lottery_type = 4;
                    PUSH(formula);
                }
                else if (index == 4) {
                    
                    PK10VersionTrendCtrl *trend = [[PK10VersionTrendCtrl alloc]init];
                    trend.lottery_type = 6;
                    PUSH(trend);
                }
            } break;
            case CPTBuyTicketType_PCDD:{//@"今日统计",@"免费推荐"
                if (index == 2) {
                    PCTodayStatisticsCtrl *statistic = [[PCTodayStatisticsCtrl alloc]init];
                    PUSH(statistic);
                }
                else if (index == 3) {
                    PCFreeRecommendCtrl *recommend = [[PCFreeRecommendCtrl alloc]init];
                    PUSH(recommend);
                }
            } break;
            case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_FFC:{//@"今日统计",@"免费推荐",@"公式杀号",@"曲线图"
                if (index == 2) {
                    PCTodayStatisticsCtrl *statistic = [[PCTodayStatisticsCtrl alloc]init];
                    PUSH(statistic);
                }
                else if (index == 3) {
                    PCFreeRecommendCtrl *recommend = [[PCFreeRecommendCtrl alloc]init];
                    PUSH(recommend);
                }
                else if (index == 4) {
                    FormulaCtrl *formula = [[FormulaCtrl alloc]init];
                    formula.lottery_type = 4;
                    PUSH(formula);
                }
                else if (index == 5) {
                    GraphCtrl *graph = [[GraphCtrl alloc]init];
                    graph.lottery_type = 1;//self.lottery_type;
                    PUSH(graph);
                }
            } break;
            default:
                break;
        }
        
    }];
    [_showView setShowmissBlock:^(BOOL showmiss) {
        @strongify(self)
        [self.tableView reloadData];
    }];
    [self.view addSubview:_showView];
    return _showView;
}
@end
