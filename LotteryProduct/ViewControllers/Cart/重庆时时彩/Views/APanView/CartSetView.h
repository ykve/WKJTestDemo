//
//  CartSetView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartSetView : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeBtns;

@property (weak, nonatomic) IBOutlet UILabel *countlab;

@property (strong, nonatomic) UIControl *overlayView;

@property (assign, nonatomic) NSInteger pricetype;

@property (copy, nonatomic) void (^SureCartSetBlock)(NSInteger pricetype , NSInteger times);

-(void)showWithtype:(NSInteger)pricetype Withtimes:(NSInteger)times;

-(void)dismiss;

@end
