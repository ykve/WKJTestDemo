//
//  RemarkListModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemarkListModel : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *heads;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *nickname;

@end

NS_ASSUME_NONNULL_END
