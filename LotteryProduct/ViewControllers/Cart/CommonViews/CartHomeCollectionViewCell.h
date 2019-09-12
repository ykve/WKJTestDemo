//
//  CartHomeCollectionViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartHomeCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (strong, nonatomic) WB_Stopwatch *stopwatch;
@property (weak, nonatomic) IBOutlet UIImageView *sanjiaoImageView;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;

@property (nonatomic, assign) BOOL isHiddened;

@property (nonatomic, assign)BOOL isSelected;


@end

NS_ASSUME_NONNULL_END
