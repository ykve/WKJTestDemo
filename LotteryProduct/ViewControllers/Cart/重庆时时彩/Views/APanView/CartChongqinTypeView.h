//
//  CartChongqinTypeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTypeModel.h"
@interface CartChongqinTypeView : UIView<TagViewDelegate>

@property (nonatomic, strong)TagView *playView;

@property (nonatomic, strong)TagView *type1View;

@property (nonatomic, strong)TagView *type2View;

@property (nonatomic, strong)UILabel *type1lab;

@property (nonatomic, strong)UILabel *type2lab;

@property (nonatomic, strong)UIView *sureBtnView;

@property (strong, nonatomic) UIControl *overlayView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, copy)void(^dismissBlock)(void);



@end
