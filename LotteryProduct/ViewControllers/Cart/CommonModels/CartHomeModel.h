//
//  CartHomeModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrartHomeSubModel.h"

@interface CartHomeModel : NSObject

@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * lotteryId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              categoryId;
@property (nonatomic , copy) NSString               *icon;
@property (nonatomic , assign) NSInteger              openTime;
@property (nonatomic , assign) BOOL                  selected;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , copy) NSString              * cateName;
@property (nonatomic , assign) BOOL                  isWork;

@property (nonatomic, strong) NSMutableArray<CrartHomeSubModel *> *lotterys;


//intro  cateName lotterys

@end
