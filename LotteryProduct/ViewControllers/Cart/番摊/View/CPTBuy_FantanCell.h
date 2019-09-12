//
//  CPTBuy_FantanCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/7.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuy_FantanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab0;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;

@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *lab7;
@property (weak, nonatomic) IBOutlet UILabel *lab8;
@property (weak, nonatomic) IBOutlet UILabel *lab9;

@property (weak, nonatomic) IBOutlet UILabel *lab10;
@property (weak, nonatomic) IBOutlet UILabel *lab11;
@property (weak, nonatomic) IBOutlet UILabel *lab12;
@property (weak, nonatomic) IBOutlet UILabel *lab13;
@property (weak, nonatomic) IBOutlet UILabel *lab14;
@property (weak, nonatomic) IBOutlet UILabel *lab15;

@property (weak, nonatomic) IBOutlet UILabel *lab16;
@property (weak, nonatomic) IBOutlet UILabel *lab17;
@property (weak, nonatomic) IBOutlet UILabel *lab18;
@property (weak, nonatomic) IBOutlet UILabel *lab19;
@property (weak, nonatomic) IBOutlet UILabel *lab20;

@property (weak, nonatomic) IBOutlet UILabel *lab21;
@property (weak, nonatomic) IBOutlet UILabel *lab22;
@property (weak, nonatomic) IBOutlet UILabel *lab23;
@property (weak, nonatomic) IBOutlet UILabel *lab24;
@property (weak, nonatomic) IBOutlet UILabel *lab25;

@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;

@property (weak, nonatomic) IBOutlet UIButton *btn10;
@property (weak, nonatomic) IBOutlet UIButton *btn11;
@property (weak, nonatomic) IBOutlet UIButton *btn12;
@property (weak, nonatomic) IBOutlet UIButton *btn13;
@property (weak, nonatomic) IBOutlet UIButton *btn14;
@property (weak, nonatomic) IBOutlet UIButton *btn15;

@property (weak, nonatomic) IBOutlet UIButton *btn16;
@property (weak, nonatomic) IBOutlet UIButton *btn17;
@property (weak, nonatomic) IBOutlet UIButton *btn18;
@property (weak, nonatomic) IBOutlet UIButton *btn19;
@property (weak, nonatomic) IBOutlet UIButton *btn20;

@property (weak, nonatomic) IBOutlet UIButton *btn21;
@property (weak, nonatomic) IBOutlet UIButton *btn22;
@property (weak, nonatomic) IBOutlet UIButton *btn23;
@property (weak, nonatomic) IBOutlet UIButton *btn24;
@property (weak, nonatomic) IBOutlet UIButton *btn25;


@property (weak, nonatomic) IBOutlet UIView *iconImgView;

@property (weak, nonatomic) IBOutlet UIView *bigSquareView;

@property (weak, nonatomic) IBOutlet UIStackView *topStackView;
@property (weak, nonatomic) IBOutlet UIStackView *leftStackView;
@property (weak, nonatomic) IBOutlet UIStackView *rightStackView;
@property (weak, nonatomic) IBOutlet UIStackView *bottomStackView;

@property (nonatomic,copy) void(^updateSelectedArray)(NSArray *selectArr);
- (void)clearAllWithRandom:(BOOL)isRandom;

- (void)setODDsWithArray:(NSMutableArray *)array;

@end

NS_ASSUME_NONNULL_END
