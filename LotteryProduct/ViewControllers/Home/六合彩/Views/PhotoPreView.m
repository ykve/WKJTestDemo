//
//  PhotoPreView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PhotoPreView.h"
#import "VersionsPickerView.h"
#import "ShareView.h"
@implementation PhotoPreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.yearBtn setImagePosition:WPGraphicBtnTypeRight spacing:4];
    [self.versionBtn setImagePosition:WPGraphicBtnTypeRight spacing:4];
    self.backgroundColor = WHITE;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _overlayView.alpha = 0.3;
    _scrollView.delegate = self;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _scrollView.maximumZoomScale = 5.0;
    _scrollView.minimumZoomScale = 1;
    [_scrollView setZoomScale:1];
   
}

+(PhotoPreView *)share {
    
    PhotoPreView *pre = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([PhotoPreView class]) owner:self options:nil]firstObject];
    
    pre.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, (SCREEN_WIDTH - 30)*1.64);
    
    return pre;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return _sImgView;
}     // return a view that will be scaled. if delegate returns nil, nothing happens

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _sImgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                   scrollView.contentSize.height * 0.5 + offsetY);
}


- (IBAction)yearClick:(UIButton *)sender {
    
    [self showversion];
}

- (IBAction)versionClick:(UIButton *)sender {
    
    [self showversion];
}
- (IBAction)dismissClick:(UIButton *)sender {
    
    [self fadeOut];
}

- (IBAction)shareClick:(UIButton *)sender {
    
    ShareView *share = [ShareView share];
    
    [share show];
}

-(void)showversion {
    
    VersionsPickerView *picker = [VersionsPickerView share];
    [picker setpicker];

    picker.datas = self.dataArray;
    
    picker.VersionBlock = ^(NSString *time, NSString *version, NSString *url) {
        
        [self.yearBtn setTitle:time forState:UIControlStateNormal];
        [self.versionBtn setTitle:version forState:UIControlStateNormal];
        
        UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        testActivityIndicator.center = self.sImgView.center;//只能设置中心，不能设置大小
        
        [self.sImgView addSubview:testActivityIndicator];
        
        [testActivityIndicator startAnimating]; // 开始旋转
        
        [self.sImgView sd_setImageWithURL:IMAGEPATH(url) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [testActivityIndicator stopAnimating]; // 结束旋转
            [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
        }];
    };
    
    [picker show];
}

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self removeFromSuperview];
            [_overlayView removeFromSuperview];
        }
    }];
}

-(void)show:(NSArray<PhotoModel *> *) datas
{
    self.dataArray = datas;
    
    PhotoModel *model = datas.lastObject;
    
    [self.yearBtn setTitle:model.year forState:UIControlStateNormal];
    [self.versionBtn setTitle:model.photoList.lastObject.issue forState:UIControlStateNormal];
    
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    testActivityIndicator.center = self.sImgView.center;//只能设置中心，不能设置大小
    
    [self.sImgView addSubview:testActivityIndicator];

    [testActivityIndicator startAnimating]; // 开始旋转
   
    [self.sImgView sd_setImageWithURL:IMAGEPATH(model.photoList.lastObject.url) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [testActivityIndicator stopAnimating]; // 结束旋转
        [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    }];
    
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2);
    
    
    [self fadeIn];
}

-(void)dismiss {
    
//    [self fadeOut];
}

@end
