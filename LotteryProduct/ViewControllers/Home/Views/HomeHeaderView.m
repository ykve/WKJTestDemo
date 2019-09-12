//
//  HomeHeaderView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *headerSeperatorLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIButton *xinshuituijianBtn;
@property (weak, nonatomic) IBOutlet UIButton *liuhetongjiBtn;
@property (weak, nonatomic) IBOutlet UIButton *chaxunzhushouBtn;
@property (weak, nonatomic) IBOutlet UIButton *gongshishashouBtn;

@property (weak, nonatomic) IBOutlet UIButton *liuhetukuBtn;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UIView *topSepetatorLine;
@property (weak, nonatomic) IBOutlet UIImageView *hotNewsImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomSeperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *remindLbl;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numbrLables;
@property (weak, nonatomic) IBOutlet UIView *hotNewsBackView;

@property (weak, nonatomic) IBOutlet UILabel *hoeNewsLbl;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@property (weak, nonatomic) IBOutlet UIButton *zhiboKJbtn;
@property (weak, nonatomic) IBOutlet UIButton *lskjBtn;
@property (weak, nonatomic) IBOutlet UIButton *cxzsBtn;
@property (weak, nonatomic) IBOutlet UIButton *zxtjBtn;

@property (weak, nonatomic) IBOutlet UIImageView *hotICon;


@end

@implementation HomeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UILabel *lbl in self.numbrLables) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_NumbrLables_Text];
        if([lbl.text isEqualToString:@"心水推荐"]){
            if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
                lbl.text = @"小鱼论坛";
            }
            break;
        }
    }
    

    self.hotNewsBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_News_HotHeadViewBack];

    self.line1.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_News_LineView];
    self.line2.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_News_LineView];

    self.hoeNewsLbl.textColor =  [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_HotMessLabelText] ;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 10;
    
//    self.noticeView.backgroundColor = [UIColor colorWithHex:@"303136"];
    self.remindLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_NoticeView_LabelText];

    self.noticeView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_NoticeView_Back];
    self.noticeView.layer.cornerRadius = 15;
    self.noticeView.layer.masksToBounds = YES;
//    self.seperatorLine.backgroundColor = [UIColor colorWithHex:@"232428"];
    self.topLine.backgroundColor = [UIColor colorWithHex:@"1c1d20"];
    self.bottomLine.backgroundColor = [UIColor colorWithHex:@"3d3e44"];
    self.headerSeperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_NewsBgViewBack];


    self.commentView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_NewsBgViewBack];
    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_Back];
    self.backView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_NewsTopViewBack];

    self.topSepetatorLine.backgroundColor = MAINCOLOR;
    self.bottomSeperatorLine.backgroundColor = [UIColor colorWithHex:@"3d3e44"];
    
//    self.commentView.backgroundColor = [UIColor colorWithRed:35 green:36 blue:40 alpha:1.0];
    self.hotNewsImageView.image = [[CPTThemeConfig shareManager] IM_home_hotNewsImageName];
    [_xinshuituijianBtn setImage:[[CPTThemeConfig shareManager] IM_home_XSTJImage] forState:UIControlStateNormal];
    [_liuhetongjiBtn setImage:[[CPTThemeConfig shareManager] IM_home_LHDSImage] forState:UIControlStateNormal];
    [_chaxunzhushouBtn setImage:[[CPTThemeConfig shareManager] IM_home_LHTKImage] forState:UIControlStateNormal];
    [_gongshishashouBtn setImage:[[CPTThemeConfig shareManager] IM_home_GSSHImage] forState:UIControlStateNormal];
    [_zhiboKJbtn setImage:IMAGE([[CPTThemeConfig shareManager] IC_home_ZBKJImageName]) forState:UIControlStateNormal];
    [_lskjBtn setImage:IMAGE([[CPTThemeConfig shareManager] IC_home_LSKJImageName]) forState:UIControlStateNormal];
    [_cxzsBtn setImage:IMAGE([[CPTThemeConfig shareManager] IC_home_CXZSImageName]) forState:UIControlStateNormal];
    [_zxtjBtn setImage:IMAGE([[CPTThemeConfig shareManager] IM_home_ZXTJImageName]) forState:UIControlStateNormal];

    _xinshuituijianBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _liuhetongjiBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _chaxunzhushouBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _gongshishashouBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _liuhetukuBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _zhiboKJbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _lskjBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _cxzsBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _zxtjBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;


}

- (IBAction)didClickXinShuiTuiJian:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickSixRecommetNews:)]) {
        
        [self.delegate clickSixRecommetNews:sender];
    }
}


@end
