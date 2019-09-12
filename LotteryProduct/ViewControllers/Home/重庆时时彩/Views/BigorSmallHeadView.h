//
//  BigorSmallHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigorSmallHeadView : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UILabel *type1lab;

@property (weak, nonatomic) IBOutlet UILabel *type2lab;

@property (copy, nonatomic) void(^selectnumberBlock)(NSInteger index);

@end
