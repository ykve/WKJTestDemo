//
//  FormulaBottomView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormulaBottomView : UIView

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *accuracylabs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accuracy_width;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *currentlabs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *current_width;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *maxlabs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *max_width;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titleLbls;


@end
