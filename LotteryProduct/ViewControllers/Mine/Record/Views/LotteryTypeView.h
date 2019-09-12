//
//  LotteryTypeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryTypeView : UIView


@property (strong, nonatomic) UIControl *overlayView;

@property (strong, nonatomic) NSMutableArray *lottery_ids;

@property (copy, nonatomic) void(^dismissBlock)(NSArray *lotteryIds);

@property (weak, nonatomic)IBOutlet UIView *headView;
@property (weak, nonatomic)IBOutlet UIScrollView *headScroll;

@property (weak, nonatomic)IBOutlet UIButton *okButton;
@property (assign, nonatomic) BOOL isN;

+(LotteryTypeView *)share;

+(void)tearDown;

-(void)show;

-(void)dismiss;

@end
