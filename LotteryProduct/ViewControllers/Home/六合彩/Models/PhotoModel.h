//
//  PhotoModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoListModel;

@interface PhotoModel : NSObject

@property (nonatomic, copy) NSString *year;

@property (nonatomic, strong) NSArray <PhotoListModel *> *photoList;

@end

@interface PhotoListModel : NSObject

@property (nonatomic, copy) NSString *issue;

@property (nonatomic, copy) NSString *url;

@end
