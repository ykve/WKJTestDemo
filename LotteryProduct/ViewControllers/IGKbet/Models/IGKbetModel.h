//
//  IGKbetModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/29.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCInfoModel.h"
@interface IGKbetModel : NSObject

@property (nonatomic, strong)LotteryInfoModel *pcegg;//PC蛋蛋

@property (nonatomic, strong)SixInfoModel *lhc;//六合彩

@property (nonatomic, strong)SixInfoModel *onelhc;//1分六合彩
@property (nonatomic, strong)SixInfoModel *fivelhc;//5分六合彩
@property (nonatomic, strong)SixInfoModel *sslhc;//时时六合彩

@property (nonatomic, strong)PK10InfoModel *bjpks;//北京pk10
@property (nonatomic, strong)PK10InfoModel *tenpks;//10分pk10
@property (nonatomic, strong)PK10InfoModel *fivepks;//5分pk10
@property (nonatomic, strong)PK10InfoModel *jspks;//极速pk10

@property (nonatomic, strong)PK10InfoModel *xyft;//幸运飞艇

@property (nonatomic, strong)ChongqinInfoModel *txffc;//天津时时彩

@property (nonatomic, strong)ChongqinInfoModel *xjssc;//新疆时时彩
@property (nonatomic, strong)ChongqinInfoModel *cqssc;//重庆时时彩
@property (nonatomic, strong)ChongqinInfoModel *tjssc;//天津时时彩

@property (nonatomic, strong)ChongqinInfoModel *tenssc;//10分时时彩
@property (nonatomic, strong)ChongqinInfoModel *fivessc;//5分时时彩
@property (nonatomic, strong)ChongqinInfoModel *jsssc;//极速时时彩

@property (nonatomic, strong)LotteryInfoModel * daLetou;//大乐透
@property (nonatomic, strong)LotteryInfoModel * paiLie35;//排列35
@property (nonatomic, strong)LotteryInfoModel * haiNanQiXingCai;//海南七星彩

@property (nonatomic, strong)LotteryInfoModel * shuangseqiu;//双色球
@property (nonatomic, strong)LotteryInfoModel * threeD;//3d
@property (nonatomic, strong)LotteryInfoModel * qiLecai;//七乐彩

@property (nonatomic, strong)LotteryInfoModel * aoZhouACT;//澳洲ACT
@property (nonatomic, strong)LotteryInfoModel * aozhouF1;//澳洲F1
@property (nonatomic, strong)LotteryInfoModel * aozhouSSC;//澳洲时时彩

@property (nonatomic, strong)LotteryInfoModel * nnKuaile;//快乐
@property (nonatomic, strong)LotteryInfoModel * nnAozhou;//澳洲牛牛
@property (nonatomic, strong)LotteryInfoModel * nnJisu;//极速牛牛

@property (nonatomic, strong)LotteryInfoModel * fantanPK10;//pk10番摊
@property (nonatomic, strong)LotteryInfoModel * fantanXYFT;//幸运飞艇番摊
@property (nonatomic, strong)LotteryInfoModel * fantanSSC;//极速时时彩番摊

@end
