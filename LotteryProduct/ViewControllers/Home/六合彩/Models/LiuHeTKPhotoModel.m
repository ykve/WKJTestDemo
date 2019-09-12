//
//  LiuHeTKPhotoModel.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTKPhotoModel.h"

@implementation LiuHeTKPhotoModel

+(NSDictionary*)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"comments":@"LiuHeTKRemarkModel"};
}

@end
