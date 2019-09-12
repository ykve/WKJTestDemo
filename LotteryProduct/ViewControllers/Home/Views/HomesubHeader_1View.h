//
//  HomesubHeader_1View.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomesubHeader_1View : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *versionlab;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@property (weak, nonatomic) IBOutlet UILabel *sellversionlab;

@property (weak, nonatomic) IBOutlet UILabel *releaseversionlab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *statuslab;
@property (strong, nonatomic) WB_Stopwatch *stopWatchLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberTitleLabels;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberSubLabels;

@end
