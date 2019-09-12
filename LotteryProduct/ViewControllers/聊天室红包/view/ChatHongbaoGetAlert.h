//
//  ListNoticeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatHongbaoGetAlert : UIView
@property(weak,nonatomic) IBOutlet UILabel* titleLabel;
@property(weak,nonatomic) IBOutlet UILabel* subTitleLabel;
@property(weak,nonatomic) IBOutlet UILabel* subTitle2Label;

@property (nonatomic, copy) void (^clickOKBtn)();

-(void)showInView:(UIView *)view name:(NSString *)name money:(NSString *)money count:(NSString *)count;


@end

NS_ASSUME_NONNULL_END
