//
//  LiuHeTKPhotoModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiuHeTKRemarkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiuHeTKPhotoModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *issue;
@property (nonatomic, copy) NSString *lastIssue;
@property (nonatomic, copy) NSString *nextIssue;
@property (nonatomic, copy) NSString *section;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *photoid;
@property (nonatomic, strong) NSArray<LiuHeTKRemarkModel*> *comments;

@end

NS_ASSUME_NONNULL_END
