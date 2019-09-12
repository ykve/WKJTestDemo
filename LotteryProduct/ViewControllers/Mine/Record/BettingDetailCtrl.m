//
//  BettingDetailCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BettingDetailCtrl.h"
#import "BettingDetailCell.h"
#import "IGKbetModel.h"
#import "PushBettingCtrl.h"
#import "BallTool.h"


@interface BettingDetailCtrl ()

@property (strong, nonatomic) UIImageView *iconimgv;

@property (strong, nonatomic) UILabel *lotterynamelab;

@property (strong, nonatomic) UILabel *typelab;

@property (strong, nonatomic) UILabel *issuelab;

@property (strong, nonatomic) UILabel *publishnumberlab;

@property (strong, nonatomic) NSMutableArray *resultBtns;

@property (strong, nonatomic) UIButton *nextBtn;

@property (strong, nonatomic) UIView *headerView;

@property (strong, nonatomic) UITableView *tableVC;

@property (strong, nonatomic) UILabel *opennumbertitlelab;

@property (copy, nonatomic) NSString *issue;
@property (strong, nonatomic) UILabel *tit2Label;


@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;
@property (weak, nonatomic) IBOutlet UIView *headBottomView;

@property (assign, nonatomic) BOOL isRed;

@end

@implementation BettingDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"投注详情";
    [self getNextDate];
    [self setupUI];
    
    
    [self judgingLotTypeImage];
    self.lotterynamelab.text = self.model.lotteryName;
    self.typelab.text = self.model.playName;
    self.issuelab.text = [NSString stringWithFormat:@"期号：第%@期", self.model.issue];
    
    NSString*replacedStr = [self.model.betNumber stringByReplacingOccurrencesOfString:@"_"withString:@"\n"];
    self.publishnumberlab.text = replacedStr;
    
    [self setUIValue];
    
    
    
    
 self.dataArray = @[
  @{@"title":@"投注时间",@"content":self.model.createTime},
  @{@"title":@"注单编号",@"content":self.model.orderSn ? self.model.orderSn : @""},
  @{@"title":@"投注金额",@"content":[NSString stringWithFormat:@"%.2f元",self.model.betAmount ? self.model.betAmount.floatValue : 0.0]},
  @{@"title":@"中奖金额",@"content":[NSString stringWithFormat:@"%.2f元",self.model.winAmount.doubleValue]},
  @{@"title":@"赔        率",@"content":self.model.odds},
  @{@"title":@"投注注数",@"content":[NSString stringWithFormat:@"%ld",(long)self.model.betCount]},
  @{@"title":@"中奖注数",@"content":self.model.winCount ? [NSString stringWithFormat:@"%ld",(long)self.model.winCount] : @"0"},
  
  @{@"title":@"盈        亏",@"content":[NSString stringWithFormat:@"%.2f元",([self.model.winAmount doubleValue] * 1.0 - (self.model.betAmount ? [self.model.betAmount doubleValue] *1.0: 0.0))*1.0]},
  
  @{@"title":@"返        点",@"content":self.model.backAmount ? self.model.backAmount.stringValue : @"0.0"}];

 [self.tableVC registerClass:[BettingDetailCell class] forCellReuseIdentifier:@"BettingDetailCell"];
    
}
- (void)setupUI {
    [self setHeaderView];
    [self.view addSubview:self.tableVC];
    [self setBottomView];
}

#pragma mark - vvUITableView
- (UITableView *)tableVC {
    if (!_tableVC) {
        _tableVC = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kSCREEN_WIDTH, kSCREEN_HEIGHT -Height_NavBar - 40) style:UITableViewStylePlain];
        _tableVC.backgroundColor = [UIColor whiteColor];
        _tableVC.dataSource = self;
        _tableVC.delegate = self;
        if (@available(iOS 11.0, *)) {
            _tableVC.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        // 去除横线
        _tableVC.separatorStyle = UITableViewCellAccessoryNone;
        _tableVC.rowHeight = 26;
        _tableVC.tableHeaderView = self.headerView;
    }
    return _tableVC;
}




- (void)setUIValue {
    int index = 0;
    
    if (self.model.openNumber.length) {
        
        self.opennumbertitlelab.hidden = NO;
        NSArray *numArr = [self.model.openNumber componentsSeparatedByString:@","];
        
        if (numArr.count > 10) {
            
            for (int i = 0; i < numArr.count; i++) {
                
                CGFloat w = 31;
                CGFloat h = 31;
                CGFloat margin = (SCREEN_WIDTH - CGRectGetMaxX(self.opennumbertitlelab.frame) - w * 6 -30)/5;
                CGFloat x = CGRectGetMaxX(self.opennumbertitlelab.frame) + 10 + (margin + w ) * (i%6);
                CGFloat y = self.opennumbertitlelab.y + (5 + h)*(i/6);
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
                [btn setBackgroundImage:[UIImage imageNamed:@"kj_orangeboll"] forState:UIControlStateNormal];
                [btn setTitle:numArr[i] forState:UIControlStateNormal];
                [self.headBottomView addSubview:btn];
                
            }
            
            for (UIButton *btn in self.resultBtns) {
                btn.hidden = YES;
            }
            
        }else{
            for (NSString *num in numArr) {
                
                UIButton *btn = [self.resultBtns objectAtIndex:index];
                
                btn.hidden = NO;
                if(self.model.lotteryId == CPTBuyTicketType_Shuangseqiu){
                    if(index == 6){
                        [btn setBackgroundImage:[UIImage imageNamed:@"img_blueball_selected"] forState:UIControlStateNormal];
                    }
                }else if(self.model.lotteryId == CPTBuyTicketType_DaLetou){
                    if(index == 5 || index == 6){
                        [btn setBackgroundImage:[UIImage imageNamed:@"img_blueball_selected"] forState:UIControlStateNormal];
                    }
                }else if(self.model.lotteryId == CPTBuyTicketType_QiLecai){
                    if(index == 7){
                        [btn setBackgroundImage:[UIImage imageNamed:@"img_blueball_selected"] forState:UIControlStateNormal];
                    }
                }
                
                [btn setTitle:num forState:UIControlStateNormal];
                
                if (self.model.lotteryId == CPTBuyTicketType_LiuHeCai||self.model.lotteryId == CPTBuyTicketType_OneLiuHeCai||self.model.lotteryId == CPTBuyTicketType_FiveLiuHeCai||self.model.lotteryId == CPTBuyTicketType_ShiShiLiuHeCai) {
                    
                    [btn setBackgroundImage:[Tools numbertoimage:num Withselect:NO] forState:UIControlStateNormal];
                    
                    [btn setTitleColor:YAHEI forState:UIControlStateNormal];
                }
                index++;
            }
        }
        
        
        if (self.model.lotteryId == CPTBuyTicketType_PK10 || self.model.lotteryId == CPTBuyTicketType_TenPK10|| self.model.lotteryId == CPTBuyTicketType_FivePK10|| self.model.lotteryId == CPTBuyTicketType_JiShuPK10|| self.model.lotteryId == CPTBuyTicketType_AoZhouF1|| self.model.lotteryId == CPTBuyTicketType_XYFT|| self.model.lotteryId == CPTBuyTicketType_FantanPK10|| self.model.lotteryId == CPTBuyTicketType_FantanXYFT|| self.model.lotteryId == CPTBuyTicketType_NiuNiu_JiShu|| self.model.lotteryId == CPTBuyTicketType_NiuNiu_AoZhou||self.model.lotteryId == CPTBuyTicketType_QiLecai ||self.model.lotteryId == CPTBuyTicketType_LiuHeCai||self.model.lotteryId == CPTBuyTicketType_OneLiuHeCai||self.model.lotteryId == CPTBuyTicketType_FiveLiuHeCai||self.model.lotteryId == CPTBuyTicketType_ShiShiLiuHeCai) {
            
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 + 5);
        }
        else if (self.model.lotteryId == CPTBuyTicketType_AoZhouACT){
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 270 + 5);
        }else{
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 165 + 5);
        }
        
    } else {
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120 + 5);
        self.tit2Label.hidden = YES;
    }
    

    NSString * name = self.model.lotteryName;
    if([name isEqualToString:@"排列3/5"]){
        name= @"排列35";
    }
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        name = [NSString stringWithFormat:@"tw_%@",name];
    }
    self.iconimgv.image = IMAGE(name);
    
    
    CGFloat number_h = [Tools createLableHighWithString:self.publishnumberlab.text andfontsize:15 andwithwidth:SCREEN_WIDTH - 91];
    
    if (number_h > 40) {
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.headerView.bounds.size.height + number_h -10);
    }
    
    if ([self.model.tbStatus isEqualToString:@"WAIT"]) {
        [self.nextBtn setTitle:@"撤单" forState:UIControlStateNormal];
    } else {
        [self.nextBtn setTitle:@"再次下注" forState:UIControlStateNormal];
    }
    self.tableVC.tableHeaderView = self.headerView;
    if(self.model.winAmount.floatValue -  self.model.betAmount.floatValue >0.0){
        self.isRed = YES;
    }else{
        self.isRed = NO;
    }
}

- (void)judgingLotTypeImage {
    
    if (self.model.lotteryId == CPTBuyTicketType_SSC) {//重庆时时彩
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_1_2") : IMAGE(@"home_1");
        
    } else if (self.model.lotteryId == CPTBuyTicketType_XJSSC) {//新疆时时彩
        
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_4_2") : IMAGE(@"home_4");

    } else if (self.model.lotteryId == CPTBuyTicketType_TJSSC) {//天津时时彩
        self.iconimgv.image = IMAGE(@"天津时时彩");
 
    } else if (self.model.lotteryId == CPTBuyTicketType_FFC) {//比特币分分彩
        
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_6_2") : IMAGE(@"home_6");
        
    } else if (self.model.lotteryId == CPTBuyTicketType_LiuHeCai) {//香港六合彩
        
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_2_2") : IMAGE(@"home_2");
      
    } else if (self.model.lotteryId == CPTBuyTicketType_PCDD) {//PC蛋蛋
        
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_7_2") : IMAGE(@"home_7");

    } else if (self.model.lotteryId == CPTBuyTicketType_PK10) {//北京PK10
        
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_3_2") : IMAGE(@"home_3");
 
    } else if (self.model.lotteryId == CPTBuyTicketType_XYFT) {//幸运飞艇
        self.iconimgv.image = [self.model.tbStatus isEqualToString:@"NO_WIN"] ? IMAGE(@"home_5_2") : IMAGE(@"home_5");

    } else{
        NSString * imageName = [NSString stringWithFormat:@"%ld",(long)self.model.lotteryId];
        self.iconimgv.image = IMAGE(imageName);

    }
    
}

#pragma mark -  推单
-(void)pushorder:(UIButton *)sender {
    
//    NSMutableArray *orderBetIds = [[NSMutableArray alloc]init];
//    BettingModel *hahaModel;
//
//    for (BettingModel *model in self.dataSource) {
//        if (model.selected) {
//            [orderBetIds addObject:model.ID];
//            hahaModel = model;
//        }
//    }
//
//    if (orderBetIds.count == 0) {
//
//        [MBProgressHUD showError:@"请选择推单"];
//
//        return;
//    }
//    if(![BallTool isLongwaveById:hahaModel.lotteryId]){
//        [MBProgressHUD showError:@"高频彩不允许推单"];
//        return;
//    }
//
//    UIStoryboard *mine = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
//
//    PushBettingCtrl *betting = [mine instantiateViewControllerWithIdentifier:@"PushBettingCtrl"];
//
//    betting.orderBetIds = orderBetIds;
//    betting.odd = hahaModel.odds;
//    PUSH(betting);
    
    
    if (!self.model) {
        [MBProgressHUD showError:@"请选择推单"];
        return;
    }
    if(![BallTool isLongwaveById:self.model.lotteryId]){
        [MBProgressHUD showError:@"高频彩不允许推单"];
        return;
    }
    
    UIStoryboard *mine = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    PushBettingCtrl *betting = [mine instantiateViewControllerWithIdentifier:@"PushBettingCtrl"];
    //    betting.odd = hahaModel.odds;
    betting.model = self.model;
    PUSH(betting);
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BettingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BettingDetailCell"];
    if(cell == nil) {
        cell = [BettingDetailCell cellWithTableView:tableView reusableId:@"BettingDetailCell"];
    }
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    
    if(indexPath.row ==3){
        cell.titlelab.textColor = cell.contentlab.textColor = [UIColor redColor];
    }
    
    else if(indexPath.row ==7){
        cell.titlelab.textColor = cell.contentlab.textColor = self.isRed? [UIColor redColor] :  [UIColor greenColor];
    }
    
    cell.titlelab.text = dic[@"title"];
    
    cell.contentlab.text = dic[@"content"];
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return cell;
}



- (void)publishClick:(UIButton *)sender {
    if ([self.model.tbStatus isEqualToString:@"WAIT"]) {
        
        [AlertViewTool alertViewToolShowTitle:@"" message:@"确定撤单？" cancelTitle:@"取消" confiormTitle:@"撤单" fromController:self handler:^(NSInteger index) {
            sender.enabled = NO;

            if (index == 1) {
                @weakify(self)
                [WebTools postWithURL:@"/order/orderBack.json" params:@{@"userId":[Person person].uid,@"id":self.model.ID} success:^(BaseData *data) {
                    @strongify(self)
                    sender.enabled = YES;
                    if (self.deleteorderBlock) {
                        
                        self.deleteorderBlock();
                    }
                    [MBProgressHUD showSuccess:data.info finish:^{
                        @strongify(self)

                        [self popback];
                    }];
                    
                } failure:^(NSError *error) {
                    sender.enabled = YES;
                } showHUD:NO];
            }
        }];
    }
    else {
        [self postorder];
    }
}

#pragma mark - 获取下期开奖期数和时间
-(void)getNextDate {
//    @weakify(self)
//    [Tools getNextOpenTime:self.model.lotteryId Withresult:^(NSDictionary *dic) {
//        @strongify(self)
//
//        self.issue = STRING(dic[@"issue"]);
//
//    }];
    

    
    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.model.lotteryId)] callBack:^(IGKbetModel * _Nonnull model, BOOL isSuccess) {
        switch (self.model.lotteryId) {
            case CPTBuyTicketType_SSC:
                self.issue = model.cqssc.issue;
                break;
            case CPTBuyTicketType_XJSSC:
                self.issue = model.xjssc.issue;
                break;
            case CPTBuyTicketType_TJSSC:
                self.issue = model.tjssc.issue;
                break;
            case CPTBuyTicketType_TenSSC:
                self.issue = model.tenssc.issue;
                break;
            case CPTBuyTicketType_FiveSSC:
                self.issue = model.fivessc.issue;
                break;
            case CPTBuyTicketType_JiShuSSC:
                self.issue = model.jsssc.issue;
                break;
            case CPTBuyTicketType_LiuHeCai:
                self.issue = model.lhc.issue;
                break;
            case CPTBuyTicketType_OneLiuHeCai:
                self.issue = model.onelhc.issue;
                break;
            case CPTBuyTicketType_FiveLiuHeCai:
                self.issue = model.fivelhc.issue;
                break;
            case CPTBuyTicketType_ShiShiLiuHeCai:
                self.issue = model.sslhc.issue;
                break;
            case CPTBuyTicketType_PK10:
                self.issue = model.bjpks.issue;
                break;
            case CPTBuyTicketType_TenPK10:
                self.issue = model.tenpks.issue;
                break;
            case CPTBuyTicketType_FivePK10:
                self.issue = model.fivepks.issue;
                break;
            case CPTBuyTicketType_JiShuPK10:
                self.issue = model.jspks.issue;
                break;
                
            case CPTBuyTicketType_XYFT:
                self.issue = model.xyft.issue;
                break;
            case CPTBuyTicketType_PCDD:
                self.issue = model.pcegg.issue;
                break;
            case CPTBuyTicketType_FFC:
                self.issue = model.txffc.issue;
                break;
            case CPTBuyTicketType_DaLetou:
                self.issue = model.daLetou.issue;
                break;
            case CPTBuyTicketType_PaiLie35:
                self.issue = model.paiLie35.issue;
                break;
            case CPTBuyTicketType_HaiNanQiXingCai:
                self.issue = model.haiNanQiXingCai.issue;
                break;
            case CPTBuyTicketType_Shuangseqiu:
                self.issue = model.shuangseqiu.issue;
                break;
            case CPTBuyTicketType_3D:
                self.issue = model.threeD.issue;
                break;
            case CPTBuyTicketType_QiLecai:
                self.issue = model.qiLecai.issue;
                break;
            case CPTBuyTicketType_NiuNiu_KuaiLe:
                self.issue = model.nnKuaile.issue;
                break;
            case CPTBuyTicketType_NiuNiu_AoZhou:
                self.issue = model.nnAozhou.issue;
                break;
            case CPTBuyTicketType_NiuNiu_JiShu:
                self.issue = model.nnJisu.issue;
                break;
            case CPTBuyTicketType_FantanSSC:
                self.issue = model.jsssc.issue;
                break;
            case CPTBuyTicketType_FantanXYFT:
                self.issue = model.xyft.issue;
                break;
            case CPTBuyTicketType_FantanPK10:
                self.issue = model.jspks.issue;
                break;
            case CPTBuyTicketType_AoZhouACT:
                self.issue = model.aoZhouACT.issue;
                break;
            case CPTBuyTicketType_AoZhouF1:
                self.issue = model.aozhouF1.issue;
                break;
            case CPTBuyTicketType_AoZhouShiShiCai:
                self.issue = model.aozhouSSC.issue;
                break;
                
            default:
                break;
        }
    }];
}

-(void)postorder {
    @weakify(self)

    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.model.lotteryId)] callBack:^(IGKbetModel * _Nonnull model, BOOL isSuccess) {
        @strongify(self)
        switch (self.model.lotteryId) {
            case CPTBuyTicketType_SSC:
                self.issue = model.cqssc.nextIssue;
                break;
            case CPTBuyTicketType_XJSSC:
                self.issue = model.xjssc.nextIssue;
                break;
            case CPTBuyTicketType_TJSSC:
                self.issue = model.tjssc.nextIssue;
                break;
            case CPTBuyTicketType_TenSSC:
                self.issue = model.tenssc.nextIssue;
                break;
            case CPTBuyTicketType_FiveSSC:
                self.issue = model.fivessc.nextIssue;
                break;
            case CPTBuyTicketType_JiShuSSC:
                self.issue = model.jsssc.nextIssue;
                break;
            case CPTBuyTicketType_LiuHeCai:
                self.issue = model.lhc.nextIssue;
                break;
            case CPTBuyTicketType_OneLiuHeCai:
                self.issue = model.onelhc.nextIssue;
                break;
            case CPTBuyTicketType_FiveLiuHeCai:
                self.issue = model.fivelhc.nextIssue;
                break;
            case CPTBuyTicketType_ShiShiLiuHeCai:
                self.issue = model.sslhc.nextIssue;
                break;
            case CPTBuyTicketType_PK10:
                self.issue = [NSString stringWithFormat:@"%ld",(long)model.bjpks.nextIssue];
                break;
            case CPTBuyTicketType_TenPK10:
                self.issue = [NSString stringWithFormat:@"%ld",(long)model.tenpks.nextIssue];
                break;
            case CPTBuyTicketType_FivePK10:
                self.issue = [NSString stringWithFormat:@"%ld",(long)model.fivepks.nextIssue];
                break;
            case CPTBuyTicketType_JiShuPK10:
                self.issue = [NSString stringWithFormat:@"%ld",(long)model.jspks.nextIssue];
                break;
                
            case CPTBuyTicketType_XYFT:
                self.issue = [NSString stringWithFormat:@"%ld",(long)model.xyft.nextIssue];
                break;
            case CPTBuyTicketType_PCDD:
                self.issue = model.pcegg.nextIssue;
                break;
            case CPTBuyTicketType_FFC:
                self.issue = model.txffc.nextIssue;
                break;
            case CPTBuyTicketType_DaLetou:
                self.issue = model.daLetou.nextIssue;
                break;
            case CPTBuyTicketType_PaiLie35:
                self.issue = model.paiLie35.nextIssue;
                break;
            case CPTBuyTicketType_HaiNanQiXingCai:
                self.issue = model.haiNanQiXingCai.nextIssue;
                break;
            case CPTBuyTicketType_Shuangseqiu:
                self.issue = model.shuangseqiu.nextIssue;
                break;
            case CPTBuyTicketType_3D:
                self.issue = model.threeD.nextIssue;
                break;
            case CPTBuyTicketType_QiLecai:
                self.issue = model.qiLecai.nextIssue;
                break;
            case CPTBuyTicketType_NiuNiu_KuaiLe:
                self.issue = model.nnKuaile.nextIssue;
                break;
            case CPTBuyTicketType_NiuNiu_AoZhou:
                self.issue = model.nnAozhou.nextIssue;
                break;
            case CPTBuyTicketType_NiuNiu_JiShu:
                self.issue = model.nnJisu.nextIssue;
                break;
            case CPTBuyTicketType_FantanSSC:
                self.issue = model.jsssc.nextIssue;
                break;
            case CPTBuyTicketType_FantanXYFT:
                self.issue = model.fantanXYFT.nextIssue;
                break;
            case CPTBuyTicketType_FantanPK10:
                self.issue = model.fantanPK10.nextIssue;
                break;
            case CPTBuyTicketType_AoZhouACT:
                self.issue = model.aoZhouACT.nextIssue;
                break;
            case CPTBuyTicketType_AoZhouF1:
                self.issue = model.aozhouF1.nextIssue;
                break;
            case CPTBuyTicketType_AoZhouShiShiCai:
                self.issue = model.aozhouSSC.nextIssue;
                break;
                
            default:
                break;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:self.issue forKey:@"issue"];
        [dic setValue:@(self.model.lotteryId) forKey:@"lotteryId"];
        [dic setValue:[Person person].uid forKey:@"userId"];
        NSMutableArray *betlist = [[NSMutableArray alloc]init];
        NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
        [listdic setValue:@(self.model.playId) forKey:@"playId"];
        [listdic setValue:@(self.model.settingId) forKey:@"settingId"];
        [listdic setValue:@(self.model.betCount) forKey:@"betCount"];
        
        [listdic setValue:self.model.betNumber forKey:@"betNumber"];
        NSInteger amout = self.model.betAmount.integerValue / self.model.betCount;
        [listdic setValue:@(amout) forKey:@"betAmount"];
        [betlist addObject:listdic];
        [dic setValue:betlist forKey:@"orderBetList"];
        //    |—— playId    Integer    （必须）玩法id
        //    |—— settingId    Integer    （必须）玩法配置id
        //    |—— betNumber    String    （必须）投注号码
        //    |—— betAmount    double    （必须）投注金额
        //    |—— betCount    Integer    （必须）总注数  1
        [WebTools postWithURL:@"/order/orderBet.json" params:dic success:^(BaseData *data) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"REFRESHORDER" object:nil];
            
            [MBProgressHUD showSuccess:data.info finish:^{
                @strongify(self)
                
                [self popback];
            }];
            
        } failure:^(NSError *error) {
            
        }];
    }];
}



- (void)setBottomView {
    UIView *bootomView = [[UIView alloc] init];
    bootomView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_ThemeColorTwe];
    [self.view addSubview:bootomView];
    
    [bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHex:@"FFFFFF"];
    lineView.hidden = YES;
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bootomView.mas_top).offset(6);
        make.bottom.equalTo(bootomView.mas_bottom).offset(-6);
        make.centerX.equalTo(bootomView.mas_centerX);
        make.width.mas_equalTo(0.5);
    }];
    
    
    UIButton *nextBtn = [[UIButton alloc] init];
    
    [nextBtn addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    nextBtn.backgroundColor = [UIColor clearColor];
    nextBtn.tag = 1000;
    [bootomView addSubview:nextBtn];

    if ([self.model.tbStatus isEqualToString:@"WAIT"] && [self.bettingtype isEqualToString:@"NORMAL"]) {
        
        [nextBtn setTitle:@"撤单" forState:UIControlStateNormal];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(bootomView);
        }];
        
        // 屏蔽推单  AFan<<<
        lineView.hidden = NO;
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(bootomView);
            make.right.equalTo(lineView.mas_left);
        }];

        UIButton *pushBtn = [[UIButton alloc] init];
        [pushBtn setTitle:@"推单" forState:UIControlStateNormal];
        [pushBtn addTarget:self action:@selector(pushorder:) forControlEvents:UIControlEventTouchUpInside];
        pushBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        pushBtn.backgroundColor = [UIColor clearColor];
        pushBtn.tag = 1001;
        [bootomView addSubview:pushBtn];

        [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(bootomView);
            make.left.equalTo(lineView.mas_right);
        }];
        
        
    } else {
        [nextBtn setTitle:@"再次下单" forState:UIControlStateNormal];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(bootomView);
        }];
    }
    
}




- (void)setHeaderView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 162)];
    backView.backgroundColor = [UIColor whiteColor];
    _headerView = backView;
    
    
    UIImageView *iconimgv = [[UIImageView alloc] init];
    //    iconimgv.image = [UIImage imageNamed:@"imageName"];
    [backView addSubview:iconimgv];
    _iconimgv = iconimgv;
    
    [iconimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(15);
        make.left.equalTo(backView.mas_left).offset(10);
        make.size.equalTo(@(55));
    }];
    
    UILabel *lotterynamelab = [[UILabel alloc] init];
    lotterynamelab.text = @"-";
    lotterynamelab.font = [UIFont systemFontOfSize:15];
    lotterynamelab.textColor = [UIColor colorWithHex:@"#333333"];
    lotterynamelab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:lotterynamelab];
    _lotterynamelab = lotterynamelab;
    
    [lotterynamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconimgv.mas_top).offset(6);
        make.left.equalTo(iconimgv.mas_right).offset(10);
    }];
    
    UIImageView *icimgv = [[UIImageView alloc] init];
    icimgv.image = [UIImage imageNamed:@"nextstep"];
    [backView addSubview:icimgv];
    
    [icimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lotterynamelab.mas_centerY);
        make.left.equalTo(lotterynamelab.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    
    UILabel *typelab = [[UILabel alloc] init];
    typelab.text = @"-";
    typelab.font = [UIFont systemFontOfSize:15];
    typelab.textColor = [UIColor colorWithHex:@"#333333"];
    typelab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:typelab];
    _typelab = typelab;
    
    [typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lotterynamelab.mas_centerY);
        make.left.equalTo(icimgv.mas_right).offset(10);
    }];
    
    
    UILabel *issuelab = [[UILabel alloc] init];
    issuelab.text = @"-";
    issuelab.font = [UIFont systemFontOfSize:14];
    issuelab.textColor = [UIColor colorWithHex:@"#666666"];
    issuelab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:issuelab];
    _issuelab = issuelab;
    
    [issuelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(iconimgv.mas_bottom).offset(-6);
        make.left.equalTo(lotterynamelab.mas_left);
    }];
    
    
    
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    [backView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(85);
        make.left.equalTo(backView.mas_left).offset(10);
        make.right.equalTo(backView.mas_right).offset(-10);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *tit1Label = [[UILabel alloc] init];
    tit1Label.text = @"投注号码:";
    tit1Label.font = [UIFont systemFontOfSize:15];
    tit1Label.textColor = [UIColor colorWithHex:@"#333333"];
    tit1Label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:tit1Label];
    
    [tit1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_top).offset(12);
        make.left.equalTo(backView.mas_left).offset(10);
    }];
    
    UILabel *publishnumberlab = [[UILabel alloc] init];
    publishnumberlab.text = @"-";
    publishnumberlab.font = [UIFont systemFontOfSize:15];
    publishnumberlab.textColor = [UIColor colorWithHex:@"#FF8610"];
    publishnumberlab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:publishnumberlab];
    _publishnumberlab = publishnumberlab;
    
    [publishnumberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tit1Label.mas_centerY);
        make.left.equalTo(tit1Label.mas_right).offset(8);
    }];
    
    UILabel *tit2Label = [[UILabel alloc] init];
    tit2Label.text = @"开奖号码:";
    tit2Label.font = [UIFont systemFontOfSize:15];
    tit2Label.textColor = [UIColor colorWithHex:@"#333333"];
    tit2Label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:tit2Label];
    _tit2Label = tit2Label;
    
    [tit2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tit1Label.mas_bottom).offset(15);
        make.left.equalTo(backView.mas_left).offset(10);
    }];
    
    
    for (int i = 0; i < 10; i++) {
        
        CGFloat w = 30;
        CGFloat h = 30;
        CGFloat margin = (SCREEN_WIDTH - 70 - w * 6 -30)/5;
        CGFloat x = 70 + 10 + (margin + w ) * (i%6);
        CGFloat y = 124 + (5 + h)*(i/6);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [btn setBackgroundImage:[UIImage imageNamed:@"kj_orangeboll"] forState:UIControlStateNormal];
        [btn setTitle:@"-" forState:UIControlStateNormal];
        btn.hidden = YES;
        [backView addSubview:btn];
        [self.resultBtns addObject:btn];
    }
    
}

- (NSMutableArray *)resultBtns {
    if (!_resultBtns) {
        _resultBtns = [NSMutableArray array];
    }
    return _resultBtns;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
