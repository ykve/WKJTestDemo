//
//  CPTSixModel.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CPTSixPlayTypeModel;

NS_ASSUME_NONNULL_BEGIN

@interface CPTSixModel : NSObject
@property (nonatomic, strong) NSArray <CPTSixPlayTypeModel *> * playTypes;
@property (nonatomic, assign) NSInteger  endTime;//封盘时间

@end

NS_ASSUME_NONNULL_END

@class CPTSixsubPlayTypeModel;

NS_ASSUME_NONNULL_BEGIN

@interface CPTSixPlayTypeModel : NSObject
@property (nonatomic, copy) NSString * playType;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) NSNumber * ID;
@property (nonatomic, copy) NSString * superType;

@property (nonatomic, copy) NSString * example;
@property (nonatomic, copy) NSString * exampleNum;
@property (nonatomic, copy) NSString * playRemark;
@property (nonatomic, copy) NSString * playRemarkSx;
@property (nonatomic , assign) NSNumber * categoryId;

@property (nonatomic, strong) NSArray<CPTSixsubPlayTypeModel *> * subTypes;
@end

NS_ASSUME_NONNULL_END

@class CPTBuyBallModel;

NS_ASSUME_NONNULL_BEGIN

@interface CPTSixsubPlayTypeModel : NSObject
@property (nonatomic, copy) NSString * subPlayType;
@property (nonatomic, strong) NSArray * numberCellInSection;
@property (nonatomic, strong) NSArray<CPTBuyBallModel*> * balls;
@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyBallModel : NSObject
@property (nonatomic, copy) NSString *ID;//caizhong
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *numbers;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *longS;
@property (nonatomic, copy) NSString *superKey;//typeid
@property (nonatomic, copy) NSNumber *uiType;
@property (nonatomic, copy) NSString *superPlayKey;//
@property (nonatomic, assign) NSInteger settingId;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign)NSIndexPath *modelLocation;


@property (nonatomic, strong) NSArray *redBallArr;
@property (nonatomic, strong) NSArray *blueBallArr;

@end

NS_ASSUME_NONNULL_END
