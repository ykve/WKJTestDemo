//
//  CJScroViewBar.h
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/7.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexBlock)(NSString *title,NSInteger index);

@interface CJScroViewBar : UIScrollView

@property (nonatomic, strong) UIColor    *lineColor;        //移动线的颜色(默认红色)
@property (nonatomic, assign) CGFloat    lineHeight;        //移动线的高度(默认2)
@property (nonatomic, assign) CGFloat    lineCornerRadius;  //移动线的两边弧度(默认3)
@property (nonatomic, copy  ) IndexBlock indexBlock;        //block回调(返回标题、下标)
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, assign) NSInteger  selectindex;
@property (nonatomic, assign) BOOL  isCart;
@property (nonatomic, strong) UIColor *selectColor;;
@property (nonatomic, assign) BOOL isXinshui;
@property (nonatomic, assign) BOOL isHongbao;
/// 移动线是否等于文字宽度
@property (nonatomic, assign) BOOL isEqualTextWidth;



/**
 *  设置数据源与属性
 *
 *  @param titles  每个选项的标题
 *  @param normal_color 默认颜色
 *  @param select_color 选中颜色
 *  @param font    字体
 */
- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font;

/**
 *  得到移动的下标与内容
 *
 *  @param block 回调
 */
- (void)getViewIndex:(IndexBlock)block;

/**
 *  设置移动的位置
 *
 *  @param index 下标
 */
- (void)setViewIndex:(NSInteger)index;

@end
