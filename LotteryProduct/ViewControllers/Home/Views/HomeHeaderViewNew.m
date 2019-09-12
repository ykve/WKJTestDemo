//
//  HomeHeaderView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeHeaderViewNew.h"
#import "IGKbetModel.h"
#import "NoticeView.h"

@interface HomeHeaderViewNew()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *headerSeperatorLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *topLine;

@property (weak, nonatomic) IBOutlet UIView *topSepetatorLine;
@property (weak, nonatomic) IBOutlet UIImageView *hotNewsImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomSeperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *remindLbl;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numbrLables;
@property (weak, nonatomic) IBOutlet UIView *hotNewsBackView;

@property (weak, nonatomic) IBOutlet UILabel *hoeNewsLbl;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@property (weak, nonatomic) IBOutlet UIScrollView *iconScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageC;
@property (weak, nonatomic) IBOutlet UIView *lhcBg;
@property (weak, nonatomic) IBOutlet UILabel *lhcIssueLab;
@property (weak, nonatomic) IBOutlet UIView *bugHeaderbg;

@property (copy, nonatomic) NSMutableArray<UIButton *> *titleBtnArray;
@property (copy, nonatomic) NSMutableArray<UILabel *> *subTitleArray;
@property (weak, nonatomic)IBOutlet NoticeView *notice;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (weak, nonatomic) IBOutlet UIView *dfffff;

@property (weak, nonatomic) IBOutlet UIImageView *headlineImg;
@property (weak, nonatomic) IBOutlet UIView *newsMidLineView;

@property (weak, nonatomic) IBOutlet UIView *lineyyView;
@property (weak, nonatomic) IBOutlet UIView *mengbanView;

// 没有使用
@property (weak, nonatomic) IBOutlet UIButton *zhiboKJbtn;
@property (weak, nonatomic) IBOutlet UIButton *lskjBtn;
@property (weak, nonatomic) IBOutlet UIButton *cxzsBtn;
@property (weak, nonatomic) IBOutlet UIButton *zxtjBtn;
@property (weak, nonatomic) IBOutlet UIImageView *hotICon;
@property (weak, nonatomic) IBOutlet UIButton *liuhetukuBtn;
@property (weak, nonatomic) IBOutlet UIButton *xinshuituijianBtn;
@property (weak, nonatomic) IBOutlet UIButton *liuhetongjiBtn;
@property (weak, nonatomic) IBOutlet UIButton *chaxunzhushouBtn;
@property (weak, nonatomic) IBOutlet UIButton *gongshishashouBtn;
@property (weak, nonatomic) IBOutlet UIImageView *activityimgv;

@end

@implementation HomeHeaderViewNew

-(NoticeView *)notice {
    
    if (!_notice) {
        _notice.textAlignment = NSTextAlignmentLeft;//默认
        _notice.isHaveTouchEvent = YES;
        _notice.labelFont = [UIFont systemFontOfSize:12];
        _notice.color = [UIColor redColor];
        _notice.time = 4.0f;
        _notice.defaultMargin = 10;
        _notice.numberOfTextLines = 2;
        _notice.edgeInsets = UIEdgeInsetsMake(7, 12,7, 12);
        _notice.clickAdBlock = ^(NSUInteger index){

        };
        _notice.headImg = IMAGE([[CPTThemeConfig shareManager] quanziLaBaImage]);
    }
    return _notice;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_CellBackgroundColor];
    
    if(!_subTitleArray)_subTitleArray = [NSMutableArray array];
    if(!_titleBtnArray)_titleBtnArray = [NSMutableArray array];
    for (UILabel *lbl in self.numbrLables) {
        lbl.textColor = [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_NumbrLables_Text];
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLHCHistory)];
    [self.lhcBg addGestureRecognizer:tap];
    self.lhcBg.backgroundColor = self.iconScroll.backgroundColor = CLEAR;
    self.lhcIssueLab.textColor = [UIColor hexStringToColor:@"999999"];
    self.iconScroll.userInteractionEnabled =YES;
    self.touTiaoBg.backgroundColor = CLEAR;
    self.iconScroll.delegate  = self;

    self.hotNewsBackView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_News_HotHeadViewBack];

    self.remindLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_News_HeadTitleText];
    self.line1.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    self.line2.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    
    self.lineyyView.backgroundColor = [UIColor redColor];
//     [self bringSubviewToFront:self.lineyyView];
    
    self.hoeNewsLbl.textColor =  [[CPTThemeConfig shareManager] CO_Home_VC_HeadView_HotMessLabelText];
    self.headlineImg.image = [[CPTThemeConfig shareManager] IM_Home_HeadlineImg];
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish && [[AppDelegate shareapp] sKinThemeType]== SKinType_Theme_Dark){
//        [self.headlineImg mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.offset(49);
//
//        }];
    }
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 10;
    
    self.dfffff.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_NoticeView_Back];
//    self.mengbanView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_NoticeView_Back];
    self.mengbanView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    
    // 单边圆角或者单边框
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bugHeaderbg.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(10,10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.bugHeaderbg.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.bugHeaderbg.layer.mask = maskLayer;
//    self.bugHeaderbg.layer.masksToBounds = YES;
    
    

    self.bugHeaderbg.backgroundColor = self.touTiaoBg.backgroundColor = self.noticeView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_NoticeView_Back];
    self.noticeView.layer.cornerRadius = 15;
    self.noticeView.layer.masksToBounds = YES;

    
//    self.bugHeaderbg.backgroundColor = [UIColor redColor];
    
    
    self.newsMidLineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    self.topLine.backgroundColor = [UIColor colorWithHex:@"1c1d20"];
    self.bottomLine.backgroundColor = [UIColor colorWithHex:@"3d3e44"];
    
    self.headerSeperatorLine.backgroundColor = [UIColor redColor];
    self.commentView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_NewsBgViewBack];
    self.backView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_NewsTopViewBack];

    self.topSepetatorLine.backgroundColor = MAINCOLOR;
    self.bottomSeperatorLine.backgroundColor = [UIColor colorWithHex:@"3d3e44"];

    
    self.hotNewsImageView.image = [[CPTThemeConfig shareManager] IM_home_hotNewsImageName];
    self.topBg.backgroundColor = self.hotNewsBackView.backgroundColor;
//    [_xinshuituijianBtn setImage:[[CPTThemeConfig shareManager] IM_home_XSTJImage] forState:UIControlStateNormal];
//    [_liuhetongjiBtn setImage:[[CPTThemeConfig shareManager] IM_home_LHDSImage] forState:UIControlStateNormal];
//    [_chaxunzhushouBtn setImage:[[CPTThemeConfig shareManager] IM_home_LHTKImage] forState:UIControlStateNormal];
//    [_gongshishashouBtn setImage:[[CPTThemeConfig shareManager] IM_home_GSSHImage] forState:UIControlStateNormal];
//    [_zhiboKJbtn setImage:IMAGE([[CPTThemeConfig shareManager] IC_home_ZBKJImageName]) forState:UIControlStateNormal];
//    [_lskjBtn setImage:IMAGE([[CPTThemeConfig shareManager] IC_home_LSKJImageName]) forState:UIControlStateNormal];
//    [_cxzsBtn setImage:IMAGE([[CPTThemeConfig shareManager] IC_home_CXZSImageName]) forState:UIControlStateNormal];
//    [_zxtjBtn setImage:IMAGE([[CPTThemeConfig shareManager] IM_home_ZXTJImageName]) forState:UIControlStateNormal];
//
//    _xinshuituijianBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _liuhetongjiBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _chaxunzhushouBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _gongshishashouBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _liuhetukuBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _zhiboKJbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _lskjBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _cxzsBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _zxtjBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    NSArray *topTitleArr = @[@"聚惠女王节聚惠女王节聚惠女王节聚惠女王节聚惠女王节聚惠女王节聚惠女王节聚惠女王节", @"HTC新品首发，预约送大礼包", @"“挑食”进口生鲜，满199减20"];
//    self.adView.dataA =topTitleArr;
    self.adView.type =  CPTADType_sy;
    self.adView.cellHeight = 50.5;
    [self.adView loadTableView];
    [self loadIcons];
    [self lhcUI];
    [self.adView reloadData];

    [self.notice beginScroll];
    
    [self.adView setClickCell:^(NSInteger index) {
        if(self.clickCell){
            self.clickCell(index);
        }
    }];
    if([[AppDelegate shareapp] sKinThemeType]== SKinType_Theme_White){
        self.pageC.currentPageIndicatorTintColor = [UIColor hexStringToColor:@"FF8610"];
        self.pageC.pageIndicatorTintColor = [UIColor hexStringToColor:@"F0F0F0"];
    }
}


- (void)goLHCHistory{
    if ([self.delegate respondsToSelector:@selector(goLHCHistory)]) {
        
        [self.delegate goLHCHistory];
    }
}

- (void)showBuyViewNeedReload:(BOOL)needReload{
    if(needReload){
        [self.adView reloadData];
    }
    self.bugHeaderbg.hidden = NO;
    self.hoeNewsLbl.text = @"我的收藏";
    self.editBtn.hidden = NO;
    self.leftImageView.image = IMAGE(@"我的收藏");
    self.leftC.constant = self.rightC.constant = 0;
    self.hotNewsBackView.cornerRadius= 0;
    self.topBg.hidden = YES;
    self.commentView.hidden = YES;
    self.dfffff.hidden = NO;
    [self checkMoney];
    [self.bugHeaderbg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.hotNewsBackView.mas_top).offset(0);
    }];
}

- (void)showInfoViewNeedReload:(BOOL)needReload{
    if(needReload){
        [self.adView reloadData];
    }
    self.dfffff.hidden = YES;
    self.bugHeaderbg.hidden = YES;
    self.hoeNewsLbl.text = @"热门资讯";
    self.editBtn.hidden = YES;
    self.leftImageView.image = IMAGE(@"热门资讯");
    self.leftC.constant = self.rightC.constant = 0;
    self.hotNewsBackView.cornerRadius= 10;
    self.topBg.hidden = NO;
    self.commentView.hidden = NO;

    [self.bugHeaderbg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.hotNewsBackView.mas_top).offset(34);
    }];
}

- (void)lhcUI{
    CGFloat width = 35/SCAL;
    CGFloat tmpX = 10/SCAL;
    __block UIButton * tmpBtn;
    for(NSInteger i=0;i<7;i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = CLEAR;
        btn.titleLabel.font = BOLDFONT(15/SCAL);
        [btn setTitleColor:BLACK forState:UIControlStateNormal];
        [self.lhcBg addSubview:btn];
        btn.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i==0){
                make.left.offset(22);
            }else if(i!=6){
                make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
            }else{
                make.left.equalTo(tmpBtn.mas_right).offset(24);
            }
            make.top.offset(30);
            make.width.height.offset(width);
        }];
        if(i==6){
            UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
            im.backgroundColor = CLEAR;
            im.titleLabel.font = FONT(24);
            im.userInteractionEnabled = NO;
            [im setTitleColor:[UIColor hexStringToColor:@"bbbbbb"] forState:UIControlStateNormal];//[[CPTThemeConfig shareManager] openPrizePlusColor]
            [im setTitle:@"+" forState:UIControlStateNormal];
            [self.lhcBg addSubview:im];
            [im mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tmpBtn.mas_right);
                make.top.bottom.equalTo(tmpBtn).offset(-3);
                make.width.offset(24);
            }];
            
        }
        tmpBtn = btn;
        [_titleBtnArray addObject:btn];
    }
    for(NSInteger i=0;i<_titleBtnArray.count;i++){
        UILabel * la = [[UILabel alloc] init];
        la.font = FONT(12);
        la.textAlignment = NSTextAlignmentCenter;
        la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];
        la.backgroundColor = CLEAR;
        [self.lhcBg addSubview:la];
        UIButton *btn = _titleBtnArray[i];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom);
            make.centerX.equalTo(btn);
            make.width.equalTo(btn).offset(tmpX);
            make.height.offset(14);
        }];
        [_subTitleArray addObject:la];
    }
}

- (void)loadLhcData{
    @weakify(self)
    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(CPTBuyTicketType_LiuHeCai)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
        @strongify(self)
        SixInfoModel * model = data.lhc;
        [self sixModel:model];
    }];
}

- (void)sixModel:(SixInfoModel *)model{
    NSString * iss = [NSString stringWithFormat:@"第%@期开奖结果",model.issue];
//    self.lhcIssueLab.text = ;
    NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",iss]];
    UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    [maxWinttr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(1, model.issue.length)];
    self.lhcIssueLab.attributedText = maxWinttr;
    
    NSArray * numberArry = [model.number componentsSeparatedByString:@","];
    NSArray * shengxiaoArry = [model.shengxiao componentsSeparatedByString:@","];
    
    for (int i = 0; i< numberArry.count; i++) {
        NSString *number = numberArry[i];
        NSString *shengxiao = shengxiaoArry[i];
        NSString *wuxin = [Tools numbertowuxin:number];
        UIButton *btn = self.titleBtnArray[i];
        UILabel  *lab = self.subTitleArray[i];
        lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao?shengxiao:@"💰",wuxin?wuxin:@"💰"];
        [btn setTitle:number forState:UIControlStateNormal];
        [btn setBackgroundImage:[Tools numbertoimage:number Withselect:NO] forState:UIControlStateNormal];
    }
}

- (void)loadIcons{
    NSString *title = @"心水推荐";
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        title = @"小鱼论坛";
    }
    NSArray *name = @[title,@"六合大神",@"六合图库",@"公式杀号",@"查询助手",@"资讯统计",@"开奖日历",@"AI智能选号",@"直播开奖",@"历史开奖",@"聊天室",@"挑码助手",@"生肖特码",@"生肖正码",@"尾数大小",@"连码走势"];
    
    NSArray *icons = @[@"lhc_xstj",@"lhc_lhds",@"lhc_lhtk",@"lhc_gssh",@"lhc_cxzs",@"lhc_zxtj",@"lhc_kjrl",@"lhc_aiznxh",@"lhc_kjzb",@"lhc_lskj",@"lhc_lts",@"lhc_tmzs",@"lhc_sxtm",@"lhc_sxzm",@"lhc_wsdx",@"lhc_lmzs"];
    

    CGFloat width = 45/SCAL;
    CGFloat tmpX = (SCREEN_WIDTH- width*4 -60)/3;
    __block UIButton * tmpBtn;
    for(NSInteger i=0;i<icons.count;i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000+i;
        btn.userInteractionEnabled = YES;
        [self.iconScroll addSubview:btn];
        [btn addTarget:self action:@selector(clickIcon:) forControlEvents:UIControlEventAllEvents];
        
        NSString *jj = [NSString stringWithFormat:@"%@%@",[[CPTThemeConfig shareManager] IC_Home_Icon_BeginName], icons[i]];
        
        [btn setImage:IMAGE(jj) forState:UIControlStateNormal];

        btn.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i==0 || i==8){
                make.left.offset(22);
            }
            else {
                make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
            }
            
            if(i>=8){
                make.top.offset(10+width+37);
            }else{
                make.top.offset(10);
            }
            make.width.height.offset(width);
        }];

        UILabel * la= [[UILabel alloc] init];
        la.font = FONT(14);
        la.textAlignment = NSTextAlignmentCenter;
        la.textColor =  [[CPTThemeConfig shareManager] CO_Home_News_ScrollLabelText];
        la.backgroundColor = CLEAR;
        la.text = name[i];
        [self.iconScroll addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom).offset(6);
            make.centerX.equalTo(btn);
            make.width.equalTo(btn).offset(tmpX);
            make.height.offset(14);
        }];
        tmpBtn = btn;
    }
    self.iconScroll.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
}

- (IBAction)didClickXinShuiTuiJian:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickSixRecommetNews:)]) {
        
        [self.delegate clickSixRecommetNews:sender];
    }
}

- (void)clickIcon:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickIcon:)]) {
        
        [self.delegate clickIcon:sender];
    }
}

- (IBAction)didClickEdit:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickEditBtn)]) {
        
        [self.delegate clickEditBtn];
    }
}

- (IBAction)didClickKefu{
    
    if ([self.delegate respondsToSelector:@selector(clickKefu)]) {
        
        [self.delegate clickKefu];
    }
}

- (IBAction)didClickChongzhi{
    
    if ([self.delegate respondsToSelector:@selector(didClickChongzhi)]) {
        
        [self.delegate didClickChongzhi];
    }
}

- (IBAction)didClickTiXian{
    
    if ([self.delegate respondsToSelector:@selector(didClickTiXian)]) {
        
        [self.delegate didClickTiXian];
    }
}

- (IBAction)close {
@weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
        @strongify(self)
        self.touTiaoBg.alpha =0.0;
    }completion:^(BOOL finished) {
        @strongify(self)
        [self.touTiaoBg removeFromSuperview];
        if(self.adView){
            [self.adView endScroll];
        }
        if ([self.delegate respondsToSelector:@selector(clickClose)]) {
            
            [self.delegate clickClose];
        }
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageC.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}

#pragma mark - 检测余额 & 充值
- (void)checkMoney{
    
    self.moneyL.textColor = [[CPTThemeConfig shareManager] CO_Main_LabelNo1];
    NSString * money = [NSString stringWithFormat:@"余额:%.2f元",[Person person].balance];
        NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",money]];
    UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    [maxWinttr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(3, money.length-4)];
    self.moneyL.attributedText = maxWinttr;
}

@end
