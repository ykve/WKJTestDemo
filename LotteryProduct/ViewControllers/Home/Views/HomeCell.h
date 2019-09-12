//
//  HomeCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrartHomeSubModel.h"
@interface HomeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconimgv;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *sanjiaoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *hotImgView;
@property (strong, nonatomic)  UIView *isWorkView;


@property (nonatomic, assign) BOOL isHiddened;

@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, assign) CPTBuyTicketType type;
@property (strong, nonatomic)  CrartHomeSubModel *model;

@end
