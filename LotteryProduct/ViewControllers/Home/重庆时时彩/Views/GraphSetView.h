//
//  GraphSetView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphSetView : UIView
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, copy) void (^setBlock)(NSDictionary *dic);

+(GraphSetView *)share;


-(void)showWithInfo:(NSDictionary *)dic;

@end
