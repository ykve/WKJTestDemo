//
//  LotteryListCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/31.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryListCtrl : RootCtrl
/**
 [@"一星直选",@"二星直选",@"二星组选",@"三星直选",@"三星组三复式",@"三星组六",@"五星直选",@"五星通选",@"大小单双"]
 数组index
 */
@property (nonatomic, assign) NSInteger startype;

-(void)initData:(NSString *)time;

@end
