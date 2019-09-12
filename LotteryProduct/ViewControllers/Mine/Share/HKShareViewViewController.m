//
//  HKShareViewViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/3/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "HKShareViewViewController.h"
#import "CPTInfoManager.h"
@interface HKShareViewViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginToTop;
@property (weak, nonatomic) IBOutlet UIImageView *seperatotLineImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginToQQBtn;

@property (weak, nonatomic) IBOutlet UIView *inviteCodeView;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *shareUrlLabel;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qrImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qrImageViewW;

@property (nonatomic, copy) NSString *shareUrl;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numbrLbls;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToShareLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToCopyBtnMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineToCopyBtnMaigon;

@property (weak, nonatomic) IBOutlet UIImageView *mainBackImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *inviteImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainImageBottonMargin;
@property (weak, nonatomic) IBOutlet UIButton *QQBtn;
@property (weak, nonatomic) IBOutlet UIButton *PYQBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UILabel *shareToLbl;

@end

// title分享好友
@implementation HKShareViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"分享好友";
    
    if (IS_IPHONEX) {
        self.navHeight.constant = NAV_HEIGHT - 45;
        self.mainImageBottonMargin.constant = - 35;
    }else{
        self.navHeight.constant = NAV_HEIGHT - 20;
    }
    
    if (SCREEN_HEIGHT > 667) {
        self.marginToQQBtn.constant = 10;
        self.marginToTop.constant = 80;
        self.qrImageViewHeight.constant = 134;
        self.qrImageViewW.constant = 134;
    }else if (SCREEN_HEIGHT > 568){
        self.marginToQQBtn.constant = 5;
        self.marginToTop.constant = 65;
        self.qrImageViewHeight.constant = 100;
        self.qrImageViewW.constant = 100;
    }else{
        self.marginToQQBtn.constant = 5;
        self.marginToTop.constant = 40;
        self.qrImageViewHeight.constant = 80;
        self.qrImageViewW.constant = 80;
        self.topToShareLabel.constant = 10;
        self.topToCopyBtnMargin.constant = 10;
        self.lineToCopyBtnMaigon.constant = 10;
    }
    
    self.mainBackImageView.image = [[CPTThemeConfig shareManager] shareMainImage];
    
    self.backImageView.image = [[CPTThemeConfig shareManager] shareBackImage];
    
    self.inviteImageView.image = [[CPTThemeConfig shareManager] shareInviteImage];
    self.seperatotLineImage.image = [[CPTThemeConfig shareManager] shareLineImage];
    self.bottomLine.image = [[CPTThemeConfig shareManager] shareLineImage];
    [self.QQBtn setImage:[[CPTThemeConfig shareManager] shareVcQQImage] forState:UIControlStateNormal];
    [self.wechatBtn setImage:[[CPTThemeConfig shareManager] shareVcWeChatImage] forState:UIControlStateNormal];
    [self.PYQBtn setImage:[[CPTThemeConfig shareManager] shareVcPYQImage] forState:UIControlStateNormal];
    self.shareToLbl.textColor = [[CPTThemeConfig shareManager] shareToLblTextColor];

    
    self.addressBtn.backgroundColor = [[CPTThemeConfig shareManager] shareVcCopyBtnBackgroundColor];
    self.addressBtn.layer.cornerRadius = 14;
    self.addressBtn.layer.masksToBounds = YES;
    [self.addressBtn setTitleColor:[[CPTThemeConfig shareManager] ShareCopyBtnTitleColor] forState:UIControlStateNormal];
    
//    UIImage *qrcode = [Tools generateQRCode:@"http://t.cn/EqhCB3v" width:150 height:150];
    
//    self.qrCodeImageView.image = qrcode;
    [self getShareUrl];
    [self getPersonData];
}

- (void)getShareUrl{
    @weakify(self)
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if(isSuccess){
            @strongify(self)
            self.shareUrl = model.shareUrl;
            self.shareUrlLabel.text = model.shareUrl;
            UIImage *qrcode = [Tools generateQRCode:model.shareUrl width:150 height:150];
            self.qrCodeImageView.image = qrcode;
        }
    }];
}

-(void)getPersonData {
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/myAccount.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        [[Person person] setupWithDic:data.data];
        
        [self buildInviteBtns];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)addBorderToLayer:(UIView *)view{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = [UIColor colorWithHex:@"43464f"].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    border.frame = view.bounds;
    border.lineWidth = .6f;
    border.lineCap = @"square";
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@9, @4];
    [view.layer addSublayer:border];
}

- (void)buildInviteBtns{
    
    NSString *inviteCode = [Person person].promotionCode;

    if (inviteCode.length <= 6) {
        return;
    }
    for (UILabel *lbl in self.numbrLbls) {
        [self addBorderToLayer:lbl];
        lbl.text = [inviteCode substringWithRange:NSMakeRange(lbl.tag - 1, 1)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont boldSystemFontOfSize:20];
        lbl.textColor = [UIColor colorWithHex:@"fd614a"];
        
    }
}

- (IBAction)shareToThirdPart:(UIButton *)sender {//10 QQ 20微信 30 朋友圈
    
    if (sender.tag == 10) {//QQ好友
        
        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ sender:sender];
        
    }else if (sender.tag == 20){//微信好友
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession sender:sender];
    } else if (sender.tag == 30){//微信朋友圈
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine sender:sender];
    }
}


- (IBAction)addressCopy:(UIButton *)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.shareUrlLabel.text;
    [MBProgressHUD showSuccess:@"复制成功"];
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
