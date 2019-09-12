//
//  RemarkAreaTableViewCell.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/26.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemarkAreaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *remarkNumLbl;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end

NS_ASSUME_NONNULL_END
