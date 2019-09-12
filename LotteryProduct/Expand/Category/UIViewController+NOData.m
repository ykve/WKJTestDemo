//
//  UIViewController+NOData.m
//  ICSON_Y
//
//  Created by young on 16/1/14.
//  Copyright © 2016年 young. All rights reserved.
//

#import "UIViewController+NOData.h"
#import <objc/runtime.h>
static void *noDataTipsKey      =   (void *)@"noDataTipsKey";
static void *noDataTipsViewKey  =   (void *)@"noDataTipsViewKey";
static void *noDataCallBackKey        =   (void *)@"noDataCallBackKey";


static UIView *tipsView = nil;

@implementation UIViewController (NOData)


- (BOOL)showNoDataTips{
    id show = objc_getAssociatedObject(self, noDataTipsKey);
    return [show boolValue];
}

- (void)setShowNoDataTips:(BOOL)showNoDataTips{
    objc_setAssociatedObject(self, noDataTipsKey, @(showNoDataTips), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (showNoDataTips){
        self.noDataTipsView.hidden = NO;
        self.noDataImagev.hidden = NO;
    }else{
        self.noDataTipsView.hidden = YES;
        self.noDataImagev.hidden = YES;
    }
}

- (UIImageView *)noDataImagev{
    
    return objc_getAssociatedObject(self, @selector(noDataImagev));
}

-(void)setNoDataImagev:(UIImageView *)noDataImagev {
    
    objc_setAssociatedObject(self, @selector(noDataImagev), noDataImagev, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.noDataCallBack){
        self.noDataCallBack();
    }
}

#pragma mark - Property noDataTipsView
- (UIView *)noDataTipsView{
    UIView *noDataTipsView = objc_getAssociatedObject(self, noDataTipsViewKey);
    noDataTipsView.hidden = !self.showNoDataTips;
    if ([noDataTipsView isKindOfClass:[UIView class]]){
        return noDataTipsView;
    }
    if (self.showNoDataTips == NO) {
        
        return nil;
    }
    CGRect bounds = self.view.bounds;
    
    UIView *noDataview = [[UIView alloc]initWithFrame:CGRectMake((bounds.size.width - 128)*0.5, (bounds.size.height - 128) * 0.5, 150, 180)];
    noDataview.userInteractionEnabled = NO;
    UIImage *nodata = [UIImage imageNamed:@"empty"];
    
    self.noDataImagev = [[UIImageView alloc]initWithImage:nodata];
    self.noDataImagev.contentMode = UIViewContentModeScaleAspectFit;
    self.noDataImagev.frame = CGRectMake(0, 0, 150, 150);
    [noDataview addSubview:self.noDataImagev];
    
    UILabel *noDataTipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 128, 20)];
    noDataTipsLabel.textAlignment = NSTextAlignmentCenter;
    noDataTipsLabel.text = @"空空如也~~";
    
   
//    [noDataview addSubview:noDataTipsLabel];
    [self setNoDataTipsView:noDataview];
    [self.view bringSubviewToFront:noDataview];
    return noDataview;
}

- (void)setNoDataTipsView:(UIView *)noDataTipsView{
    objc_setAssociatedObject(self, noDataTipsViewKey, noDataTipsView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    noDataTipsView.userInteractionEnabled = YES;
    noDataTipsView.hidden = YES;
    [noDataTipsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    [self.view insertSubview:noDataTipsView atIndex:0];
}

#pragma mark - Property callBack
- (void (^)())noDataCallBack{
    return objc_getAssociatedObject(self, noDataCallBackKey);
}

- (void)setNoDataCallBack:(void (^)())noDataCallBack{
    objc_setAssociatedObject(self, noDataCallBackKey, noDataCallBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
