//
//  CartPCModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartPCModel : NSObject

@property (nonatomic , assign) NSInteger              settingId;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , assign) NSInteger              totalCount;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , assign) BOOL              isDelete;
@property (nonatomic , assign) NSInteger              odds;
@property (nonatomic , assign) NSInteger              winCount;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              createTime;

@property (nonatomic, assign)BOOL select;

@end
