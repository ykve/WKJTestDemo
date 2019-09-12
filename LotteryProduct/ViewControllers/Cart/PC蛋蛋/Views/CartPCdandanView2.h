//
//  CartPCdandanView2.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartPCModel.h"
@interface CartPCdandanView2 : UIView

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
/**
 13：特码包三
 14：特码
 */
@property (assign, nonatomic) NSInteger type;
/**
 0-27数据模型集
 */
@property (strong, nonatomic) NSArray *numberDataArray;

@property (nonatomic, assign) NSInteger lotteryId;

@property (nonatomic, copy) void (^cartInfoBlock)(void);

@property (copy, nonatomic) void(^selectBlock)(void);

-(void)random;

-(void)clear;

@end
