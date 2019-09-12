//
//  MyArticleTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendlistModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyArticleTableViewCellDelegate <NSObject>

@optional
- (void)clickZanBtn:(UIButton *)btn;
- (void)editArticle:(UIButton *)btn;

- (void)clickUnfoldBtn:(UIButton *)btn;

//-(void)reloadIndexPathWithModel:(RecommendlistModel *)model indexPath:(NSIndexPath *)indexPath;

@end

@interface MyArticleTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *sourcelab;
@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
//@property (weak, nonatomic) IBOutlet UILabel *subtitlelab;
//134期:[牛气冲天]
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *zanNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *seecountlab;
@property (weak, nonatomic) IBOutlet UIImageView *iconimgv;
@property (weak, nonatomic) IBOutlet UILabel *remarkNumLbl;

//@property (nonatomic, assign)BOOL isShowEditBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;

@property (weak, nonatomic) IBOutlet UIButton *unfoldBtn;


@property (nonatomic,weak) id<MyArticleTableViewCellDelegate> delegate;

@property (nonatomic, strong) RecommendlistModel *model;

@end

NS_ASSUME_NONNULL_END
