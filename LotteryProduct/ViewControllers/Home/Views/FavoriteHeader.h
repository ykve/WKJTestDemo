//
//  HomeHeaderView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FavoriteHeaderDelegate <NSObject>

- (void)clickEdit:(UIButton *)sender ;
@end

@interface FavoriteHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *remindLbl;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIView *line1;


@property (weak, nonatomic) id<FavoriteHeaderDelegate> delegate;


@end
