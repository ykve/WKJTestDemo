//
//  TouPiaoModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouPiaoModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *selectIcon;
@property (nonatomic, copy) NSString *voteCount;
@property (nonatomic, copy) NSString *voteNum;
@property (nonatomic, copy) NSString *ID;


//"voteCount" : 777706,
//"icon" : "http:\/\/static.zk01.cc\/image\/ad-photo\/2019-02-27\/2fb79c99-6a7d-43f4-b0a5-7ae541b0cf98.png",
//"voteNum" : "58524",
//"selectIcon" : "http:\/\/static.zk01.cc\/image\/ad-photo\/2019-02-27\/05674de0-37d6-4217-9147-e0a2aa116aa6.png",
//"name" : "兔"

@end

//@interface TouPiaoItemModel : NSObject
//
//@property (nonatomic, copy) NSString *name;
//
//@property (nonatomic, copy) NSString *icon;
//
//@property (nonatomic, copy) NSString *selectIcon;
//
//
//@end

NS_ASSUME_NONNULL_END
