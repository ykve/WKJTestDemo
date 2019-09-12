//
//  HomesubFootView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomesubFootView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (nonatomic, copy) void (^showallBlock)(BOOL showall);

@end
