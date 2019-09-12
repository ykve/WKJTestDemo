//
//  ListNoticeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeActivityAlertView : UIView
@property(strong,nonatomic) UILabel* titleLabel;
@property(strong,nonatomic) UITextView* textView;
@property(strong,nonatomic) NSMutableArray * models;
@property(strong,nonatomic) NSNumber * actID;
@property(weak,nonatomic) IBOutlet UILabel* moneyLab;
@property(weak,nonatomic) IBOutlet UILabel* yuanLab;
@property(assign,nonatomic) BOOL isFromHome;
@property(weak,nonatomic)IBOutlet UIView* afterV;
@property(weak,nonatomic)IBOutlet UIView* afterMoneyV;

@property (nonatomic, copy) void (^clickOKBtn)(void);
@property(weak,nonatomic)IBOutlet UILabel* titleL;

-(void)show;
-(void)dismiss;
- (void)showView:(UIView *)view some:(NSNumber *)money;

@end

NS_ASSUME_NONNULL_END
