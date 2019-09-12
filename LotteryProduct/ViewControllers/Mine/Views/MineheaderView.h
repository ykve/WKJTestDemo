//
//  MineheaderView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineheaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *pricelab;

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;

@property (weak, nonatomic) IBOutlet UILabel *namelab;

@property (weak, nonatomic) IBOutlet UILabel *invitelab;

+ (CGFloat)headerViewHeight;

@end
