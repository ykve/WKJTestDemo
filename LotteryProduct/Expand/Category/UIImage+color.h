//
//  UIImage+color.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (color)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
- (UIImage *)circleImage;
+ (CGSize)getImageSizeWithURL:(id)URL;

+ (UIImage *)stretchableWithImageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
