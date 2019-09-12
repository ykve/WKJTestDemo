//
//  TouPiaoContentCollectionViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouPiaoContentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *piaoNumLbl;

@end

NS_ASSUME_NONNULL_END
