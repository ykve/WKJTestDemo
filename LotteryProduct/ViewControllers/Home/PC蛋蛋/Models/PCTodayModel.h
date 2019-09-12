//
//  PCTodayModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/1.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NumRegion;
@interface PCTodayModel : NSObject

@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , strong) NumRegion              * numRegion;
@property (nonatomic , assign) NSInteger              openCount;

@end

@interface NumRegion :NSObject
@property (nonatomic , assign) NSInteger              open2;
@property (nonatomic , assign) NSInteger              open1;
@property (nonatomic , assign) NSInteger              noOpen1;
@property (nonatomic , assign) NSInteger              noOpen3;
@property (nonatomic , assign) NSInteger              open3;
@property (nonatomic , assign) NSInteger              noOpen2;

@end
