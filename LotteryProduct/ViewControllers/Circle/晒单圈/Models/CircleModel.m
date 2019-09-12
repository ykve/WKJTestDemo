//
//  CircleModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CircleModel.h"

@implementation CircleModel

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"postCommentsVOList":@"PostCommentsVOList"};
}
@end

@implementation CirclePost

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

-(void)setImage:(NSString *)image {
    
    _image = image;
    
    self.imageurlArray = [image componentsSeparatedByString:@","];
}
@end
@implementation PostMember

@end
@implementation PostCommentsVOList

@end
