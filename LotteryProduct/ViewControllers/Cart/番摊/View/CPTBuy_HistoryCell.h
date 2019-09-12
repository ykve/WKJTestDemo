//
//  CPTBuy_HistoryCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/3.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedOrBlueBallCell.h"
#import "PCInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CPTBuy_HistoryCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (assign,nonatomic) CPTBuyTicketType type;
@property (assign,nonatomic) NSInteger categoryId;
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UIView *niuWinBgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *dotView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewCenter;

- (void)setDataWithModel:(PCInfoNewModel *)model andIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
