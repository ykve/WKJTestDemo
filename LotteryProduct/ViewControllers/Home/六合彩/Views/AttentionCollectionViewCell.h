//
//  AttentionCollectionViewCell.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/3.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AttentionCollectionViewCellDelegate <NSObject>

- (void)deleteAttentionPerson:(UIButton *)btn;

@end

@interface AttentionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (nonatomic,weak) id<AttentionCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) FollowModel *model;


@end

NS_ASSUME_NONNULL_END
