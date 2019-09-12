//
//  PK10LuzhuModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PK10LuzhuModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger numA;
@property (nonatomic, assign) NSInteger numB;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) CGFloat cellheight;
@end
