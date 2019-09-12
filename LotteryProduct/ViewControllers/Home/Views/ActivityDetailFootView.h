//
//  HomesubFootView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdView.h"

@interface ActivityDetailFootView : UIView

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet AdView *adView;

@property (nonatomic, copy) void (^showallBlock)(BOOL showall);

@end
