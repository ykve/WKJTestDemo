//
//  CPTBuyRightCollectionTwoNCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTBuyRightButtonModel.h"
@interface CPTBuyRightCollectionTwoNCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *ballButton;
@property (weak, nonatomic) IBOutlet UIView *bcV;
@property (weak, nonatomic) IBOutlet UIView *bcV1;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@property (strong, nonatomic) CPTBuyBallModel *model;
@property (assign, nonatomic) BOOL isSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tmpY;



@end
