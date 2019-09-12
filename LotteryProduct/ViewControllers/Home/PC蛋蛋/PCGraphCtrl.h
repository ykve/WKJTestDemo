//
//  PCGraphCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface PCGraphCtrl : RootCtrl
/**
 1：第一区
 2：第二区
 3：第三区
 */
@property (nonatomic, assign) NSInteger type;

-(void)initDataWithissue:(NSInteger)issue Withsort:(NSInteger)sort;

@end
