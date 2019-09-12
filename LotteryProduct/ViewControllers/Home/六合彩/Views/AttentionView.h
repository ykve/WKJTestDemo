//
//  AttentionView.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/3.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AttentionViewDelegate <NSObject>

- (void)closeCoverView;

@end

@interface AttentionView : UIView

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIView *topView;

@property (nonatomic,assign) BOOL isDeleteModel;
@property (nonatomic, weak)UIButton *editBtn;


@property (nonatomic, weak)id <AttentionViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
