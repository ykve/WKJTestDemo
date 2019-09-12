//
//  LiuHeTukuListModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuHeTukuListModel : NSObject

//"parentName" : "",
//"id" : 255,
//"createTime" : "",
//"parentId" : 0,
//"name" : "白小姐龙虎斗",
//"sort" : 1
@property (nonatomic, copy) NSString *parentName;
@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *ID;




@end

NS_ASSUME_NONNULL_END
