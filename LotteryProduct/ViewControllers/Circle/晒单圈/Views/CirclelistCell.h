//
//  CirclelistCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CirclePhotosView.h"
#import "CircleModel.h"
@interface CirclelistCell : UITableViewHeaderFooterView

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UIImageView *headimgv;

@property (nonatomic, strong)UILabel *namelab;

@property (nonatomic, strong)UILabel *contentlab;

@property (nonatomic, strong)UILabel *timelab;

@property (nonatomic, strong)UIButton *likeBtn;

@property (nonatomic, strong)UIButton *commentBtn;

@property (nonatomic, strong)UILabel *useselfdaylab;

@property (nonatomic, strong)UILabel *useselfmonthlab;

@property (nonatomic, strong)UIButton *attentionBtn;

@property (nonatomic, strong)UIButton *deleteBtn;

@property (nonatomic, assign)BOOL isusercircle;

//@property (nonatomic, strong)UIView *line;

@property (nonatomic, strong)CirclePhotosView *photosView;

@property (nonatomic, strong)CircleModel *model;

@property (nonatomic, copy)void(^circleClickBlock)(NSInteger click,UIButton *sender);

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

+(CGFloat)getHeight:(CircleModel *)model;

@end
