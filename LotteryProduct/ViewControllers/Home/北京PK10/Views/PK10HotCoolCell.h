//
//  PK10HotCoolCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PK10HotCoolSubView.h"
@interface PK10HotCoolCell : UITableViewCell

@property (nonatomic, strong)NSArray *hotArray;

@property (nonatomic, strong)NSArray *warmthArray;

@property (nonatomic, strong)NSArray *coolArray;

@property (nonatomic, assign)BOOL showcount;

@property (nonatomic, copy) NSString *title;

@end
