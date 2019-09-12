//
//  FansCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/17.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FansModel.h"
@interface FansCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headimgv;

@property (nonatomic, strong)UILabel *namelab;

@property (nonatomic, strong)UIButton *attentionBtn;

@property (nonatomic, strong)FansModel *model;

@end
