//
//  CPTBuyRightCollectionBanBoCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTBuyRightButtonModel.h"
@interface CPTBuyRightCollectionBanBoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UILabel *ballButton;
@property (weak, nonatomic) IBOutlet UIView *bcV;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@property (strong, nonatomic) CPTBuyBallModel *model;
@property (assign, nonatomic) BOOL isSelected;



@end
