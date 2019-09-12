//
//  CirclePhotosView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirclePhotosView : UIView

@property (nonatomic, strong)NSArray *imageurlArray;

@property (nonatomic, assign)BOOL LiuHePhoto;

+ (CGSize)sizeWithImages:(NSArray *)images width:(CGFloat)width andMargin:(CGFloat)margin;

@end
