//
//  AdView.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/10.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CPTADType)//
{
    CPTADType_sy                       =   0,
    CPTADType_hb                    =   1,
    
};
@interface AdView : UIView
@property(strong,nonatomic)NSMutableArray *dataA;
@property(assign,nonatomic)CGFloat cellHeight;
@property(assign,nonatomic)CPTADType type;
@property(strong,nonatomic)NSNumber * atID;
@property (nonatomic, copy) void (^clickCell)(NSInteger index);

- (void)loadTableView;
- (void)reloadData;
- (void)endScroll;
-(void)startScroll;
@end

NS_ASSUME_NONNULL_END
