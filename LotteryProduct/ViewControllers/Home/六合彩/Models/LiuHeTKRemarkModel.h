//
//  LiuHeTKRemarkModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuHeTKRemarkModel : NSObject


//content = 1;
//icon = "";
//id = 52;
//isDelete = 0;
//name = "\U7528\U62378223";
//photoid = 1856;
//photoname = "";
//time = "2019-02-27 21:51:20";

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign)BOOL isDelete;
@property (nonatomic, copy) NSString *photoid;
@property (nonatomic, copy) NSString *photoname;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *name;





@end

NS_ASSUME_NONNULL_END
