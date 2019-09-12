//
//  BuyLotBottomView.h
//  LotteryProduct
//
//  Created by pt c on 2019/8/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyLotBottomView : UIView

@property (copy, nonatomic) void (^bottomClickBlock)(NSInteger type,UIButton* sender);

@property (strong, nonatomic) UIView *bottomTopView;
@property (strong, nonatomic) UIButton *jjBtn;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UIButton *addCartBtn;

@property (strong, nonatomic) UILabel *pricelab;
@property (strong, nonatomic) UILabel *maxpricelab;
@property (strong, nonatomic) UIButton *publishBtn;
@property (strong, nonatomic) UIButton *cartBtn;
@property (strong, nonatomic) UILabel *numlab;

@property (nonatomic, copy) NSString *superType;
@property (nonatomic, copy) NSString *superPlayKey;

- (void)refreshUI;
- (NSInteger)checkIsOkToBuy;
- (NSInteger)checkLimitCount;

@end

NS_ASSUME_NONNULL_END

