//
//  SixSearchView.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/7.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SixSearchViewDelegate <NSObject>

- (void)searchArticles:(NSString *)content;

@end

@interface SixSearchView : UIView

@property (nonatomic,weak) UISearchBar *searchBar;

@property (nonatomic, copy) NSString *placehold;

@property (nonatomic, weak)id <SixSearchViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
