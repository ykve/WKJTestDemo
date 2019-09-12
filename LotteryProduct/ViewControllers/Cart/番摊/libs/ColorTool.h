//
//  ColorTool.h
//  GameCenter
//
//  Created by allen on 2018/10/9.
//  Copyright © 2018年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorTool : NSObject
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)getImageTileModeWithImgName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
