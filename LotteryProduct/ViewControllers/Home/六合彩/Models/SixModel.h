//
//  SixModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SixModel : NSObject

@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *value;
@property (nonatomic, strong) UIColor *bose;
@property (nonatomic,copy) NSString *bosestring;
@property (nonatomic,copy) NSString *wuxin;
@property (nonatomic,copy) NSString *jiaye;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *last;
@property (nonatomic,assign) NSInteger num;

@end
