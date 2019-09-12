//
//  CartSimpleBottomView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CartSimpleBottomViewDelegate <NSObject>

- (void)suerPriceAndMulti:(NSInteger)priceType times:(NSInteger)times;

@end

@interface CartSimpleBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *pricelab;
@property (weak, nonatomic) IBOutlet UILabel *maxpricelab;
@property (copy, nonatomic) void (^bottomClickBlock)(NSInteger type,UIButton* sender);
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *jjBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *bottomTopView;

@property (nonatomic, copy) NSString *superType;
@property (nonatomic, copy) NSString *superPlayKey;

@property (copy, nonatomic) void (^SurePriceBlock)(NSInteger pricetype , NSInteger times);

@property (assign, nonatomic) NSInteger pricetype;

@property (nonatomic, assign)CGFloat baseMoney;
@property (nonatomic, assign)CGFloat multiNum;


@property (nonatomic, strong)NSArray *moneyArray;

@property (nonatomic, strong)NSArray *multiArray;


@property (nonatomic, strong)UIView *fatherView;

@property (nonatomic, assign)CGFloat totalMoney;

@property (nonatomic, weak)id<CartSimpleBottomViewDelegate> delegate;

- (void)refreshUI;
- (NSInteger)checkIsOkToBuy;
- (NSInteger)checkLimitCount;

@end

NS_ASSUME_NONNULL_END
