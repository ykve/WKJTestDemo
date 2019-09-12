//
//  PK10TwofaceMissHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PK10TwofaceMissHeadView : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numbrBtns;

@property (weak, nonatomic) IBOutlet UILabel *type1lab;

@property (weak, nonatomic) IBOutlet UILabel *type2lab;

@property (copy, nonatomic) void (^selectindexBlock)(NSInteger index);
@end
