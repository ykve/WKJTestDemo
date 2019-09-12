//
//  SixPropertyCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixPropertyCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UILabel *titlelab;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIView *line;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, assign)NSInteger type;
@end
