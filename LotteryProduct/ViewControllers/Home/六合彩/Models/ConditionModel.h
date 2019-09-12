//
//  ConditionModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConditionClassModel :NSObject
@property (nonatomic , copy) NSString              * subtitle;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , assign) BOOL                  selected;
@end

@interface ConditionModel : NSObject
@property (nonatomic , assign) NSInteger               ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic , assign) BOOL  selected;
@property (nonatomic , assign) NSInteger             count;
@property (nonatomic , strong) NSArray<ConditionClassModel *>    * classmodelArray;
/**
 判断是否有选择子条件
 */
@property (assign, nonatomic) BOOL submodelselect;
@end
