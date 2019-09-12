//
//  FreeRecommendView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeRecommendView : UIView

/**
 2018-04-02 14：40 050期 开奖结果
 */
@property (weak, nonatomic) IBOutlet UILabel *recommendversionslab;
/**
 推荐号
 */
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numerlabs;


@end
