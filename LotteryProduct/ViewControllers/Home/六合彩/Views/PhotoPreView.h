//
//  PhotoPreView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"
@interface PhotoPreView : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *versionBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *sImgView;
@property (strong, nonatomic) UIControl *overlayView;
@property (strong, nonatomic) NSArray<PhotoModel *> *dataArray;
+(PhotoPreView *)share;

-(void)show:(NSArray<PhotoModel *> *) datas;



@end
