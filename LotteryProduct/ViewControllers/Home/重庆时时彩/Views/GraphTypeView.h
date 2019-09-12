//
//  GraphTypeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeModel.h"
@interface GraphTypeView : UIView
@property (nonatomic, copy)void(^graphTypeBlock)(TypeModel *model);

- (void)show:(UIView *)view;
- (void)dismiss;
@end
