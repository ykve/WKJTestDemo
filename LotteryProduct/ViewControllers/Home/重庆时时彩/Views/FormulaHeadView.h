//
//  FormulaHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormulaHeadView : UIView

@property (weak, nonatomic) IBOutlet UIButton *versionsBtn;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titlelabs;

@property (copy, nonatomic) void (^versionBlock)(UIButton *sender);

@end
