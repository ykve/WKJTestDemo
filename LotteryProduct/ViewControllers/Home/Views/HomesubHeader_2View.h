//
//  HomesubHeader_2View.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomesubHeader_2View : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *versionlab;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *statuslab;
@property (weak, nonatomic) IBOutlet UILabel *addlab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberTitleLabels;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberSubLabels;

@end
