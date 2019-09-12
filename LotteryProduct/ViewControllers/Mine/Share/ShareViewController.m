//
//  ShareViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ShareViewController.h"
#import <UIKit/UIKit.h>
#import "CPTInfoManager.h"
@interface ShareViewController ()
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *qrImgView;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
@property (weak, nonatomic) IBOutlet UIButton *copButton;

@property (nonatomic, copy) NSString *shareUrl;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"分享好友";
    self.view.backgroundColor = [UIColor colorWithHex:@"f4f4f4"];
    self.backView.backgroundColor = MAINCOLOR;
    self.topMargin.constant = 40;
    self.copButton.backgroundColor = BASECOLOR;
    self.copButton.layer.cornerRadius = 5;
    self.copButton.layer.masksToBounds = YES;
    
    UIImage *qrcode = [Tools generateQRCode:@"http://t.cn/EqhCB3v" width:150 height:150];
    self.qrImgView.image = qrcode;
    @weakify(self)
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if(isSuccess){
            @strongify(self)
            self.shareUrl = model.shareUrl;
            self.urlLabel.text = model.shareUrl;
            UIImage *qrcode = [Tools generateQRCode:model.shareUrl width:150 height:150];
            self.qrImgView.image = qrcode;
        }
    }];
}
#pragma mark 复制地址
- (IBAction)copyUrl:(UIButton *)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.urlLabel.text;
    [MBProgressHUD showSuccess:@"复制成功"];
}

- (IBAction)shareToThird:(UIButton *)sender {
    
    if (sender.tag == 10) {//QQ好友
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ sender:sender];
        
    }else if (sender.tag == 20){//微信好友
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession sender:sender];
    } else if (sender.tag == 30){//微信朋友圈
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine sender:sender];
    }
}
    
    

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType sender:(UIButton *)sender
    {
        
        UIImage *image = [UIImage imageNamed:@"share"];

        
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象

        UMShareWebpageObject *shareObject;
        if ([AppDelegate shareapp].wkjScheme == Scheme_LotterEight) {
            shareObject = [UMShareWebpageObject shareObjectWithTitle:@"008" descr:@"多彩种,多玩法\n更全面的资讯信息\n更精准的开奖数据" thumImage:image];
        } else if([AppDelegate shareapp].wkjScheme == Scheme_LotterHK){
            shareObject = [UMShareWebpageObject shareObjectWithTitle:@"XGCP" descr:@"知道越多,赢得越多\n最权威的资讯平台\n算法精准,数据稳定,开奖及时" thumImage:image];
        } else if([AppDelegate shareapp].wkjScheme == Scheme_LitterFish){
            shareObject = [UMShareWebpageObject shareObjectWithTitle:@"小鱼儿" descr:@"知道越多,赢得越多\n最权威的资讯平台\n算法精准,数据稳定,开奖及时" thumImage:image];
        } else{
            shareObject = [UMShareWebpageObject shareObjectWithTitle:@"CPT" descr:@"知道越多,赢得越多\n最权威的资讯平台\n算法精准,数据稳定,开奖及时" thumImage:image];
        }
        //设置网页地址
        shareObject.webpageUrl = self.shareUrl;
        
        if (!self.shareUrl) {
            [MBProgressHUD showMessage:@"分享地址为空"];
            return;
        }
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
                if ([error.userInfo[@"message"] isEqualToString:@"APP Not Install"]) {
                    if (sender.tag == 10) {
                        [MBProgressHUD showMessage:@"您没有安装该QQ应用"];
                    }else{
                        [MBProgressHUD showMessage:@"您没有安装该微信应用"];
                    }
                }
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }

@end
