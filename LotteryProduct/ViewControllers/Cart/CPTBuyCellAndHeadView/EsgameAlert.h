//
//  ListNoticeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EsgameAlert : UIView
@property(weak,nonatomic) IBOutlet UILabel* moneyLab;
@property (nonatomic, copy) void (^clickOKBtn)();

-(void)showInView:(UIView *)view;
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
