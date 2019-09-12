//
//  ColorTool.m
//  GameCenter
//
//  Created by allen on 2018/10/9.
//  Copyright © 2018年 allen. All rights reserved.
//

#import "ColorTool.h"

@implementation ColorTool

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)getImageTileModeWithImgName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    return image;
}

@end
