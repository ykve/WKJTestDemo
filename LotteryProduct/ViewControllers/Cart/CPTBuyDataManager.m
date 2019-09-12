//
//  CPTBuyDataManager.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyDataManager.h"
#import "WebTools.h"
#import "SSZipArchive.h"
#import "DownloadOdds.h"
#define BUYDATANAME @"buyData10.plist"
#define ODDSNAME @"odds10.plist"

@interface CPTBuyDataManager(){
    NSMutableArray *_cartArray;
    NSMutableArray<CPTBuyBallModel *> *_tmpCartArray;
    NSDictionary *_dataDic;
    NSArray *_oddsArray;
    NSArray *mutexArray;
}
@end

@implementation CPTBuyDataManager
static CPTBuyDataManager *manager;
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
        _tmpCartArray = [NSMutableArray array];
        _cartArray = [NSMutableArray array];
        [self unzipBuyData];
        mutexArray = @[@"大&小",@"单&双",@"大单&大双",@"小单&小双",@"极大&极小"];
        
    }
    return self;
}

- (void)downloadOdds{
//    @weakify(self)
//    [WebTools postWithURL:@"/app/queryLotteryVersionZIP.json" params:nil success:^(BaseData *data) {
//        if (![data.status isEqualToString:@"1"]) {
//            return;
//        }
//        @strongify(self)
//        DownloadOdds *odds = [DownloadOdds mj_objectWithKeyValues:data.data];
//        MBLog(@"odds:%@",odds.downURL);
//
//        [NSThread detachNewThreadSelector:@selector(downloadFileWithUrl:) toTarget:self withObject:odds.downURL];
//
//    } failure:^(NSError *error) {
//
//    } showHUD:NO];
    [NSThread detachNewThreadSelector:@selector(rundownloadOdds) toTarget:self withObject:nil];

    
    
}

- (void)downloadFileWithUrl:(NSString *)urlStr{
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSString *filePath = [path stringByAppendingPathComponent:@"tmpOdds.zip"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    CGFloat size = [data length]/(1024.0);
    if(size>20.0){
        BOOL isSuccess = [data writeToFile:filePath atomically:YES];
        if(isSuccess){
            [self unzipOddsFile];
        }
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        MBLog(@"odds下载完成 in %f s", linkTime);
    }

  
}

- (void)rundownloadOdds{

    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    NSURLSession *session=[NSURLSession sharedSession];
    NSString * url2 = @"/app/queryLotteryVersionZIP.json";
    NSString*strUrl = [NSString stringWithFormat:@"%@%@",kServerUrl,url2];
    if ([Person person].uid && [Person person].token) {
        strUrl = [NSString stringWithFormat:@"%@?uid=%@&token=%@",strUrl,[Person person].uid,[Person person].token];
    }
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    request.timeoutInterval = 15.;
    NSDictionary *headers = @{@"content-type": @"text/json"};
    [request setAllHTTPHeaderFields:headers];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (!response) {
            return ;
        }
        if (!data) {
            return ;
        }
        //8.解析数据
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dic = [WebTools changeType:dic];
        BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];
        if (basedata.status.integerValue == 1){
            DownloadOdds *odds = [DownloadOdds mj_objectWithKeyValues:basedata.data];
            MBLog(@"odds:%@",odds.downURL);
            
            [self downloadFileWithUrl:odds.downURL];
        }
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);

    }];
    
    //7.执行任务
    [dataTask resume];
}

- (void)unzipBuyData{
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [docPath stringByAppendingPathComponent:BUYDATANAME];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        NSString *unzipPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        [SSZipArchive unzipFileAtPath:[[NSBundle mainBundle] pathForResource:@"buyData" ofType:@"zip"] toDestination:unzipPath];
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        MBLog(@"解压完成 in %f s", linkTime);
    }else{
        MBLog(@"无需解压");
    }
}

- (void)unzipOddsFile {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSString *unzipPath = [path stringByAppendingPathComponent:@"tmpOdds.zip"];
    
    NSString *unzipToPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    [SSZipArchive unzipFileAtPath:unzipPath toDestination:unzipToPath];
    
    NSString *plistPath = [path stringByAppendingPathComponent:@"lottery.txt"];
    //gbk编码 如果txt文件为utf-8的则使用NSUTF8StringEncoding
    //    NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(NSUTF8StringEncoding);
    //定义字符串接收从txt文件读取的内容
    NSString *str = [[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    //将字符串转为nsdata类型
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //将nsdata类型转为NSDictionary
    NSDictionary *pDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:ODDSNAME];
    if([pDic writeToFile:filename atomically:YES]){
        MBLog(@"writeToFile");
        @weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [self reloadData];
        });
    }


}

- (void)reloadData{
    if(_oddsArray){
        _oddsArray = nil;
    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:ODDSNAME];
    _oddsArray = [NSArray arrayWithContentsOfFile:filePath];

}

- (void)loadData{
    if(!_dataDic){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [docPath stringByAppendingPathComponent:BUYDATANAME];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"buyData" ofType:@"plist"];
        _dataDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    if(!_oddsArray){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [docPath stringByAppendingPathComponent:ODDSNAME];
        _oddsArray = [NSArray arrayWithContentsOfFile:filePath];
        if(!_oddsArray){
            NSString *path = [[NSBundle mainBundle] pathForResource:@"odds3" ofType:@"plist"];
            _oddsArray = [NSArray arrayWithContentsOfFile:path];
        }
    }
}

- (NSDictionary *)configOtherDataByTicketType:(CPTBuyTicketType)type{
    if(!_oddsArray){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [docPath stringByAppendingPathComponent:ODDSNAME];
        _oddsArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    NSNumber *idNumber = @(type);
    NSDictionary * tmpDic;
    for(NSDictionary *dic in _oddsArray){
        for(__strong NSDictionary *lotterysDic in dic[@"lotterys"]){
            if([lotterysDic[@"lotteryId"] integerValue] == idNumber.integerValue){
                tmpDic=[NSDictionary dictionaryWithDictionary:lotterysDic[@"plays"][0]] ;
                break;
            }
        }
    }
    return tmpDic;
}

- (NSMutableArray *)configDataByTicketType:(CPTBuyTicketType)type{
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    if(!_dataDic){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [docPath stringByAppendingPathComponent:BUYDATANAME];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"buyData" ofType:@"plist"];
        _dataDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    if(!_oddsArray){
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [docPath stringByAppendingPathComponent:ODDSNAME];
        _oddsArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    NSMutableArray * playTypes = [NSMutableArray array];
    switch (type) {
        case CPTBuyTicketType_LiuHeCai:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"six"]];
        }
            break;
        case CPTBuyTicketType_OneLiuHeCai:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"1six"]];
        }
            break;
        case CPTBuyTicketType_FiveLiuHeCai:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"5six"]];
        }
            break;
        case CPTBuyTicketType_ShiShiLiuHeCai:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"sssix"]];
        }
            break;

        case CPTBuyTicketType_PK10:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"pk10"]];
        }
            break;
        case CPTBuyTicketType_TenPK10:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"10pk10"]];
        }
            break;
        case CPTBuyTicketType_FivePK10:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"5pk10"]];
        }
            break;
        case CPTBuyTicketType_JiShuPK10:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"jspk10"]];
        }
            break;
        case CPTBuyTicketType_AoZhouF1:
        {
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"aozhouF1"]];
        }
            break;

        case CPTBuyTicketType_PCDD:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"pcdd"]];
        }
            break;
        case CPTBuyTicketType_SSC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"ssc"]];
        }
            break;
        case CPTBuyTicketType_XJSSC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"xjssc"]];
        }
            break;
        case CPTBuyTicketType_TJSSC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"tjssc"]];
        }
            break;
        case CPTBuyTicketType_TenSSC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"10ssc"]];
        }
            break;
        case CPTBuyTicketType_FiveSSC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"5ssc"]];
        }
            break;
        case CPTBuyTicketType_JiShuSSC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"jsssc"]];
        }
            break;
        case CPTBuyTicketType_FFC:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"ffc"]];
        }
            break;
        case CPTBuyTicketType_XYFT:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"xyft"]];
        }
            break;
        case CPTBuyTicketType_PaiLie35:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"pl3/5"]];
        }
            break;
        case CPTBuyTicketType_3D:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"3d"]];
        }
            break;
        case CPTBuyTicketType_AoZhouShiShiCai:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"aozhoussc"]];
        } break;
        case CPTBuyTicketType_AoZhouACT:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"aozhoussc"]];
        } break;

        case CPTBuyTicketType_HaiNanQiXingCai:{
            _sixData = [CPTSixModel mj_objectWithKeyValues:_dataDic[@"hnqxc"]];
        }
            break;
        default:
            break;
    }
//赔率匹配
    for(CPTSixPlayTypeModel * playTypeModel in _sixData.playTypes){
        for(NSDictionary *dic in _oddsArray){
            for(NSDictionary *lotterysDic in dic[@"lotterys"]){
                for(NSDictionary *playsDic in lotterysDic[@"plays"]){
                    NSArray *playChildrenArray = playsDic[@"playChildren"];
                    if(playChildrenArray.count >0){
                        for(NSDictionary *childrenDic in playChildrenArray){
                            if([childrenDic[@"playTagId"] integerValue] == [playTypeModel.ID integerValue]){
                                playTypeModel.categoryId = childrenDic[@"categoryId"];
                                    playTypeModel.example = childrenDic[@"setting"][@"example"];
                                    playTypeModel.exampleNum = childrenDic[@"setting"][@"exampleNum"];
                                    playTypeModel.playRemark = childrenDic[@"setting"][@"playRemark"];
                                    playTypeModel.playRemarkSx = childrenDic[@"setting"][@"playRemarkSx"];
                                    NSInteger matchtype = [childrenDic[@"setting"][@"matchtype"] integerValue];
                                    if(matchtype == 1){
                                        for(NSDictionary *oddsList in childrenDic[@"oddsList"]){
                                            for(CPTSixsubPlayTypeModel * subPlayTypeModel in playTypeModel.subTypes){
                                                for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                                    ballModel.subTitle = oddsList[@"odds"];
                                                    ballModel.settingId = [oddsList[@"settingId"] integerValue];
                                                }
                                            }
                                        }
                                    }else if (matchtype == 2){
                                        for(NSDictionary *oddsList in childrenDic[@"oddsList"]){
                                            for(CPTSixsubPlayTypeModel * subPlayTypeModel in playTypeModel.subTypes){
                                                for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                                    if([ballModel.title isEqualToString:oddsList[@"name"]]){
                                                        ballModel.subTitle = oddsList[@"odds"];
                                                        ballModel.settingId = [oddsList[@"settingId"] integerValue];
                                                    }
                                                }
                                            }
                                        }
                                    }else if (matchtype == 3){
                                        for(NSDictionary *oddsList in childrenDic[@"oddsList"]){
                                            for(CPTSixsubPlayTypeModel * subPlayTypeModel in playTypeModel.subTypes){
                                                for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                                    if([ballModel.title isEqualToString:oddsList[@"name"]]){
                                                        ballModel.subTitle = oddsList[@"odds"];
                                                        ballModel.settingId = [oddsList[@"settingId"] integerValue];
                                                    }
                                                }
                                            }
                                        }
                                    }
                                
                            }
                        }
                    }else{
                        //没有子玩法
                        if([playsDic[@"playTagId"] integerValue] == [playTypeModel.ID integerValue]){
                                playTypeModel.categoryId = playsDic[@"categoryId"];
                                playTypeModel.example = playsDic[@"setting"][@"example"];
                                playTypeModel.exampleNum = playsDic[@"setting"][@"exampleNum"];
                                playTypeModel.playRemark = playsDic[@"setting"][@"playRemark"];
                                playTypeModel.playRemarkSx = playsDic[@"setting"][@"playRemarkSx"];
                                NSInteger matchtype = [playsDic[@"setting"][@"matchtype"] integerValue];
                                if(matchtype == 1){
                                    for(NSDictionary *oddsList in playsDic[@"oddsList"]){
                                        for(CPTSixsubPlayTypeModel * subPlayTypeModel in playTypeModel.subTypes){
                                            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                                ballModel.subTitle = oddsList[@"odds"];
                                                ballModel.settingId = [oddsList[@"settingId"] integerValue];
                                            }
                                        }
                                    }
                                }else if (matchtype == 2){
                                    for(NSDictionary *oddsList in playsDic[@"oddsList"]){
                                        for(CPTSixsubPlayTypeModel * subPlayTypeModel in playTypeModel.subTypes){
                                            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                                if([ballModel.title isEqualToString:oddsList[@"name"]]){
                                                    ballModel.subTitle = oddsList[@"odds"];
                                                    ballModel.settingId = [oddsList[@"settingId"] integerValue];
                                                }
                                            }
                                        }
                                    }
                                }else if (matchtype == 3){
                                    for(NSDictionary *oddsList in playsDic[@"oddsList"]){
                                        for(CPTSixsubPlayTypeModel * subPlayTypeModel in playTypeModel.subTypes){
                                            for(CPTBuyBallModel * ballModel in subPlayTypeModel.balls){
                                                if([ballModel.title isEqualToString:oddsList[@"name"]]){
                                                    ballModel.subTitle = oddsList[@"odds"];
                                                    ballModel.settingId = [oddsList[@"settingId"] integerValue];
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                    }
            }
        }
        }
    }
    for( CPTSixPlayTypeModel * playTypeModel in self.sixData.playTypes){
        [playTypes addObject:playTypeModel];
    }
            CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    
            MBLog(@"赔率匹配 in %f s", linkTime);
    return playTypes;
}

- (void)configType:(CPTBuyTicketType)type{
    self.type = type;
}

- (NSString *)changeTypeToString:(CPTBuyTicketType)type{
    switch (type) {
        case CPTBuyTicketType_SSC:
            return @"重庆时时彩";
            break;
        case CPTBuyTicketType_XJSSC:
            return @"新疆时时彩";
            break;
        case CPTBuyTicketType_TJSSC:
            return @"天津时时彩";
            break;
        case CPTBuyTicketType_TenSSC:
            return @"10分时时彩";
            break;
        case CPTBuyTicketType_FiveSSC:
            return @"5分时时彩";
            break;
        case CPTBuyTicketType_JiShuSSC:
            return @"德州时时彩";
            break;
        case CPTBuyTicketType_LiuHeCai:
            return @"六合彩";
            break;
        case CPTBuyTicketType_OneLiuHeCai:
            return @"德州六合彩";
            break;
        case CPTBuyTicketType_FiveLiuHeCai:
            return @"5分六合彩";
            break;
        case CPTBuyTicketType_ShiShiLiuHeCai:
            return @"时时六合彩";
            break;
        case CPTBuyTicketType_PK10:
            return @"北京PK10";
            break;
        case CPTBuyTicketType_TenPK10:
            return @"10分PK10";
            break;
        case CPTBuyTicketType_FivePK10:
            return @"5分PK10";
            break;
        case CPTBuyTicketType_JiShuPK10:
            return @"德州PK10";
            break;
        case CPTBuyTicketType_AoZhouF1:
            return @"澳洲F1赛车";
            break;
            
        case CPTBuyTicketType_XYFT:
            return @"幸运飞艇";
            break;
        case CPTBuyTicketType_PCDD:
            return @"PC蛋蛋";
            break;
        case CPTBuyTicketType_FFC:
            return @"比特币分分彩";
            break;
        case CPTBuyTicketType_DaLetou:
            return @"大乐透";
            break;
        case CPTBuyTicketType_PaiLie35:
            return @"排列3/5";
            break;
        case CPTBuyTicketType_HaiNanQiXingCai:
            return @"海南七星彩";
            break;
        case CPTBuyTicketType_Shuangseqiu:
            return @"双色球";
            break;
        case CPTBuyTicketType_3D:
            return @"福彩3D";
            break;
        case CPTBuyTicketType_QiLecai:
            return @"七乐彩";
            break;
        case CPTBuyTicketType_NiuNiu_KuaiLe:
            return @"快乐牛牛";
            break;
        case CPTBuyTicketType_NiuNiu_AoZhou:
            return @"F1赛车牛牛";
            break;
        case CPTBuyTicketType_NiuNiu_JiShu:
            return @"德州牛牛";
            break;
        case CPTBuyTicketType_FantanSSC:
            return @"德州时时彩番摊";
            break;
        case CPTBuyTicketType_FantanXYFT:
            return @"幸运飞艇番摊";
            break;
        case CPTBuyTicketType_FantanPK10:
            return @"德州PK10番摊";
            break;
        case CPTBuyTicketType_AoZhouACT:
            return @"澳洲ACT";
            break;
        case CPTBuyTicketType_AoZhouShiShiCai:
            return @"澳洲时时彩";
            break;
            
        default:
            break;
    }
    return @" ";
}

- (CPTBuyTicketType )changeTypeStringToStrong:(NSString *)typeString{
    CPTBuyTicketType type;
    if([typeString isEqualToString:@"CPTBuyTicketType_LiuHeCai"]){
        type = CPTBuyTicketType_LiuHeCai;

    }else if([typeString isEqualToString:@"CPTBuyTicketType_OneLiuHeCai"]){
        type = CPTBuyTicketType_OneLiuHeCai;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FiveLiuHeCai"]){
        type = CPTBuyTicketType_FiveLiuHeCai;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_ShiShiLiuHeCai"]){
        type = CPTBuyTicketType_ShiShiLiuHeCai;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_PK10"]){
        type = CPTBuyTicketType_PK10;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_TenPK10"]){
        type = CPTBuyTicketType_TenPK10;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FivePK10"]){
        type = CPTBuyTicketType_FivePK10;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_JiShuPK10"]){
        type = CPTBuyTicketType_JiShuPK10;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_AoZhouF1"]){
        type = CPTBuyTicketType_AoZhouF1;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_SSC"]){
        type = CPTBuyTicketType_SSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_XJSSC"]){
        type = CPTBuyTicketType_XJSSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_TJSSC"]){
        type = CPTBuyTicketType_TJSSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_TenSSC"]){
        type = CPTBuyTicketType_TenSSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FiveSSC"]){
        type = CPTBuyTicketType_FiveSSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_JiShuSSC"]){
        type = CPTBuyTicketType_JiShuSSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_XYFT"]){
        type = CPTBuyTicketType_XYFT;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_PCDD"]){
        type = CPTBuyTicketType_PCDD;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FFC"]){
        type = CPTBuyTicketType_FFC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_DaLetou"]){
        type = CPTBuyTicketType_DaLetou;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_HaiNanQiXingCai"]){
        type = CPTBuyTicketType_HaiNanQiXingCai;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_Shuangseqiu"]){
        type = CPTBuyTicketType_Shuangseqiu;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_3D"]){
        type = CPTBuyTicketType_3D;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_QiLecai"]){
        type = CPTBuyTicketType_QiLecai;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_PaiLie35"]){
        type = CPTBuyTicketType_PaiLie35;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_NiuNiu_AoZhou"]){
        type = CPTBuyTicketType_NiuNiu_AoZhou;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_NiuNiu_JiShu"]){
        type = CPTBuyTicketType_NiuNiu_JiShu;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_NiuNiu_KuaiLe"]){
        type = CPTBuyTicketType_NiuNiu_KuaiLe;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FantanPK10"]){
        type = CPTBuyTicketType_FantanPK10;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FantanXYFT"]){
        type = CPTBuyTicketType_FantanXYFT;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_FantanSSC"]){
        type = CPTBuyTicketType_FantanSSC;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_AoZhouACT"]){
        type = CPTBuyTicketType_AoZhouACT;
    }
    else if([typeString isEqualToString:@"CPTBuyTicketType_AoZhouShiShiCai"]){
        type = CPTBuyTicketType_AoZhouShiShiCai;
    }

    return type;
}

- (NSString *)changeTypeToTypeString:(CPTBuyTicketType)type{
    switch (type) {
        case CPTBuyTicketType_SSC:
            return @"CPTBuyTicketType_SSC";
            break;
        case CPTBuyTicketType_XJSSC:
            return @"CPTBuyTicketType_XJSSC";
            break;
        case CPTBuyTicketType_TJSSC:
            return @"CPTBuyTicketType_TJSSC";
            break;
        case CPTBuyTicketType_TenSSC:
            return @"CPTBuyTicketType_TenSSC";
            break;
        case CPTBuyTicketType_FiveSSC:
            return @"CPTBuyTicketType_FiveSSC";
            break;
        case CPTBuyTicketType_JiShuSSC:
            return @"CPTBuyTicketType_JiShuSSC";
            break;
        case CPTBuyTicketType_LiuHeCai:
            return @"CPTBuyTicketType_LiuHeCai";
            break;
        case CPTBuyTicketType_OneLiuHeCai:
            return @"CPTBuyTicketType_OneLiuHeCai";
            break;
        case CPTBuyTicketType_FiveLiuHeCai:
            return @"CPTBuyTicketType_FiveLiuHeCai";
            break;
        case CPTBuyTicketType_ShiShiLiuHeCai:
            return @"CPTBuyTicketType_ShiShiLiuHeCai";
            break;
        case CPTBuyTicketType_PK10:
            return @"CPTBuyTicketType_PK10";
            break;
        case CPTBuyTicketType_TenPK10:
            return @"CPTBuyTicketType_TenPK10";
            break;
        case CPTBuyTicketType_FivePK10:
            return @"CPTBuyTicketType_FivePK10";
            break;
        case CPTBuyTicketType_JiShuPK10:
            return @"CPTBuyTicketType_JiShuPK10";
            break;
        case CPTBuyTicketType_AoZhouF1:
            return @"CPTBuyTicketType_AoZhouF1";
            break;
        case CPTBuyTicketType_XYFT:
            return @"CPTBuyTicketType_XYFT";
            break;
        case CPTBuyTicketType_PCDD:
            return @"CPTBuyTicketType_PCDD";
            break;
        case CPTBuyTicketType_FFC:
            return @"CPTBuyTicketType_FFC";
            break;
        case CPTBuyTicketType_DaLetou:
            return @"CPTBuyTicketType_DaLetou";
            break;
        case CPTBuyTicketType_PaiLie35:
            return @"CPTBuyTicketType_PaiLie35";
            break;
        case CPTBuyTicketType_HaiNanQiXingCai:
            return @"CPTBuyTicketType_HaiNanQiXingCai";
            break;
        case CPTBuyTicketType_Shuangseqiu:
            return @"CPTBuyTicketType_Shuangseqiu";
            break;
        case CPTBuyTicketType_3D:
            return @"CPTBuyTicketType_3D";
            break;
        case CPTBuyTicketType_QiLecai:
            return @"CPTBuyTicketType_QiLecai";
            break;
        case CPTBuyTicketType_NiuNiu_KuaiLe:
            return @"CPTBuyTicketType_NiuNiu_KuaiLe";
            break;
        case CPTBuyTicketType_NiuNiu_AoZhou:
            return @"CPTBuyTicketType_NiuNiu_AoZhou";
            break;
        case CPTBuyTicketType_NiuNiu_JiShu:
            return @"CPTBuyTicketType_NiuNiu_JiShu";
            break;
        case CPTBuyTicketType_FantanSSC:
            return @"CPTBuyTicketType_FantanSSC";
            break;
        case CPTBuyTicketType_FantanXYFT:
            return @"CPTBuyTicketType_FantanXYFT";
            break;
        case CPTBuyTicketType_FantanPK10:
            return @"CPTBuyTicketType_FantanPK10";
            break;
        case CPTBuyTicketType_AoZhouACT:
            return @"CPTBuyTicketType_AoZhouACT";
            break;
        case CPTBuyTicketType_AoZhouShiShiCai:
            return @"CPTBuyTicketType_AoZhouShiShiCai";
            break;

        default:
            break;
    }
    return @" ";
}

- (NSArray<NSNumber *> *)allLotteryIds{
    return @[@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_AoZhouF1),@(CPTBuyTicketType_JiShuSSC),@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_XYFT),@(CPTBuyTicketType_OneLiuHeCai),@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_FantanPK10),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_TenSSC),@(CPTBuyTicketType_FiveSSC),@(CPTBuyTicketType_FiveLiuHeCai),@(CPTBuyTicketType_ShiShiLiuHeCai),@(CPTBuyTicketType_TenPK10),@(CPTBuyTicketType_FivePK10),@(CPTBuyTicketType_JiShuPK10),@(CPTBuyTicketType_PCDD),@(CPTBuyTicketType_FFC),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_PaiLie35),@(CPTBuyTicketType_HaiNanQiXingCai),@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_3D),@(CPTBuyTicketType_QiLecai),@(CPTBuyTicketType_NiuNiu_AoZhou),@(CPTBuyTicketType_NiuNiu_JiShu),@(CPTBuyTicketType_FantanXYFT),@(CPTBuyTicketType_FantanSSC),@(CPTBuyTicketType_AoZhouACT),@(CPTBuyTicketType_AoZhouShiShiCai)];
}


- (NSMutableDictionary *)checkTmpCartArrayByType:(NSString *)type superPlayKey:(NSString *)superPlayKey eachMoney:(NSInteger)money{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
/*
 key
    totleMoney 投注金额
    maxWin 投注金额
    totleAvailable 有效投注
*/
    
    NSMutableArray * tmpA = [NSMutableArray array];
    NSInteger totleMoney = 0;
    CGFloat maxWin = 0.00;
    NSInteger totleAvailable = 0;
    NSInteger limitCount = 1;
    NSInteger leftOrRight = 1;
    for (CPTBuyBallModel * model in _tmpCartArray) {
        if([model.superKey isEqualToString:type]){
            [tmpA addObject:model];
        }
    }
    if([superPlayKey isEqualToString:@"特码"]  ){
        totleAvailable = _tmpCartArray.count;
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 1;
    }
    else if([superPlayKey isEqualToString:@"2D"] ){
         NSInteger index3 = 0;
         NSInteger index2 = 0;
         NSInteger index1 = 0;
         for (CPTBuyBallModel * model in _tmpCartArray) {
             if([model.superKey isEqualToString:@"百位"]){
                 index3 = index3+1;
             }
             else if([model.superKey isEqualToString:@"十位"]){
                 index2 = index2+1;
             }
             else if([model.superKey isEqualToString:@"个位"]){
                 index1 = index1+1;
             }
             maxWin = [model.subTitle floatValue] * money;
         }
         //        maxWin = 1040 * money/2;
         totleAvailable = index3 * index2 + index3 * index1 + index2 * index1;
         totleMoney = totleAvailable * money;
         limitCount = 2;
         leftOrRight = 1;
    }
     else  if([superPlayKey isEqualToString:@"组选6"]){
         limitCount = 3;
         leftOrRight = 0;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            maxWin = [model.subTitle floatValue] * money;
        }
           totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
           totleMoney = totleAvailable * money;
       }
       else if([superPlayKey isEqualToString:@"组选3/6"] || [superPlayKey isEqualToString:@"组选3"]){
           NSInteger index2 = 0;
           NSInteger index1 = 0;
           for (CPTBuyBallModel * model in _tmpCartArray) {
               if([model.superKey isEqualToString:@"二重号"]){
                   index2 = index2+1;
               }
               else if([model.superKey isEqualToString:@"单号"]){
                   index1 = index1+1;
               }
               maxWin = [model.subTitle floatValue] * money;
           }
           //        maxWin = 346.00 * money/2;
           totleAvailable =  index2 * index1;
           totleMoney = totleAvailable * money;
           limitCount = 2;
           leftOrRight = 0;
       }
       else if([superPlayKey isEqualToString:@"直选复式"] && self.type == CPTBuyTicketType_HaiNanQiXingCai){
           NSInteger index4 = 0;
           NSInteger index3 = 0;
           NSInteger index2 = 0;
           NSInteger index1 = 0;
           for (CPTBuyBallModel * model in _tmpCartArray) {
                if([model.superKey isEqualToString:@"千位"]){
                   index4 = index4+1;
               }else if([model.superKey isEqualToString:@"百位"]){
                   index3 = index3+1;
               }else if([model.superKey isEqualToString:@"十位"]){
                   index2 = index2+1;
               }else if([model.superKey isEqualToString:@"个位"]){
                   index1 = index1+1;
               }
               maxWin = [model.subTitle floatValue] * money;
           }

           totleAvailable = index4 * index3 * index2 * index1;
           totleMoney = totleAvailable * money;
           limitCount = 4;
       }
       else if([superPlayKey isEqualToString:@"直选复式"] && self.type == CPTBuyTicketType_3D){
           NSInteger index3 = 0;
           NSInteger index2 = 0;
           NSInteger index1 = 0;
           for (CPTBuyBallModel * model in _tmpCartArray) {
               if([model.superKey isEqualToString:@"百位"]){
                   index3 = index3+1;
               }else if([model.superKey isEqualToString:@"十位"]){
                   index2 = index2+1;
               }else if([model.superKey isEqualToString:@"个位"]){
                   index1 = index1+1;
               }
               maxWin = [model.subTitle floatValue] * money;
           }
           
           totleAvailable =  index3 * index2 * index1;
           totleMoney = totleAvailable * money;
           limitCount = 3;
       }
       else if([superPlayKey isEqualToString:@"不定位二"] && self.type == CPTBuyTicketType_HaiNanQiXingCai){
           for (CPTBuyBallModel * model in _tmpCartArray) {
               maxWin = [model.subTitle floatValue] * money;
           }
           totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
           totleMoney = totleAvailable * money;
           limitCount = 2;
       }
       else if([superPlayKey isEqualToString:@"不定位三"] && self.type == CPTBuyTicketType_HaiNanQiXingCai){
           for (CPTBuyBallModel * model in _tmpCartArray) {
               maxWin = [model.subTitle floatValue] * money;
           }
           totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
           totleMoney = totleAvailable * money;
           limitCount = 3;
       }
    else if([superPlayKey isEqualToString:@"P5直选"]){
           NSInteger index5 = 0;
           NSInteger index4 = 0;
           NSInteger index3 = 0;
           NSInteger index2 = 0;
           NSInteger index1 = 0;
           for (CPTBuyBallModel * model in _tmpCartArray) {
               if([model.superKey isEqualToString:@"万位"]){
                   index5 = index5+1;
               }else if([model.superKey isEqualToString:@"千位"]){
                   index4 = index4+1;
               }else if([model.superKey isEqualToString:@"百位"]){
                   index3 = index3+1;
               }else if([model.superKey isEqualToString:@"十位"]){
                   index2 = index2+1;
               }else if([model.superKey isEqualToString:@"个位"]){
                   index1 = index1+1;
               }
               maxWin = [model.subTitle floatValue] * money;
           }
//           maxWin = 100000 * money/2;
           totleAvailable = index5 * index4 * index3 * index2 * index1;
           totleMoney = totleAvailable * money;
        limitCount = 5;
       }
    else if([superPlayKey isEqualToString:@"1-5名"]){
        NSInteger index5 = 0;
        NSInteger index4 = 0;
        NSInteger index3 = 0;
        NSInteger index2 = 0;
        NSInteger index1 = 0;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            if([model.superKey isEqualToString:@"冠军"]){
                index5 = 1;
            }else if([model.superKey isEqualToString:@"亚军"]){
                index4 = 1;
            }else if([model.superKey isEqualToString:@"第三名"]){
                index3 = 1;
            }else if([model.superKey isEqualToString:@"第四名"]){
                index2 = 1;
            }else if([model.superKey isEqualToString:@"第五名"]){
                index1 = 1;
            }
            maxWin = [model.subTitle floatValue] * money * (index1 + index2+ index3+ index4+ index5);
        }
        totleAvailable = _tmpCartArray.count;
        totleMoney = totleAvailable * money;
        limitCount = 1;
    }
    else if([superPlayKey isEqualToString:@"6-10名"]){
        NSInteger index5 = 0;
        NSInteger index4 = 0;
        NSInteger index3 = 0;
        NSInteger index2 = 0;
        NSInteger index1 = 0;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            if([model.superKey isEqualToString:@"第六名"]){
                index5 = 1;
            }else if([model.superKey isEqualToString:@"第七名"]){
                index4 = 1;
            }else if([model.superKey isEqualToString:@"第八名"]){
                index3 = 1;
            }else if([model.superKey isEqualToString:@"第九名"]){
                index2 = 1;
            }else if([model.superKey isEqualToString:@"第十名"]){
                index1 = 1;
            }
            maxWin = [model.subTitle floatValue] * money * (index1 + index2+ index3+ index4+ index5);
        }
        totleAvailable = _tmpCartArray.count;
        totleMoney = totleAvailable * money;
        limitCount = 1;
    }

    else if([superPlayKey isEqualToString:@"P3直选"]||[superPlayKey isEqualToString:@"直选复式"]){
        NSInteger index3 = 0;
        NSInteger index2 = 0;
        NSInteger index1 = 0;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            if([model.superKey isEqualToString:@"万位"]){
                index3 = index3+1;
            }
            else if([model.superKey isEqualToString:@"千位"]){
                index2 = index2+1;
            }
            else if([model.superKey isEqualToString:@"百位"]){
                index1 = index1+1;
            }
            maxWin = [model.subTitle floatValue] * money;
        }
//        maxWin = 1040 * money/2;
        totleAvailable = index3 * index2 * index1;
        totleMoney = totleAvailable * money;
        limitCount = 3;
    }else if([superPlayKey isEqualToString:@"特码包三"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 3;
    }else if([superPlayKey isEqualToString:@"三全中"]||[superPlayKey isEqualToString:@"连码"]||[superPlayKey isEqualToString:@"三中二"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 3;
        leftOrRight = 0;
    }else if([superPlayKey isEqualToString:@"二全中"]||[superPlayKey isEqualToString:@"二中特"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }else if([superPlayKey isEqualToString:@"五不中"]||[superPlayKey isEqualToString:@"不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:5];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 5;
    }
    else if([superPlayKey isEqualToString:@"六不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:6];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 6;
    }
    else if([superPlayKey isEqualToString:@"七不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:7];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 7;
    }
    else if([superPlayKey isEqualToString:@"八不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:8];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 8;
    }
    else if([superPlayKey isEqualToString:@"九不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:9];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 9;
    }
    else if([superPlayKey isEqualToString:@"十不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:10];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 10;
    }
    else if([superPlayKey isEqualToString:@"六肖连中"]||[superPlayKey isEqualToString:@"六肖"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:6];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 6;
    }
    else if([superPlayKey isEqualToString:@"六肖连不中"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:6];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 6;
    }
    else if([superPlayKey isEqualToString:@"二连肖(中)"]||[superPlayKey isEqualToString:@"连肖"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }
    else if([superPlayKey isEqualToString:@"二连肖(不中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }
    else if([superPlayKey isEqualToString:@"三连肖(中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 3;
    }
    else if([superPlayKey isEqualToString:@"三连肖(不中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 3;
    }
    else if([superPlayKey isEqualToString:@"四连肖(中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:4];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 4;
    }
    else if([superPlayKey isEqualToString:@"四连肖(不中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:4];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 4;
    }
    else if([superPlayKey isEqualToString:@"二连尾(中)"]||[superPlayKey isEqualToString:@"连尾"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }
    else if([superPlayKey isEqualToString:@"二连尾(不中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }
    else if([superPlayKey isEqualToString:@"三连尾(中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 3;
    }
    else if([superPlayKey isEqualToString:@"三连尾(不中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:3];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 3;
    }
    else if([superPlayKey isEqualToString:@"四连尾(中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:4];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 4;
    }
    else if([superPlayKey isEqualToString:@"四连尾(不中)"]){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:4];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 4;
    }    else if([type isEqualToString:@"两不同号"] ){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }else if([type isEqualToString:@"特串"] ){
        totleAvailable = [self okCountRecursiveWithTotleBalls:_tmpCartArray.count limitCount:2];
        CGFloat subTitle = 0.00;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            subTitle = MAX(subTitle, [model.subTitle floatValue]);
        }
        maxWin = subTitle * money;
        totleMoney = totleAvailable * money;
        limitCount = 2;
    }
    else{
        totleAvailable = _tmpCartArray.count;
        totleMoney = _tmpCartArray.count * money;
        for (CPTBuyBallModel * model in _tmpCartArray) {
            maxWin = maxWin + [model.subTitle floatValue] * money;
        }
        limitCount = 1;
    }
    if((limitCount ==1 && self.type == CPTBuyTicketType_LiuHeCai) || (limitCount ==1 && self.type == CPTBuyTicketType_ShiShiLiuHeCai)|| (limitCount ==1 && self.type == CPTBuyTicketType_OneLiuHeCai)|| (limitCount ==1 && self.type == CPTBuyTicketType_FiveLiuHeCai) ){
        NSMutableArray<CPTBuyBallModel *> * betList = [self dataTmpCartArray];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        NSMutableSet *playKeyArray = [NSMutableSet set];
        for(CPTBuyBallModel * ball in betList){
            [playKeyArray addObject:ball.superKey];
        }
        for(NSString * playKey in playKeyArray){
            [dataDic setObject:[NSMutableArray array] forKey:playKey];
        }
        for(NSString * playKey in playKeyArray){
            for(CPTBuyBallModel * ball in betList){
                if([playKey isEqualToString:ball.superKey]){
                    NSMutableArray *tmpA = dataDic[playKey];
                    [tmpA addObject:ball];
                }
            }
        }
        NSMutableArray *maxWins = [NSMutableArray array];
        for(NSString * playKey in playKeyArray){
            NSMutableArray *tmpA = dataDic[playKey];
            CGFloat tmpMax = 0.00;
            for(NSInteger i=0;i<tmpA.count;i++){
                CPTBuyBallModel * ball = tmpA[i];
                if(tmpA.count>0){
                    tmpMax = MAX([ball.subTitle floatValue], tmpMax);
                }
            }
            if(tmpA.count>0){
                [maxWins addObject:@(tmpMax)];
            }
        }
        CGFloat tmpMaxWin = 0.00;
        for(NSInteger i=0;i<maxWins.count;i++){
            NSNumber * maxWinN = maxWins[i];
            tmpMaxWin = tmpMaxWin + maxWinN.floatValue * money;
        }
        maxWin = tmpMaxWin;
    }
    

    
    if(totleAvailable==0){
        [dic setObject:[NSNumber numberWithFloat:0.00] forKey:CPTCART_MAXWIN];
    }else{
        [dic setObject:[NSNumber numberWithFloat:maxWin] forKey:CPTCART_MAXWIN];
    }
    [dic setObject:[NSNumber numberWithInteger:totleAvailable] forKey:CPTCART_TOTLEAvailable];

    [dic setObject:[NSNumber numberWithInteger:totleAvailable] forKey:CPTCART_TOTLEAvailable];
    [dic setObject:[NSNumber numberWithInteger:totleMoney] forKey:CPTCART_TOTLEMONEY];

    
    [dic setObject:[NSNumber numberWithInteger:limitCount] forKey:CPTCART_LimitCount];
    [dic setObject:[NSNumber numberWithInteger:leftOrRight] forKey:CPTCART_LeftOrRight];
    return dic;
}

- (void)addBallModelToTmpCartArray:(CPTBuyBallModel *)model{
    if(![_tmpCartArray containsObject:model]){
        [_tmpCartArray addObject:model];
    }
}

- (void)addBallModelToCartArray:(NSMutableDictionary *)model{
    if(![_cartArray containsObject:model]){
        [_cartArray addObject:model];
    }
}

- (void)removeBallModelFromTmpCartArray:(CPTBuyBallModel *)model{
    if([_tmpCartArray containsObject:model]){
        [_tmpCartArray removeObject:model];
    }
}

- (void)removeModelFromCartArray:(NSDictionary *)model{
    [_cartArray removeObject:model];
}

- (void)clearTmpCartArray{
    [_tmpCartArray removeAllObjects];
}
- (void)clearCartArray{
    [_cartArray removeAllObjects];
}

- (NSMutableArray<CPTBuyBallModel *> *)dataTmpCartArray{
    return _tmpCartArray;
}

- (NSMutableArray *)dataCartArray{
    return _cartArray;
}

- (void)removeModelFromCartArrayByDic:(NSDictionary *)dic{
    [_cartArray removeObject:dic];
//    for(NSDictionary * model in _cartArray){
//        NSString * numberS = [NSString stringWithFormat:@"%@@%@",model.superKey,model.title];
//        if([numberS isEqualToString:dic[@"number"]]){
//            [_cartArray removeObject:model];
//        }
//    }
}

/*
 计算有效注数
 totleBalls： 总球数
 limitCount： 限制个数
 */
- (NSInteger)okCountRecursiveWithTotleBalls:(NSUInteger)totleBalls limitCount:(NSInteger)limitCount {
    if (totleBalls >=limitCount) {
        NSUInteger count = (totleBalls-limitCount > limitCount) ? limitCount : totleBalls-limitCount;
        NSInteger number = 1;
        NSInteger molecular = 1;
        NSInteger denominator = 1;
        for (NSInteger i = 0; i < count; i++) {
            molecular = molecular*(totleBalls-i);
            denominator = denominator * (i+1);
            number = (molecular*number)/denominator;
            molecular = 1;
            denominator = 1;
        }
        number = number;
        return number;
    }else{
        return 0;
    }
}

- (BOOL)isOurL:(CPTBuyTicketType)type{
    BOOL isOurL = NO;
    if(type == CPTBuyTicketType_LiuHeCai || type == CPTBuyTicketType_SSC || type == CPTBuyTicketType_TJSSC || type == CPTBuyTicketType_XJSSC|| type == CPTBuyTicketType_PK10|| type == CPTBuyTicketType_XYFT|| type == CPTBuyTicketType_PCDD|| type == CPTBuyTicketType_DaLetou|| type == CPTBuyTicketType_PaiLie35|| type == CPTBuyTicketType_HaiNanQiXingCai|| type == CPTBuyTicketType_Shuangseqiu|| type == CPTBuyTicketType_3D|| type == CPTBuyTicketType_QiLecai){
        isOurL = NO;
    }else{
        isOurL = YES;
    }
    return isOurL;
}

//- (void)checkNumber{
//        NSMutableArray<CPTBuyBallModel *> * betList = [self dataTmpCartArray];
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//        NSMutableSet *playKeyArray = [NSMutableSet set];
//        for(CPTBuyBallModel * ball in betList){
//            [playKeyArray addObject:ball.superKey];
//        }
//        for(NSString * playKey in playKeyArray){
//            [dataDic setObject:[NSMutableArray array] forKey:playKey];
//        }
//        for(NSString * playKey in playKeyArray){
//            for(CPTBuyBallModel * ball in betList){
//                if([playKey isEqualToString:ball.superKey]){
//                    NSMutableArray *tmpA = dataDic[playKey];
//                    [tmpA addObject:ball];
//                }
//            }
//        }
//        NSMutableArray *maxWins = [NSMutableArray array];
//        for(NSString * playKey in playKeyArray){
//            NSMutableArray *tmpA = dataDic[playKey];
//            CGFloat tmpMax = 0.00;
//            
//            NSMutableArray * realA = [NSMutableArray array];
//            for(NSInteger i=0;i<tmpA.count;i++){
//                CPTBuyBallModel * ball = tmpA[i];
//                for(NSString * key in mutexArray){
//                    NSArray *tmpA = [key componentsSeparatedByString:@"&"];
//                    for(NSString * title in tmpA){
//                        if([ball.title isEqualToString:title]){
//                            NSString * key2 =
//                            for(NSInteger i=0;i<tmpA.count;i++){
//                                CPTBuyBallModel * ball2 = tmpA[i];
//                                if([ball2.title isEqualToString:title]){
//                                
//                                }
//                            }
//                        }
//                    }
//                }
//                if(tmpA.count>0){
//                    tmpMax = MAX([ball.subTitle floatValue], tmpMax);
//                }
//            }
//            if(tmpA.count>0){
//                [maxWins addObject:@(tmpMax)];
//            }
//        }
//
////        CGFloat tmpMaxWin = 0.00;
////        for(NSInteger i=0;i<maxWins.count;i++){
////            NSNumber * maxWinN = maxWins[i];
////            tmpMaxWin = tmpMaxWin + maxWinN.floatValue * money;
////        }
////        maxWin = tmpMaxWin;
//
//    
//    
//}


@end
