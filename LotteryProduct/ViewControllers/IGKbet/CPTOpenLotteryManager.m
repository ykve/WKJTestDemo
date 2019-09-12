//
//  CPTOpenLotteryDataManager.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTOpenLotteryManager.h"
#import "IGKbetModel.h"
#import "MSWeakTimer.h"
#import "AppDelegate.h"
#import "ShowMessageViewController.h"
#import "DragonLongModel.h"


@interface CPTOpenLotteryManager()<SRWebSocketDelegate>{
    __block IGKbetModel *_model;
    __block MSWeakTimer *_timer;
    NSMutableDictionary *_openTimeInfoDic;
    NSArray *_wait30sArray;
    NSArray *_wait6sArray;
    NSMutableSet *_tmpWait30sSet;
    NSMutableSet *_tmpWait6sSet;
    
    NSTimer * heartBeat;
    NSTimeInterval reConnectTime;
    SocketDataType type;
    NSString *host;
}
@property(nonatomic,copy) NSString *mqttU;
@property(nonatomic, strong)NSArray *topics;
@property(nonatomic, strong)NSArray *dragonLongArray;
@property (nonatomic,strong) SRWebSocket *socket;

@end

@implementation CPTOpenLotteryManager
static CPTOpenLotteryManager *manager;
+ (id)shareManager
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            manager = [[self alloc] init];
        });
    }
    return manager;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _mqttU = MQTTURL;
        //        _model = [[IGKbetModel alloc] init];
        _wait30sArray = @[@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_XYFT),@(CPTBuyTicketType_PCDD),@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_3D),@(CPTBuyTicketType_PaiLie35),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_HaiNanQiXingCai),@(CPTBuyTicketType_QiLecai)];
        _wait6sArray = @[@(CPTBuyTicketType_TenSSC),@(CPTBuyTicketType_FiveSSC),@(CPTBuyTicketType_JiShuSSC),@(CPTBuyTicketType_OneLiuHeCai),@(CPTBuyTicketType_FiveLiuHeCai),@(CPTBuyTicketType_ShiShiLiuHeCai),@(CPTBuyTicketType_TenPK10),@(CPTBuyTicketType_FivePK10),@(CPTBuyTicketType_JiShuPK10),@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_NiuNiu_JiShu),@(CPTBuyTicketType_FantanSSC),@(CPTBuyTicketType_FantanPK10),@(CPTBuyTicketType_PCDD),@(CPTBuyTicketType_FFC),@(CPTBuyTicketType_AoZhouShiShiCai),@(CPTBuyTicketType_AoZhouACT),@(CPTBuyTicketType_AoZhouF1),@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_NiuNiu_JiShu),@(CPTBuyTicketType_NiuNiu_AoZhou)];
        self.topics = @[@"new_jsbjpks",@"TOPIC_PK10_JS_FT",@"TOPIC_TENBJPKS",@"TOPIC_FIVEBJPKS",@"TOPIC_BJPKS",@"TOPIC_SS_LHC",@"TOPIC_AUS_ACT",@"TOPIC_AUS_F1",@"TOPIC_AUS_SSC",@"TOPIC_LHC_FIVE",@"TOPIC_LHC_ONE",@"TOPIC_APP_FC_SSQ",@"TOPIC_APP_FC_7LC",@"TOPIC_APP_FC_3D",@"TOPIC_APP_TC_7XC",@"TOPIC_APP_TC_DLT",@"TOPIC_APP_TC_PLW",@"TOPIC_APP_TC_PLS",@"TOPIC_APP_SSC_FIVE",@"TOPIC_APP_SSC_TEN",@"TOPIC_APP_SSC_TJ",@"TOPIC_APP_SSC_JS",@"TOPIC_APP_SSC_JS_FT",@"TOPIC_APP_PCEGG",@"TOPIC_APP_SSC_TX",@"TOPIC_APP_XYFT",@"TOPIC_APP_SSC_CQ",@"TOPIC_APP_JS_NN",@"TOPIC_APP_NN_KL",@"TOPIC_AUS_NN",@"TOPIC_APP_XYFT_FT",@"TOPIC_APP_SSC_XJ",@"TOPIC_FREEZE_USERNOTICE",@"TOPIC_CHANGEMC_USERNOTICE",@"kj_xglhc_recommend",@"APP_CHAT_KEY"];

        self.dragonLongArray =  @[@"TOPIC_AUSPKS_DRAGONLONG_DATA",@"TOPIC_PCEGG_DRAGONLONG_DATA",@"TOPIC_SSC_DRAGONLONG_DATA",@"TOPIC_LHC_DRAGONLONG_DATA",@"TOPIC_PKTEN_DRAGONLONG_DATA"];

        _tmpWait30sSet = [NSMutableSet set];
        _tmpWait6sSet = [NSMutableSet set];
        
        _longVC = [[CPTOpenLotteryCtrl alloc] init];

        //        _timer = [MSWeakTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(configTime) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
        //        [_timer invalidate];
        NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;

    }
    return self;
}

- (void)cannelBlock{
    if(self.didReceiveChatMessage){
        self.didReceiveChatMessage = nil;
    }
    if(self.connectSuccess){
        self.connectSuccess= nil;
    }
}
//
//-(void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid
//{
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
////    id aaa = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];
////    MBLog(@"====+++%@",topic);
//    if (basedata.status.integerValue == 1){
//        if([basedata.data isKindOfClass:[NSDictionary class]]){
//            if ([topic hasPrefix:@"APP_CHAT_KEY"]||[topic isEqualToString:@"kj_xglhc_recommend"]){
//                NSString *top;
//                if([topic isEqualToString:@"kj_xglhc_recommend"]){
//                    top = @"2";//lhc新开奖结果
//                }else{
//                    top = @"1";//聊天
//                }
//                MBLog(@"%@",basedata.data);
//                if(self.didReceiveChatMessage){
//                    ChatMessageModel *model = [ChatMessageModel mj_objectWithKeyValues:basedata.data];
//                    model.orderModel = [OrderModel mj_objectWithKeyValues:model.pushOrderContentVO];
//                    self.didReceiveChatMessage(model, top);
//                }
//            }else if ([topic hasPrefix:@"TOPIC_FREEZE_USERNOTICE"]){//后台冻结账户
//                NSDictionary *dic = basedata.data ;
//                if([dic[@"uid"] isEqualToString:[[Person person] uid]]){
//                    [self showMessageVCByType:2];
//                }
//            }else if ([topic hasPrefix:@"TOPIC_CHANGEMC_USERNOTICE"]){//踢下线
////                [self showMessageVCByType:1];
//            } else if ([topic containsString:@"DRAGONLONG"]){  // 长龙推送
//
//                DragonLongModel *longModel = [DragonLongModel mj_objectWithKeyValues:basedata.data];
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                NSArray *pushSelectLotArray = [defaults objectForKey:@"pushSelectLotArray"];
//                NSArray *pushSelectLongNumArray = [defaults objectForKey:@"pushSelectLongNumArray"];
//
//
//                if (pushSelectLotArray.count > 0 && pushSelectLongNumArray.count > 0) {
//                    for (NSMutableDictionary *lotTitleDict in pushSelectLotArray) {
//                        if ([lotTitleDict[@"titleValue"] isEqualToString: topic]) {
//
//                            for (NSMutableDictionary *longNumDict in pushSelectLongNumArray) {
//                                if ([longNumDict[@"titleValue"] integerValue] == longModel.dragonNum || ([longNumDict[@"titleValue"] integerValue] == 1200 && longModel.dragonNum > 12)) {
//
//                                    [[NSNotificationCenter defaultCenter] postNotificationName:kDragonLongPushNotification object:longModel];
//
//                                }
//                            }
//                        }
//                    }
//                }
//
//            } else {
//                IGKbetModel * tmpModel = [IGKbetModel mj_objectWithKeyValues:basedata.data];
//                for(NSString * idNumber in [basedata.data allKeys]){
////                    MBLog(@"onTopic allKeys:%@",idNumber);
//                    [self configModelByType:idNumber.integerValue IGKbetModel:tmpModel];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:idNumber object:self->_model];
//
//                }
//                //            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOpenLotteryUI" object:self->_model];
//                //            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshCPTBUYHEADVIEWUI" object:self->_model];
//            }
//        }
//    }
//
//
//    // 做相对应的操作
//}

//1 踢下线  2封号
- (void)showMessageVCByType:(NSInteger )code{
    ShowMessageViewController *login = [[ShowMessageViewController alloc]initWithNibName:NSStringFromClass([ShowMessageViewController class]) bundle:[NSBundle mainBundle]];
    login.code = code;//1 踢下线  2封号
    [[[[AppDelegate shareapp] window] rootViewController] presentViewController:login animated:YES completion:nil];
    [AppDelegate shareapp].window.backgroundColor = CLEAR;
//    [self presentViewController:login animated:YES completion:nil];
}

-(void)checkModel:(void (^)(IGKbetModel *data,BOOL isSuccess))success {
    if(!_model){
        @weakify(self)
        NSArray * ids = [[CPTBuyDataManager shareManager] allLotteryIds];
        NSString *tempString = [ids componentsJoinedByString:@","];//分隔符逗号
        [WebTools postWithURL:@"/sg/getNewestSgInfobyids.json" params:@{@"ids":tempString} success:^(BaseData *data) {            @strongify(self)
            IGKbetModel * tmpModel = [IGKbetModel mj_objectWithKeyValues:data.data];
            self.curenttime = data.time;
            for(NSNumber * idNumber in ids){
                [self configModelByType:idNumber.integerValue IGKbetModel:tmpModel];
            }
            [self configTimeByModel:self->_model];
            self.curenttime = data.time;
            if(success){
                success(_model,YES);
            }
        } failure:^(NSError *error) {
            if(success){
                success(_model,NO);
            }
        }showHUD:NO];
    }else{
        if(success){
            success(_model,YES);
        }
    }
}

-(void)checkModelByIds:(NSArray *)ids callBack:(void (^)(IGKbetModel *data,BOOL isSuccess))success {
    
    NSArray * tmpIDs;
    @weakify(self)
    if(!_model){
        tmpIDs = [[CPTBuyDataManager shareManager] allLotteryIds];
        
    }else{
        tmpIDs = ids;
    }
    NSString *tempString = [tmpIDs componentsJoinedByString:@","];//分隔符逗号
    
    [WebTools postWithURL:@"/sg/getNewestSgInfobyids.json" params:@{@"ids":tempString} success:^(BaseData *data) {
        @strongify(self)
        IGKbetModel * tmpModel = [IGKbetModel mj_objectWithKeyValues:data.data];
        self.curenttime = data.time;
        for(NSNumber * idNumber in tmpIDs){
            [self configModelByType:idNumber.integerValue IGKbetModel:tmpModel];
        }
        [self configTimeByModel:self->_model];
        
        if(success){
            success(self->_model,YES);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOpenLotteryUI" object:self->_model];
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshCPTBUYHEADVIEWUI" object:self->_model];
        }
    } failure:^(NSError *error) {
        if(success){
            @strongify(self)
            success(self->_model,NO);
        }
    }showHUD:NO];
}

-(void)refreshModel:(void (^)(IGKbetModel *data,BOOL isSuccess))success {
    @weakify(self)
    [WebTools postWithURL:@"/sg/getNewestSgInfo.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        _model = [IGKbetModel mj_objectWithKeyValues:data.data];
        self.curenttime = data.time;
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOpenLotteryUI" object:_model];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshCPTBUYHEADVIEWUI" object:_model];
        if(success){
            success(_model,YES);
        }
    } failure:^(NSError *error) {
        if(success){
            success(_model,NO);
        }
    }showHUD:NO];
}


- (void)getNewData{
    @weakify(self)
    NSArray * ids = [[CPTBuyDataManager shareManager] allLotteryIds];
    [self checkModelByIds:ids callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
        if(isSuccess){
            @strongify(self)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOpenLotteryUI" object:self->_model];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshCPTBUYHEADVIEWUI" object:self->_model];
        }
    }];

}

- (void)pauseTimer{
    if(_timer){
        [_timer invalidate];
    }
}

- (void)startTimer{
        if(_timer){
            [_timer invalidate];
            _timer = nil;
        }
        _timer = [MSWeakTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(loadLHCData) userInfo:nil repeats:YES dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}

- (void)configModelByType:(CPTBuyTicketType)type IGKbetModel:(IGKbetModel *)model{
    if(!_model){
        _model = [[IGKbetModel alloc] init];
    }
    switch (type) {
        case CPTBuyTicketType_SSC:
            _model.cqssc = model.cqssc;
            break;
        case CPTBuyTicketType_XJSSC:
            _model.xjssc = model.xjssc;
            break;
        case CPTBuyTicketType_TJSSC:
            _model.tjssc = model.tjssc;
            break;
        case CPTBuyTicketType_TenSSC:
            _model.tenssc = model.tenssc;
            break;
        case CPTBuyTicketType_FiveSSC:
            _model.fivessc = model.fivessc;
            break;
        case CPTBuyTicketType_JiShuSSC:
            _model.jsssc = model.jsssc;
            break;
        case CPTBuyTicketType_LiuHeCai:
            _model.lhc = model.lhc;
            break;
        case CPTBuyTicketType_OneLiuHeCai:
            _model.onelhc = model.onelhc;
            break;
        case CPTBuyTicketType_FiveLiuHeCai:
            _model.fivelhc = model.fivelhc;
            break;
        case CPTBuyTicketType_ShiShiLiuHeCai:
            _model.sslhc = model.sslhc;
            break;
        case CPTBuyTicketType_PK10:
            _model.bjpks = model.bjpks;
            break;
        case CPTBuyTicketType_TenPK10:
            _model.tenpks = model.tenpks;
            break;
        case CPTBuyTicketType_FivePK10:
            _model.fivepks = model.fivepks;
            break;
        case CPTBuyTicketType_JiShuPK10:
            _model.jspks = model.jspks;
            break;
            
        case CPTBuyTicketType_XYFT:
            _model.xyft = model.xyft;
            break;
        case CPTBuyTicketType_PCDD:
            _model.pcegg = model.pcegg;
            break;
        case CPTBuyTicketType_FFC:
            _model.txffc = model.txffc;
            break;
        case CPTBuyTicketType_DaLetou:
            _model.daLetou = model.daLetou;
            break;
        case CPTBuyTicketType_PaiLie35:
            _model.paiLie35 = model.paiLie35;
            break;
        case CPTBuyTicketType_HaiNanQiXingCai:
            _model.haiNanQiXingCai = model.haiNanQiXingCai;
            break;
        case CPTBuyTicketType_Shuangseqiu:
            _model.shuangseqiu = model.shuangseqiu;
            break;
        case CPTBuyTicketType_3D:
            _model.threeD = model.threeD;
            break;
        case CPTBuyTicketType_QiLecai:
            _model.qiLecai = model.qiLecai;
            break;
        case CPTBuyTicketType_NiuNiu_KuaiLe:
        {
            _model.nnKuaile = model.nnKuaile;
            NSString * s = [_model.nnKuaile.number stringByReplacingOccurrencesOfString:@"," withString:@""];
            _model.nnKuaile.number = s;
        }
            break;
        case CPTBuyTicketType_NiuNiu_AoZhou:
            _model.nnAozhou = model.nnAozhou;
            break;
        case CPTBuyTicketType_NiuNiu_JiShu:
            _model.nnJisu = model.nnJisu;
            break;
        case CPTBuyTicketType_FantanSSC:
            _model.fantanSSC = model.fantanSSC;
            break;
        case CPTBuyTicketType_FantanXYFT:
            _model.fantanXYFT = model.fantanXYFT;
            break;
        case CPTBuyTicketType_FantanPK10:
            _model.fantanPK10 = model.fantanPK10;
            break;
        case CPTBuyTicketType_AoZhouACT:
            _model.aoZhouACT = model.aoZhouACT;
            break;
        case CPTBuyTicketType_AoZhouF1:
            _model.aozhouF1 = model.aozhouF1;
            break;
        case CPTBuyTicketType_AoZhouShiShiCai:
            _model.aozhouSSC = model.aozhouSSC;
            break;
            
        default:
            break;
    }
}

- (void)loadLHCData{
    if(_model){
        if(_model.lhc){
            long nowTime = [[NSDate date] timeIntervalSince1970];
            long openTime = _model.lhc.nextTime;
            if(nowTime - openTime >=0 ){
                @weakify(self)
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    [self checkModelByIds:@[@(1201)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
                        if(isSuccess){
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"CPTBuyTicketType_LiuHeCai" object:self->_model];
                        }
                    }];
                });
            }
        }
    }
}

#pragma mark- 倒计时为0后请求数据
- (void)configTimeByModel:(IGKbetModel *)model{
    
    //    快乐牛牛    五分时时彩
    //    澳洲牛牛    澳洲F1
    //    极速牛牛    极速时时彩
    //    极速PK10番摊    极速PK10
    //    幸运飞艇番摊    幸运飞艇
    //    极速时时彩番摊    极速时时彩
    
    self->_openTimeInfoDic = [NSMutableDictionary dictionaryWithDictionary:
                              @{
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_LiuHeCai):@(model.lhc?model.lhc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_OneLiuHeCai):@(model.onelhc?model.onelhc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FiveLiuHeCai):@(model.fivelhc?model.fivelhc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_ShiShiLiuHeCai):@(model.sslhc?model.sslhc.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_PK10):@(model.bjpks?model.bjpks.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_TenPK10):@(model.tenpks?model.tenpks.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FivePK10):@(model.fivepks?model.fivepks.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_JiShuPK10):@(model.jspks?model.jspks.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_AoZhouF1):@(model.aozhouF1?model.aozhouF1.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_AoZhouShiShiCai):@(model.aozhouSSC?model.aozhouSSC.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_AoZhouACT):@(model.aoZhouACT?model.aoZhouACT.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_SSC):@(model.cqssc?model.cqssc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_XJSSC):@(model.xjssc?model.xjssc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_TJSSC):@(model.tjssc?model.tjssc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_TenSSC):@(model.tenssc?model.tenssc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FiveSSC):@(model.fivessc?model.fivessc.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_JiShuSSC):@(model.jsssc?model.jsssc.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_XYFT):@(model.xyft?model.xyft.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_PCDD):@(model.pcegg?model.pcegg.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FFC):@(model.txffc?model.txffc.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_DaLetou):@(model.daLetou?model.daLetou.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_PaiLie35):@(model.paiLie35?model.paiLie35.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_HaiNanQiXingCai):@(model.haiNanQiXingCai?model.haiNanQiXingCai.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_Shuangseqiu):@(model.shuangseqiu?model.shuangseqiu.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_3D):@(model.threeD?model.threeD.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_QiLecai):@(model.qiLecai?model.qiLecai.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_NiuNiu_KuaiLe):@(model.nnKuaile?model.nnKuaile.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_NiuNiu_JiShu):@(model.nnJisu?model.nnJisu.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_NiuNiu_AoZhou):@(model.nnAozhou?model.nnAozhou.nextTime:100),
                                
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FantanPK10):@(model.fantanPK10?model.fantanPK10.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FantanXYFT):@(model.fantanXYFT?model.fantanXYFT.nextTime:100),
                                ChangeBuyTicketTypeToString(CPTBuyTicketType_FantanSSC):@(model.fantanSSC?model.fantanSSC.nextTime:100),
                                }];
    //    if(_timer){
    //        [_timer invalidate];
    //        _timer = nil;
    //    }
    
}

- (void)configTime{
    @synchronized (self) {
        
        __block NSMutableSet * types = [NSMutableSet set];
        long nowTime = [[NSDate date] timeIntervalSince1970];
        if(_openTimeInfoDic.count<1)return;
        for(NSNumber *openTime in self->_openTimeInfoDic.allValues){
            if(nowTime - [openTime doubleValue]>=0 && nowTime - [openTime doubleValue]<=60*20 && ![openTime  isEqual: @(100)]){
                if([openTime integerValue] ==0){
                    continue;
                }
                @weakify(self)
                @try {
                    [self ->_openTimeInfoDic enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
                        @strongify(self)
                        if (!obj) {
                            MBLog(@"enumerateKeysAndObjectsUsingBlock");
                            [self->_openTimeInfoDic removeObjectForKey:key];
                        }
                        else if (obj == openTime) {
                            [types addObject:key];
                        }
                    }];
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
            }
        }
        NSMutableArray * ids = [NSMutableArray array];
        for(NSString *object in types.allObjects){
            //        MBLog(@"key:%@",object);
            CPTBuyTicketType type = [[CPTBuyDataManager shareManager] changeTypeStringToStrong:object];
            [ids addObject:@(type)];
        }
        if(ids.count>0){
            @weakify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                [self getNewDataByIds:ids is30s:NO];
            });
        }
        //    if(ids.count>0){
        //        [self configWait30sDataByIds:ids];
        //        [self configWait6sDataByIds:ids];
        //    }
    }
}
- (BOOL)isconfigWait30sDataByIds:(CPTBuyTicketType )ids{
    if([_wait30sArray containsObject:@(ids)]){
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isconfigWait6sDataByIds:(CPTBuyTicketType )ids{
    if([_wait6sArray containsObject:@(ids)]){
        return YES;
    }else{
        return NO;
    }
}

- (void)configWait30sDataByIds:(NSMutableArray *)ids{
    for(NSNumber * idNumber in ids){
        if([_wait30sArray containsObject:idNumber]){
            [_tmpWait30sSet addObject:idNumber];
        }
    }
}

- (void)configWait6sDataByIds:(NSMutableArray *)ids{
    for(NSNumber * idNumber in ids){
        if([_wait6sArray containsObject:idNumber]){
            [_tmpWait6sSet addObject:idNumber];
        }
    }
}

//- (void)getNewDataWith30sIds{
//    if(_tmpWait30sSet.count>0){
//        @weakify(self)
//        MBLog(@"30sIds");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            @strongify(self)
//            [self getNewDataByIds:_tmpWait30sSet is30s:YES];
//        });
//
//    }
//}
//
//- (void)getNewDataWith6sIds{
//    if(_tmpWait6sSet.count>0){
//        @weakify(self)
//        MBLog(@"6sIds");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            @strongify(self)
//            [self getNewDataByIds:_tmpWait6sSet is30s:NO];
//        });
//    }
//}

- (void)getNewDataByIds:(NSMutableArray *)ids is30s:(BOOL)is30s{
    //    NSMutableArray * tmpids = [NSMutableArray array];
    //    for(NSNumber * idnumber in ids){
    //        [tmpids addObject: idnumber];
    //    }
    @weakify(self)
    NSString *tempString = [ids componentsJoinedByString:@","];//分隔符逗号
    [WebTools postWithURL:@"/sg/getNewestSgInfobyids.json" params:@{@"ids":tempString} success:^(BaseData *data) {
        @strongify(self)
        IGKbetModel *model = [IGKbetModel mj_objectWithKeyValues:data.data];
        for(NSNumber * idNumber in ids){
            [self configModelByType:idNumber.integerValue IGKbetModel:model];
        }
        [self configTimeByModel:self->_model];
        
        self.curenttime = data.time;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOpenLotteryUI" object:self->_model];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshCPTBUYHEADVIEWUI" object:self->_model];
        
        //        if(is30s){
        //            [self->_tmpWait30sSet removeAllObjects];
        //        }else{
        //            [self->_tmpWait6sSet removeAllObjects];
        //        }
    } failure:^(NSError *error) {
        
    }showHUD:NO];
}

#pragma mark - websocket

- (void)registerNetworkNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChangedNote:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}
- (void)networkChangedNote:(NSNotification *)note{
    
    AFNetworkReachabilityStatus status = [note.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
    switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            NSLog(@"网络类型：未知网络");
            break;
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"网络类型：断网");
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            NSLog(@"网络类型：数据流量");
            [self openSocket];
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"网络类型：WIFI");
            [self openSocket];
            break;
    }
}

-(void)openSocket{
    //如果是同一个url return
    if (self.socket) {
        return;
    }
    if(self.socket.readyState == SR_OPEN){
        return;
    }
    
    self.socket = [[SRWebSocket alloc] initWithURLRequest:
                   [NSURLRequest requestWithURL:[NSURL URLWithString:kOpenLotWebSocket_wss]]];//这里填写你服务器的地址
    
    wss://sg-websocket-server.cptuat.net:8002/websocket/TOPIC_APP
    MBLog(@"请求的websocket地址：%@",self.socket.url.absoluteString);
    self.socket.delegate = self;   //实现这个 SRWebSocketDelegate 协议
    [self.socket open];     //open 就是直接连接了
}

-(void)closeocket{
    if (self.socket){
        [self.socket close];
        self.socket = nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}
- (BOOL)nowIsConnected{
    if(self.socket.readyState == SR_OPEN){
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - socket delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    
    //开启心跳
    [self initHeartBeat];
    if (webSocket == self.socket) {
        MBLog(@"************************** socket 连接成功************************** ");
        if(self.connectSuccess){
            self.connectSuccess();
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    if (webSocket == self.socket) {
        MBLog(@"************************** socket 连接失败************************** ");
        _socket = nil;
        //连接失败就重连
        [self reConnect];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
    if (webSocket == self.socket) {
        MBLog(@"************************** socket连接断开************************** ");
        MBLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",(long)code,reason,wasClean);
        [self closeocket];
        [self reConnect];
    }
    
}

/*该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */

-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    MBLog(@"reply===%@",reply);
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark - 收到的回调
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message  {
    
    if (webSocket == self.socket) {
        MBLog(@"************************** socket收到数据了************************** ");
        MBLog(@"message:%@",message);
        if(!message){
            return;
        }
        if([message isEqualToString:@"连接成功！"]){
            return;
        }
        NSDictionary *dic = [self dictionaryWithJsonString:message];
        //    id aaa = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];
        //    MBLog(@"====+++%@",topic);
        if (basedata.status.integerValue == 1){
            IGKbetModel * tmpModel = [IGKbetModel mj_objectWithKeyValues:basedata.data];
            for(NSString * idNumber in [basedata.data allKeys]){
                //                    MBLog(@"onTopic allKeys:%@",idNumber);
                [self configModelByType:idNumber.integerValue IGKbetModel:tmpModel];
                [[NSNotificationCenter defaultCenter] postNotificationName:idNumber object:self->_model];
            }
        }
        [self handleReceivedMessage:message];
        
    }
}
- (void)handleReceivedMessage:(id)message{
    
    if(self.didReceiveMessage){
        self.didReceiveMessage(message);
    }
    
}


//重连机制
- (void)reConnect
{
    
    [self closeocket];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64*2) {
        //您的网络状况不是很好，请检查网络后重试
        return;
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket = nil;
        [self openSocket];
        MBLog(@"重连");
    });
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
    
}

//初始化心跳
- (void)initHeartBeat
{
    dispatch_main_async_safe(^{
        [self destoryHeartBeat];
        
        heartBeat = [NSTimer timerWithTimeInterval:28 target:self selector:@selector(ping) userInfo:nil repeats:YES];
        //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
        [[NSRunLoop currentRunLoop]addTimer:heartBeat forMode:NSRunLoopCommonModes];
    })
}


//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (heartBeat) {
            if ([heartBeat respondsToSelector:@selector(isValid)]){
                if ([heartBeat isValid]){
                    [heartBeat invalidate];
                    heartBeat = nil;
                }
            }
        }
    })
}

//pingPong
- (void)ping{
    if (self.socket.readyState == SR_OPEN) {
        [self.socket sendPing:nil];
    }
}

- (void)sendData:(NSDictionary *)paramDic withRequestURI:(NSString *)requestURI{
    //这一块的数据格式由你们跟你们家服务器哥哥商定
    NSDictionary *configDic;
    
    //requestURI = [NSString stringWithFormat:@"/api/%@",requestURI];
    
    //    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    NSDictionary *configDic = @{
    //                                @"usersign"  :appDelegate.appToken,
    //                                @"command"   :@"response",
    //                                @"requestURI":requestURI,                                @"headers"   :@{@"Version":AboutVersion,
    //                                                @"Token":appDelegate.appToken,
    //                                                @"LoginName":appDelegate.appLoginName},
    //                                @"params"    :paramDic
    //                                };
    MBLog(@"socketSendData--configDic --------------- %@",configDic);
    NSError *error;
    NSString *data;
    //(NSJSONWritingOptions) (paramDic ? NSJSONWritingPrettyPrinted : 0)
    //采用这个格式的json数据会比较好看，但是不是服务器需要的
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:configDic
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        MBLog(@" error: %@", error.localizedDescription);
        return;
    } else {
        data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //这是为了取代requestURI里的"\"
        //data = [data stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }
    @weakify(self);
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        @strongify(self)
        if (self.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (self.socket.readyState == SR_OPEN) {
                [self.socket send:data];    // 发送数据
                
            } else if (self.socket.readyState == SR_CONNECTING) {
                
                [self reConnect];
                
            } else if (self.socket.readyState == SR_CLOSING || self.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                MBLog(@"重连");
                
                [self reConnect];
            }
        } else {
            // 这里要看你的具体业务需求；不过一般情况下，调用发送数据还是希望能把数据发送出去，所以可以再次打开链接；不用担心这里会有多个socketopen；因为如果当前有socket存在，会停止创建哒
            [self openSocket];
        }
    });
}

-(SRReadyState)socketReadyState{
    return self.socket.readyState;
}

@end
