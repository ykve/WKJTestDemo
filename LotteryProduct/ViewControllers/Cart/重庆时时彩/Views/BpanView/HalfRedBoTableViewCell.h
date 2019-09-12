//
//  HalfRedBoTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HalfRedBoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;


@end

NS_ASSUME_NONNULL_END
