//
//  LiveListModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveListModel : NSObject
@property (nonatomic,copy) NSString *type1;
@property (nonatomic,copy) NSString *type1Value;
@property (nonatomic,copy) NSString *type1Win;

@property (nonatomic,copy) NSString *type2;
@property (nonatomic,copy) NSString *type2Value;
@property (nonatomic,copy) NSString *type2Win;

@property (nonatomic,copy) NSString *type3;
@property (nonatomic,copy) NSString *type3Value;
@property (nonatomic,copy) NSString *type3Win;

@property (nonatomic,copy) NSString *type4;
@property (nonatomic,copy) NSString *type4Value;
@property (nonatomic,copy) NSString *type4Win;

@property (nonatomic,copy) NSString *type5;
@property (nonatomic,copy) NSString *type5Value;
@property (nonatomic,copy) NSString *type5Win;

@property (nonatomic,copy) NSString *issue;

@end

NS_ASSUME_NONNULL_END
