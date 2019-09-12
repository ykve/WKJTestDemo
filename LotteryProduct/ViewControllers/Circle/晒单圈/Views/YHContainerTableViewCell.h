//
//  YHContainerTableViewCell.h
//  YHLinkageDemo
//
//  Created by 张长弓 on 2018/1/8.
//  Copyright © 2018年 张长弓. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColumnModel, CircleListPostViewController;
@protocol YHDContainerCellDelegate <NSObject>

@optional
- (void)mmtdOptionalScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)mmtdOptionalScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end


@interface YHContainerTableViewCell : UITableViewCell

//@property (nonatomic, strong) NSMutableArray<CircleListPostViewController *> *viewControllers;

/** <#Description#> */
@property (assign, nonatomic) UIViewController *superViewController;

//@property (strong, nonatomic) NSArray<ColumnModel *> *dataSoure;
@property (assign, nonatomic) NSInteger selectindex;

@property (nonatomic, weak) id <YHDContainerCellDelegate> delegate;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *vcArray;

@property (nonatomic, assign) BOOL objectCanScroll;
@property (nonatomic, assign) BOOL isSelectIndex;

@end
