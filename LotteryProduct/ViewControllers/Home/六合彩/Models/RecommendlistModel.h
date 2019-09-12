//
//  RecommendlistModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendlistModel : NSObject

@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * qrCode;
//@property (nonatomic , copy) NSString              * contentDTOList;
@property (nonatomic , assign) NSInteger              realViews;
@property (nonatomic , copy) NSString              * referrer;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * heads;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * wxh;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * content;
//@property (nonatomic, assign)NSInteger               realAdmire;
@property (nonatomic, assign)NSInteger               totalAdmire;
@property (nonatomic, assign)NSInteger fansNumber;
@property (nonatomic, copy) NSString *parentMemberId;
@property (nonatomic, copy) NSString *referrerId;
@property (nonatomic, assign)BOOL loginViewFlag;


@property (nonatomic, assign)NSInteger               commentCount;
@property (nonatomic, copy) NSString *locked;


@property (nonatomic, copy) NSString *alreadyFllow;
/*  是否已经点赞  0.否，1是  */
@property (nonatomic, copy) NSString *alreadyAdmire  ;

@property (nonatomic, assign)BOOL isOpen;

@property (nonatomic, assign)CGFloat rowHeight;
@property (nonatomic, assign)CGFloat openRowHeight;

@property (nonatomic , copy) NSMutableAttributedString * htmlTitle;

-(CGFloat)heightForRowWithisShow:(RecommendlistModel *)model;


@end
