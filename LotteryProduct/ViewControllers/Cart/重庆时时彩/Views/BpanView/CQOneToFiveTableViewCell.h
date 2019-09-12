//
//  CQOneToFiveTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CQOneToFiveTableViewCellDelegate <NSObject>


@end

@interface CQOneToFiveTableViewCell : UITableViewCell

@property (nonatomic, weak)id<CQOneToFiveTableViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
