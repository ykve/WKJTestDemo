//
//  PK10LuzhuCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PK10LuzhuCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *dataArray;

@end
