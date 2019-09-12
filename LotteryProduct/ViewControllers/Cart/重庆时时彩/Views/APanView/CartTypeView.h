//
//  CartTypeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTypeModel.h"
@interface CartTypeView : UIScrollView <TagViewDelegate>

@property (nonatomic, strong)TagView *playView;

@property (nonatomic, strong)TagView *type1View;

@property (nonatomic, strong)TagView *type2View;

@property (nonatomic, strong)UILabel *type1lab;

@property (nonatomic, strong)UILabel *type2lab;

@property (nonatomic, strong)UIView *sureBtnView;

@property (strong, nonatomic) UIControl *overlayView;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, copy)void(^dismissBlock)(void);

@property (nonatomic, copy)void(^showTypeBlock)(CartTypeModel *model);
/**
 选中传回的model
 */
@property (nonatomic, strong) CartTypeModel *selectModel;
/**
 type = 1 :重庆时时彩
        2：北京PK10
        3: PC蛋蛋
        4:六合彩
 */
@property (nonatomic, assign)NSInteger type;
/**
 记录确定前view的高度
 */
@property (nonatomic, assign)CGFloat height;

/// 旧方法 先放着
//-(void)show:(UIView*)keyview Withtype:(NSInteger)type;

-(void)show:(UIView *)keyview Withtype:(NSInteger)type Withmodel:(NSArray<CartTypeModel *> *)typelist;

-(void)dismiss;

@end
