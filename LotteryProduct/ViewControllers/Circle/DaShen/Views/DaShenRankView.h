//
//  DaShenRankView.h
//  LotteryProduct
//
//  Created by Jiang on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaShenRankView : UIStackView

/**
 用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;

/**
 用户胜率
 */
@property (weak, nonatomic) IBOutlet UILabel *rankNumber;

/**
 用户昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end
