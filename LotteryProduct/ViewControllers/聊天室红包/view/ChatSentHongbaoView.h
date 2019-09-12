//
//  ListNoticeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatSentHongbaoView : UIView
@property(weak,nonatomic) IBOutlet UITextField* moneyTF;
@property(weak,nonatomic) IBOutlet UITextField* numberTF;
@property (nonatomic, copy) void (^clickOKBtn)(NSInteger money,NSInteger count);

-(void)show;
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
