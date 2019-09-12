//
//  CartOddsModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Setting;
@class OddsList;
@interface CartOddsModel : NSObject

@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , assign) NSInteger              parentId;
@property (nonatomic , copy) NSString              * section;
@property (nonatomic , copy) NSString              * tree;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , strong) Setting              * setting;
@property (nonatomic , assign) BOOL              isDelete;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , strong) NSArray<OddsList *>              * oddsList;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              categoryId;

@end

@interface Setting :NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * playRemarkSx;
@property (nonatomic , copy) NSString              * winCount;
@property (nonatomic , copy) NSString              * totalCount;
@property (nonatomic , copy) NSString              * totalCountBak;
@property (nonatomic , copy) NSString              * winCountBak;
@property (nonatomic , assign) BOOL              isDelete;
@property (nonatomic , copy) NSString              * reward;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , assign) NSInteger              playId;
@property (nonatomic , assign) NSInteger              cateId;
@property (nonatomic , assign) float              singleMoney;
@property (nonatomic , copy) NSString              * rewardLevel;
@property (nonatomic , copy) NSString              * example;
@property (nonatomic , copy) NSString              * exampleNum;
@property (nonatomic , copy) NSString              * playRemark;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , copy) NSString              * matchtype;

@end

@interface OddsList :NSObject
@property (nonatomic , assign) NSInteger              settingId;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * totalCount;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , assign) BOOL              isDelete;
@property (nonatomic , copy) NSString              * odds;
@property (nonatomic , copy) NSString              * winCount;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              createTime;

@end
