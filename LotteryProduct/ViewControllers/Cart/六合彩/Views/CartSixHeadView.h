//
//  CartSixHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CartSixHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nextversionslab;
@property (weak, nonatomic) IBOutlet UILabel *currentversionslab;
@property (weak, nonatomic) IBOutlet UILabel *endtimelab;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;
@property (weak, nonatomic) IBOutlet UILabel *waitinglab;
@property (weak, nonatomic) IBOutlet UILabel *jialab;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;




@property (copy, nonatomic) void(^lookallBlock)(void);


@end
