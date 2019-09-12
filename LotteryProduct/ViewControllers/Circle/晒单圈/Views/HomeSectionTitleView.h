//
//  HomeSectionTitleView.h
//  ClawGame
//
//  Created by Jiang on 2018/3/1.
//  Copyright © 2018年 softgarden. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColumnModel;
typedef void (^IndexChangeBlock)(NSInteger index);

@interface HomeSectionTitleView : UIView

@property (strong, nonatomic) NSArray<ColumnModel *> *dataSoure;

/** <#Description#> */
@property (strong, nonatomic) UIScrollView *titleScrollView;

/** 记录是否点击 */
@property (nonatomic, assign) BOOL isClickTitle;

/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;
/**
 根据角标，选中对应的控制器
 */
@property (nonatomic, assign) NSInteger selectIndex;
/** 计算上一次选中角标 */
@property (nonatomic, assign) NSInteger selIndex;

/** <#Description#> */
@property (copy, nonatomic) IndexChangeBlock block;

@end
