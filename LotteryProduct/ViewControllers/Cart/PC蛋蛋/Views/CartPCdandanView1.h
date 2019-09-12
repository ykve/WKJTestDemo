//
//  CartPCdandanView1.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartPCModel.h"
@interface CartPCdandanView1 : UIView

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numbrBtns;

@property (copy, nonatomic) void(^selectBlock)(void);
/**
 10:两面
 11：色波
 12：豹子
 */
@property (assign, nonatomic) NSInteger type;
/**
 两面数据
 */
@property (strong, nonatomic) NSArray *faceDataArray;
/**
 色波数据
 */
@property (strong, nonatomic) NSArray *colorDataArray;
/**
 豹子数据
 */
@property (strong, nonatomic) NSArray *sameDataArray;

@property (nonatomic, assign) NSInteger lotteryId;

@property (nonatomic, copy) void (^cartInfoBlock)(void);

-(void)random;

-(void)clear;

@end
