//
//  HistoryArticleTableViewCell.h
//  HappyChat
//
//  Created by 研发中心 on 2018/11/24.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendlistModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HistoryArticleTableViewCellDelegate <NSObject>

@optional
- (void)clickZanBtn:(UIButton *)btn;
- (void)editArticle:(UIButton *)btn;

- (void)clickUnfoldBtn:(UIButton *)btn;

//-(void)reloadIndexPathWithModel:(RecommendlistModel *)model indexPath:(NSIndexPath *)indexPath;


@end


@interface HistoryArticleTableViewCell : UITableViewCell

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


@property (nonatomic,weak) id<HistoryArticleTableViewCellDelegate> delegate;

@property (nonatomic, strong) RecommendlistModel *model;

@end

NS_ASSUME_NONNULL_END
