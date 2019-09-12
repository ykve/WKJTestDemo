//
//  ListNoticeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatHongbaoTopView : UIView
@property(weak,nonatomic) IBOutlet UIImageView * headImageV;
@property(weak,nonatomic) IBOutlet UILabel* nickLab;
@property(weak,nonatomic) IBOutlet UILabel* moneyLab;
@property(weak,nonatomic) IBOutlet UILabel* countLab;
@property(weak,nonatomic) IBOutlet UIButton* receivedBtn;
@property(assign,nonatomic)  NSInteger hbID;

@property (nonatomic, copy) void (^clickOKBtn)(CGFloat money);

-(void)showInView:(UIView *)view;
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
