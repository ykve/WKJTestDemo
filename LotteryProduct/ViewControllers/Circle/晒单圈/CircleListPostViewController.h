//
//  CircleListPostViewController.h
//  LotteryProduct
//
//  Created by Jiang on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentClassScrollViewController.h"

@interface CircleListPostViewController : ParentClassScrollViewController

//@property (nonatomic, assign)void (^refreshBlock)(void);
/**
 tag: 0最新发表  1我的关注  2 回复我的
 */
@property(nonatomic, assign) NSInteger tag;

@property (assign, nonatomic) int page;

-(void)refreshData;

@end

@interface CircleCommentListCell : UITableViewCell

@end
