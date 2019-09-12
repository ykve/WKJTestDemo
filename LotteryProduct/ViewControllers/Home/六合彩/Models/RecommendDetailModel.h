//
//  RecommendDetailModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/18.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LhcXsRecommendContent;
@class ContentDTOList;
@interface RecommendDetailModel : NSObject

@property (nonatomic , assign) NSInteger              ID;

@property (nonatomic, copy) NSString *isOwn;

@property (nonatomic, copy) NSString *locked;
@property (nonatomic, assign)BOOL replyViewFlag;//回复可见 1:是，0:否


@property (nonatomic , copy) NSString              * qrCode;
@property (nonatomic , strong) NSArray<ContentDTOList *>              * contentDTOList;
@property (nonatomic , assign) NSInteger              realViews;
@property (nonatomic , copy) NSString              * referrer;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * heads;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * wxh;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * content;
//@property (nonatomic, copy) NSString                *realAdmire;
@property (nonatomic, copy) NSString                *totalAdmire;
@property (nonatomic, assign)NSInteger fansNumber;
@property (nonatomic, copy) NSString *parentMemberId;
@property (nonatomic, copy) NSString *referrerId;
@property (nonatomic, copy) NSString *alreadyFllow;
//@property (nonatomic, assign)BOOL replyVisable;



@property (nonatomic, assign)NSInteger                qrShow;


@property (nonatomic, assign)CGFloat rowHeight;

@property (nonatomic, assign)CGFloat headerHeight;


+(CGFloat)heightForRowWithisShow:(RecommendDetailModel *)model;

+ (CGFloat)heightForHeader:(RecommendDetailModel *)model;

@end

@interface ContentDTOList :NSObject
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , assign) NSInteger              recommendId;
@property (nonatomic , copy) NSString              * play;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , strong) LhcXsRecommendContent              * lhcXsRecommendContent;
@property (nonatomic , copy) NSString              * sg;
@property (nonatomic , copy) NSString              * issue;

@end

@interface LhcXsRecommendContent :NSObject
//@property (nonatomic , copy) NSString              * number;
@property (nonatomic , assign) NSInteger              recommendId;
@property (nonatomic , copy) NSString              * deleted;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * issue;
@property (nonatomic , copy) NSString              * play;
@property (nonatomic , copy) NSString              * sg;
@property (nonatomic , copy) NSString              * createTime;




@end


