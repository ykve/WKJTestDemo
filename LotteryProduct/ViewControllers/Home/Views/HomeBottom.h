//
//  HomeADCollectionViewCell.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol HomeBottomViewDelegate <NSObject>

- (void)clickKeFu;
- (void)clickChatF;
- (void)clicWebVersion;

@end

@interface HomeBottom : UICollectionViewCell
@property (weak, nonatomic) id<HomeBottomViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *footView;



@end

NS_ASSUME_NONNULL_END
