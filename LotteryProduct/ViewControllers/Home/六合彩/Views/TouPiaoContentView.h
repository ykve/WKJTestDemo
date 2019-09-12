//
//  TouPiaoContentView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TouPiaoContentViewDelegate <NSObject>

- (void)removeTouPiaoContentView;
- (void)submitTouPiao:(NSString *)str;

@end

@interface TouPiaoContentView : UIView

@property (nonatomic, strong)NSMutableArray *toupiaoList;

@property (nonatomic, copy) NSString *issue;



@property (nonatomic,weak) id<TouPiaoContentViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
