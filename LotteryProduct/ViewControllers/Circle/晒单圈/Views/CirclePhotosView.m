//
//  CirclePhotosView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CirclePhotosView.h"

#import <FLAnimatedImage/FLAnimatedImageView.h>
#import "UIImageView+Wifi.h"
#import <YYWebImage.h>
@interface CirclePhotosView () <HZPhotoBrowserDelegate>

@end
@implementation CirclePhotosView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)setImageurlArray:(NSArray *)imageurlArray {
    
    _imageurlArray = imageurlArray;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    WS(weakSelf);

    for (NSInteger i = 0; i< imageurlArray.count; i++) {
        
        @autoreleasepool {
            
            UIImageView *imgv = [[UIImageView alloc]init];
            imgv.contentMode = UIViewContentModeScaleAspectFill;
            imgv.layer.masksToBounds = YES;
            imgv.tag = 100 + i;
//            imgv.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imgv];

            //            UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
            //            act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            //            [imgv addSubview:act];
            //            [act mas_makeConstraints:^(MASConstraintMaker *make) {
            //
            //                make.edges.equalTo(imgv);
            //            }];
            //            [act startAnimating];
//            [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i]) placeholder:NOPHOTO];
   
            
//            imgv.yy_imageURL = IMAGEPATH(imageurlArray[i]);
//            [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i]) options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
//            [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i])  options:YYWebImageOptionProgressive];

            BOOL wifiOpen = [Person person].onlywifi;
            
            AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
            
            if (wifiOpen) {//WiFi 加载,流量不加载打开
                
                if (reachability.reachableViaWiFi) {
                    
                    [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i]) placeholder:NOPHOTO];
                    
                }else{
                    
                    imgv.image = IMAGE(@"img_cqjz");
                    
                    [imgv longtapHandle:^{
                        [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i]) placeholder:NOPHOTO];
                    }];
                }
                
            }else{
                
                if (self.LiuHePhoto) {
                    [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i]) placeholder:IMAGE(@"sixphoto")];
                }else{
                    [imgv yy_setImageWithURL:IMAGEPATH(imageurlArray[i]) placeholder:NOPHOTO];
                }
            }
                

//            [imgv loadimageWithurl:IMAGEPATH(imageurlArray[i])];
            [imgv tapHandle:^{
                //启动图片浏览器
                HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
                browser.isFullWidthForLandScape = YES;
                browser.isNeedLandscape = YES;
                browser.sourceImagesContainerView = weakSelf; // 原图的父控件
                browser.currentImageIndex = i;
                browser.imageCount = weakSelf.imageurlArray.count; // 图片总数
                browser.delegate = weakSelf;
                [browser show];
            }];
        }
    }
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat photoW,photoH;
    
    
    if (self.LiuHePhoto) {
        photoH = self.height;
        photoW = self.width;
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.frame = CGRectMake(0, 0, photoW, photoH);
        }];
        return;
    }
    
    if (self.subviews.count == 0) {
        
        photoH = 0;
        photoW = 0;
    }
    else if (self.subviews.count == 1) {
        
        photoH = (SCREEN_WIDTH - 74)/2;
        photoW = (SCREEN_WIDTH - 74)/2;
    }
    else {
        photoW = ((SCREEN_WIDTH - 74) - (3 - 1) * 10) / 3;
        photoH = photoW;
    }
    __block CGFloat x = 0;
    __block CGFloat y = 0;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger col = idx % 3;
        NSInteger row = idx / 3;
        
        x = col * (photoW + 10);
        y = row * (photoH + 10);
        
        obj.frame = CGRectMake(x, y, photoW, photoH);
    }];
}

+ (CGSize)sizeWithImages:(NSArray *)images width:(CGFloat)width andMargin:(CGFloat)margin {
    
    CirclePhotosView *photoView = [[CirclePhotosView alloc] init];
    
    NSInteger count = images.count;
    
    if (count == 0) {
        
        return CGSizeZero;
    }
    
    if (photoView.LiuHePhoto) {
        return photoView.size;
    }
    
    
    CGFloat photoW = (width - (3 - 1) * margin) / 3;
    CGFloat photoH = photoW;
    
    CGFloat photosW = 0;
    CGFloat photosH = 0;
    
    if (count == 1) {
        photosW = width/2;
        photosH = width/2;
    }else {
        NSInteger cols = 3;
        NSInteger rows = (count + cols - 1) / cols;
        
        photosW = photoW * cols + (cols - 1) * margin;
        photosH = photoH * rows + (rows - 1) * margin;
    }
    
    return CGSizeMake(photosW, photosH);
}


#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    FLAnimatedImageView *imageView = (FLAnimatedImageView *)self.subviews[index];
    return imageView.image;
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.imageurlArray[index];
    return [NSURL URLWithString:urlStr];
}

@end
