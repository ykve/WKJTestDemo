//
//  CircleModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CirclePost;
@class PostMember;
@class PostCommentsVOList;
@interface CircleModel : NSObject

@property (nonatomic , strong) CirclePost              * circlePost;
@property (nonatomic , strong) PostMember              * postMember;
@property (nonatomic , strong) NSArray<PostCommentsVOList *>              * postCommentsVOList;
@property (nonatomic , assign) BOOL              isOpen;

@end

@interface CirclePost :NSObject
@property (nonatomic , copy) NSString              * account;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * shareOrderStatus;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) NSArray             * imageurlArray;
@property (nonatomic , assign) NSInteger              praiseNumber;
@property (nonatomic , assign) NSInteger              memberId;
@property (nonatomic , copy) NSNumber              * createTime;
@property (nonatomic , assign) NSInteger              replyNumber;
@property (nonatomic , assign) NSInteger                   meHasPraise;
@end

@interface PostMember :NSObject
@property (nonatomic , assign) NSInteger              memberId;
@property (nonatomic , copy) NSString              * heads;
@property (nonatomic , assign) NSInteger              isFocus;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , assign) NSInteger              fansNumber;
@property (nonatomic , assign) NSInteger              focusNumner;
@end

@interface PostCommentsVOList :NSObject
@property (nonatomic , assign) NSInteger              commentsId;
@property (nonatomic , copy) NSString              * commentsHeads;
@property (nonatomic , assign) NSInteger              commentsReplyId;
@property (nonatomic , assign) NSInteger              commentsUid;
@property (nonatomic , copy) NSString              * commentsNickname;
@property (nonatomic , copy) NSString              * commentsReplyNickname;
@property (nonatomic , copy) NSString              * commentsContent;

@end
