//
//  ThumbnailView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol delimgvDelegate;

@interface ThumbnailView : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconimgv;

@property (nonatomic, strong) UIButton *delBtn;

@property (nonatomic, assign) id<delimgvDelegate>delegate;

@property (nonatomic, assign) NSInteger index;

@end

@protocol delimgvDelegate <NSObject>

-(void)delegeimageWithindex:(NSInteger)index With:(UIView *)Thumbnail;

@end
