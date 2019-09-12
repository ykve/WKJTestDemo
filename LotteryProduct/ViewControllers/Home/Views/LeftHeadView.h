//
//  LeftHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@property (weak, nonatomic) IBOutlet UILabel *nicknamelab;

@property (weak, nonatomic) IBOutlet UILabel *pricelab;

@property (copy, nonatomic) void (^leftheadBlock)(NSInteger type);

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btns_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_height;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;


@end
