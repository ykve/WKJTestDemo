//
//  FootballDetailModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FootballDetailModel : NSObject

@property (nonatomic,assign) NSInteger alreadyFllow;
@property (nonatomic,copy) NSString *commentCount;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *title;
@property (nonatomic , copy) NSMutableAttributedString * htmlTitle;
@property (nonatomic , copy) NSMutableAttributedString * htmlContent;

@end

NS_ASSUME_NONNULL_END
