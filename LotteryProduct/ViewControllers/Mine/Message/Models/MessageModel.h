//
//  MessageModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * categoryName;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , assign) NSInteger              rollStatus;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , assign) NSInteger              newest;
@property (nonatomic , copy) NSString              * issueTime;
@property (nonatomic , copy) NSString              * appNoticeCategoryList;
@property (nonatomic , copy) NSString              * endDate;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * startDate;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              categoryId;
@property (nonatomic , assign) NSInteger              popup;

@end
