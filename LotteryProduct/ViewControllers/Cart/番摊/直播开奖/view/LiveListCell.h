//
//  LiveListCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LiveListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;

@property (weak, nonatomic) IBOutlet UILabel *titlelab1;
@property (weak, nonatomic) IBOutlet UILabel *titlelab2;
@property (weak, nonatomic) IBOutlet UILabel *titlelab3;
@property (weak, nonatomic) IBOutlet UILabel *titlelab4;
@property (weak, nonatomic) IBOutlet UILabel *titlelab5;


- (void)setDataWithModel:(LiveListModel *)model;
@end

NS_ASSUME_NONNULL_END
