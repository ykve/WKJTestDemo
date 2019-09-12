//
//  Gendan_PostmarkView.h
//  LotteryProduct
//
//  Created by pt c on 2019/6/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Gendan_PostmarkView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property(assign,nonatomic) NSInteger code;// 0 未跟 1 已跟 2中奖
@property(assign,nonatomic) NSInteger isGendan;//0 未跟 1 已跟

@end

NS_ASSUME_NONNULL_END
