//
//  UIImageView+Wifi.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "UIImageView+Wifi.h"

@implementation UIImageView (Wifi)

-(void)loadimageWithurl:(NSURL *)url{
    
    BOOL wifi = [Person person].onlywifi;
    
    //    NSString *urlStr = [url absoluteString];
    //    //读缓存，先从磁盘中或内存中读取
    [[SDImageCache sharedImageCache] setShouldGroupAccessibilityChildren:NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
    //
    //    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    //    if (originalImage)
    //    {//已经加载过有缓存，直接显示，无需判断网络状态
    ////        self.image = [Tools compressImageWith:originalImage];
    //        newimage([Tools compressImageWith:originalImage]);
    //    }
    //    else
    //    {//利用网络监测判断网络
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    if ( reachability.isReachableViaWiFi)
    {//WiFi网络下下载原图
        //            [self sd_setImageWithURL:url placeholderImage:NOPHOTO options:SDWebImageRefreshCached];
        [self sd_setImageWithURL:url placeholderImage:NOPHOTO options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            self.image = [Tools compressImageWith:image];
        }];
        //            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //
        //            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        //
        //                newimage([Tools compressImageWith:image]);
        //
        //            }];
        
    }
    else
    {//手机自带网络
        if (wifi)//手机自带网络，
        {//仅WiFi网络下载图片开关打开
            //                newimage(NOPHOTO);
            self.image = NOPHOTO;
        }
        else//非wifi网络也可以下载图片
        {
            //                [self sd_setImageWithURL:url placeholderImage:NOPHOTO options:SDWebImageRefreshCached];
            [self sd_setImageWithURL:url placeholderImage:NOPHOTO options:SDWebImageRefreshCached completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                self.image = [Tools compressImageWith:image];
            }];
            //                [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:url options:SDWebImageDownloaderContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            //
            //                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            //
            //                    newimage([Tools compressImageWith:image]);
            //
            //                }];
        }
        
//    }
    
        }
    
}
@end

