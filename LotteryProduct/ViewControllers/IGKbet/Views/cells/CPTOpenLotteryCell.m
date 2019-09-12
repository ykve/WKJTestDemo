//
//  CPTOpenLotteryCell.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTOpenLotteryCell.h"
#import "BallTool.h"

@implementation CPTOpenLotteryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if(!_subTitleArray)_subTitleArray = [NSMutableArray array];
        if(!_titleBtnArray)_titleBtnArray = [NSMutableArray array];
//        self.contentView.backgroundColor = [UIColor colorWithHex:@"2d2f37"];
        self.contentView.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_View_BackgroundC];
;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if(!_countDownForLabel){
            _countDownForLabel = [[CountDown alloc] init];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    if(_countDownForLabel){
        [_countDownForLabel destoryTimer];
        _countDownForLabel = nil;
    }
    [_subTitleArray removeAllObjects];
    [_titleBtnArray removeAllObjects];
    _subTitleArray = nil;
    _titleBtnArray = nil;
}

- (void)configUI{
    if(_titleBtnArray){
        if(_titleBtnArray.count>0){
            return;
        }
    }
//    MBLog(@"type: %ld",(long)self.type);
    UIImageView * iconV = [[UIImageView alloc] init];
    [self.contentView addSubview:iconV];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.height.offset(46);
        make.centerY.equalTo(self);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
        make.width.offset(150);
        make.height.offset(15);
    }];
    self.nameLabel.textColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_TitleC];
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    
    self.currentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.currentLabel];
    self.currentLabel.textAlignment = NSTextAlignmentRight;
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.offset(15);
        make.width.offset(200);
        make.height.offset(15);
    }];
    self.currentLabel.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs1_TextC];
    self.currentLabel.font = FONT(13);
    self.currentLabel.text = @"第0期开奖结果";
    
    self.nextLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nextLabel];
    self.nextLabel.font = FONT(13);
    self.nextLabel.text = @"第0期";
    self.nextLabel.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs1_TextC];

    UILabel *endLabel = [[UILabel alloc] init];
    [self.contentView addSubview:endLabel];
    endLabel.textAlignment = NSTextAlignmentRight;
    endLabel.font = FONT(13);
    endLabel.text = @"投注截止";
    endLabel.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs1_TextC];
    
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.textAlignment = NSTextAlignmentRight;

    self.timeLabel.font = FONT(13);
    self.timeLabel.text = @"00:00";

    self.timeLabel.textColor = [[CPTThemeConfig shareManager] OpenLotteryTimeLblTextColor];


    switch (self.type) {
        case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
        {
    
            CGFloat width = 35/SCAL;
            CGFloat tmpX = 10/SCAL;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<7;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.userInteractionEnabled = NO;
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(15);
                [btn setTitleColor:BLACK forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                btn.titleEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(15);
                    }else if(i!=6){
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(14);
                    }
                    make.top.offset(40);
                    make.width.height.offset(width);
                }];
                if(i==6){
                    UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
                    im.backgroundColor = CLEAR;
                    im.titleLabel.font = FONT(12);
                    im.userInteractionEnabled = NO;
                    [im setTitleColor:[[CPTThemeConfig shareManager] openPrizePlusColor] forState:UIControlStateNormal];
                    [im setTitle:@"+" forState:UIControlStateNormal];
                    [self.contentView addSubview:im];
                    [im mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(tmpBtn.mas_right);
                        make.top.bottom.equalTo(tmpBtn);
                        make.width.offset(14);
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
                [self.contentView addSubview:la];
                UIButton *btn = _titleBtnArray[i];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btn.mas_bottom);
                    make.centerX.equalTo(btn);
                    make.width.equalTo(btn).offset(tmpX);
                    make.height.offset(30);
                }];
                [_subTitleArray addObject:la];
                if(i==_titleBtnArray.count-1){
                    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(15);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-10);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(100);
                        make.height.offset(15);
                    }];
                    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-67);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                }
            }
        }
            break;
        case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:case CPTBuyTicketType_FantanPK10:case CPTBuyTicketType_FantanXYFT:case CPTBuyTicketType_NiuNiu_JiShu:case CPTBuyTicketType_NiuNiu_AoZhou:
        {

            CGFloat width = 30/SCAL;
            CGFloat tmpX = 5/SCAL;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<10;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.userInteractionEnabled = NO;
                btn.titleLabel.font = BOLDFONT(16);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];

                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(15);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(40);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            if(self.type == CPTBuyTicketType_FantanXYFT || self.type == CPTBuyTicketType_FantanPK10 || self.type == CPTBuyTicketType_NiuNiu_JiShu || self.type == CPTBuyTicketType_NiuNiu_AoZhou){
                UILabel * la = [[UILabel alloc] init];
                la.font = FONT(16);
                la.backgroundColor = CLEAR;
                [self.contentView addSubview:la];
                UIButton *btn = _titleBtnArray[0];
                UILabel *tmpLa;
                [_subTitleArray addObject:la];

                if(self.type == CPTBuyTicketType_NiuNiu_JiShu || self.type == CPTBuyTicketType_NiuNiu_AoZhou){
                    [la removeFromSuperview];
                    [_subTitleArray removeAllObjects];
                    for(NSInteger i=0;i<5;i++){
                        UILabel * la = [[UILabel alloc] init];
                        la.font = FONT(14);
                        la.backgroundColor = CLEAR;
                        la.textAlignment = NSTextAlignmentCenter;
                        la.layer.borderWidth = 0.5;
                        la.layer.borderColor = [[CPTThemeConfig shareManager] OpenLotteryLblLayerColor].CGColor;
                        la.layer.cornerRadius = 3;
                        la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                        [self.contentView addSubview:la];
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
                            if(i==0){
                                make.left.offset(15);
                            }else{
                                make.left.equalTo(tmpLa.mas_right).offset(5);
                            }
                            make.top.equalTo(tmpBtn.mas_bottom).offset(10);
                            make.width.offset(44);
                            make.height.offset(22);
                        }];
                        tmpLa = la;
                        [_subTitleArray addObject:la];
                    la.text = @"";
                    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(15);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-10);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(100);
                        make.height.offset(15);
                    }];
                    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-67);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                        
                    }
                }else{
//                    la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs1_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                    la.font = FONT(13);
                    la.textAlignment = NSTextAlignmentLeft;
                    [la mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom).offset(10);
                        make.left.offset(15);
                        make.width.offset(200);
                        make.height.equalTo(btn);
                    }];
                    la.text = @"和值";
                    la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];
                    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(15);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-10);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(100);
                        make.height.offset(15);
                    }];
                    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-67);
                        make.top.equalTo(la.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                }
                [_subTitleArray addObject:la];

            }else{
                for(NSInteger i=0;i<_titleBtnArray.count-2;i++){
                    UILabel * la = [[UILabel alloc] init];
                    la.layer.borderWidth = 0.5;
                    la.layer.borderColor = [[CPTThemeConfig shareManager] OpenLotteryLblLayerColor].CGColor;
                    la.layer.cornerRadius = 3;
                    la.font = FONT(13);
                    la.textAlignment = NSTextAlignmentCenter;
                    la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                    la.backgroundColor = CLEAR;
                    [self.contentView addSubview:la];
                    UIButton *btn = _titleBtnArray[i];
                    [la mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom).offset(10);
                        make.centerX.equalTo(btn);
                        make.width.offset(22);
                        make.height.offset(22);
                    }];
                    [_subTitleArray addObject:la];
                    if(i==0){
                        [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.offset(15);
                            make.top.equalTo(la.mas_bottom).offset(10);
                            make.width.offset(150);
                            make.height.offset(15);
                        }];
                        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(self.mas_right).offset(-10);
                            make.top.equalTo(la.mas_bottom).offset(10);
                            make.width.offset(100);
                            make.height.offset(15);
                        }];
                        [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(self.mas_right).offset(-67);
                            make.top.equalTo(la.mas_bottom).offset(10);
                            make.width.offset(150);
                            make.height.offset(15);
                        }];
                    }
                }

            }
        }
            break;
        case CPTBuyTicketType_AoZhouACT:
        {
            CGFloat width = 30/SCAL;
            CGFloat tmpX = 5/SCAL;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<20;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.userInteractionEnabled = NO;
                btn.titleLabel.font = BOLDFONT(14);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i<10){
                        if(i==0){
                            make.left.offset(15);
                        }else{
                            make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                        }
                        make.top.offset(40);
                    }else{
                        if(i==10){
                            make.left.offset(15);
                        }else{
                            make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                        }
                        make.top.offset(40 + width +8);
                    }

                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UILabel * la = [[UILabel alloc] init];
            la.font = FONT(14);
            la.backgroundColor = CLEAR;
            [self.contentView addSubview:la];
            UIButton *btn = _titleBtnArray[10];
            [_subTitleArray addObject:la];
            if(self.type == CPTBuyTicketType_AoZhouACT){
                la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                la.textAlignment = NSTextAlignmentCenter;
                //                    la.layer.borderWidth = 0.5;
                //                    la.layer.borderColor = [UIColor colorWithHex:@"d8d9d6"].CGColor;
                //                    la.layer.cornerRadius = 3;
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btn.mas_bottom).offset(10);
                    make.left.offset(15);
                    make.width.offset(60);
                    make.height.offset(22);
                }];
                la.text = @"";
                [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.top.equalTo(btn.mas_bottom).offset(10);
                    make.width.offset(150);
                    make.height.offset(15);
                }];
                [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-10);
                    make.top.equalTo(btn.mas_bottom).offset(10);
                    make.width.offset(100);
                    make.height.offset(15);
                }];
                [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-67);
                    make.top.equalTo(btn.mas_bottom).offset(10);
                    make.width.offset(150);
                    make.height.offset(15);
                }];

            }
            
        }
            break;

        case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_FantanSSC:case CPTBuyTicketType_NiuNiu_KuaiLe:case CPTBuyTicketType_AoZhouShiShiCai:
        {
            CGFloat width = 35;
            CGFloat tmpX = 10;
            __block UIButton * tmpBtn;
            __block UILabel * tmpLa;
            for(NSInteger i=0;i<5;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.userInteractionEnabled = NO;
                btn.titleLabel.font = BOLDFONT(17);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(15);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(40);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            if(self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_NiuNiu_KuaiLe) {

                UIButton *btn = _titleBtnArray[0];
                if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
                    for(NSInteger i=0;i<5;i++){
                        UILabel * la = [[UILabel alloc] init];
                        la.font = FONT(14);
                        la.backgroundColor = CLEAR;
                        la.textAlignment = NSTextAlignmentCenter;
                        la.layer.borderWidth = 0.5;
                        la.layer.borderColor = [[CPTThemeConfig shareManager] OpenLotteryLblLayerColor].CGColor;
                        la.layer.cornerRadius = 3;
                        la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                        [self.contentView addSubview:la];
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
                            if(i==0){
                                make.left.offset(15);
                            }else{
                                make.left.equalTo(tmpLa.mas_right).offset(5);
                            }
                            make.top.equalTo(tmpBtn.mas_bottom).offset(10);
                            make.width.offset(44);
                            make.height.offset(22);
                        }];
                        tmpLa = la;
                        [_subTitleArray addObject:la];
                    }
                    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(15);
                        make.top.equalTo(tmpLa.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-10);
                        make.top.equalTo(tmpLa.mas_bottom).offset(10);
                        make.width.offset(100);
                        make.height.offset(15);
                    }];
                    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-67);
                        make.top.equalTo(tmpLa.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                }else{
                    UILabel * la = [[UILabel alloc] init];
                    [self.contentView addSubview:la];
                    la.text = @"";
                    la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                    la.textAlignment = NSTextAlignmentLeft;
                    [la mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom).offset(0);
                        make.left.offset(15);
                        make.width.offset(100);
                        make.height.equalTo(btn);
                    }];
                    la.text = @"和值";
                    la.font = FONT(13);
                    [_subTitleArray addObject:la];
                    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(15);
                        make.top.equalTo(la.mas_bottom).offset(0);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-10);
                        make.top.equalTo(la.mas_bottom).offset(0);
                        make.width.offset(100);
                        make.height.offset(15);
                    }];
                    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-67);
                        make.top.equalTo(la.mas_bottom).offset(0);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                }

            }else{
                UILabel * tmpL;
                for(NSInteger i=0;i<_titleBtnArray.count-1;i++){
                    UILabel * la = [[UILabel alloc] init];
                    la.layer.borderWidth = 0.5;
                    la.layer.borderColor = [[CPTThemeConfig shareManager] OpenLotteryLblLayerColor].CGColor;
                    la.layer.cornerRadius = 3;
                    la.font = FONT(12);
                    la.textAlignment = NSTextAlignmentCenter;
                    la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                    la.backgroundColor = CLEAR;
                    [self.contentView addSubview:la];
                    UIButton *btn = _titleBtnArray[i];
                    [la mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom).offset(6);
                        if(i==0){
                            make.centerX.equalTo(btn);
                        }else{
                            make.left.equalTo(tmpL.mas_right).offset(10);
                        }
                        make.width.height.offset(22);
                    }];
                    tmpL = la;
                    [_subTitleArray addObject:la];
                    if(i==0){
                        [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.offset(15);
                            make.top.equalTo(la.mas_bottom).offset(10);
                            make.width.offset(150);
                            make.height.offset(15);
                        }];
                        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(self.mas_right).offset(-10);
                            make.top.equalTo(la.mas_bottom).offset(10);
                            make.width.offset(100);
                            make.height.offset(15);
                        }];
                        [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(self.mas_right).offset(-67);
                            make.top.equalTo(la.mas_bottom).offset(10);
                            make.width.offset(150);
                            make.height.offset(15);
                        }];
                    }
                }
            }

        }
            break;
        case CPTBuyTicketType_HaiNanQiXingCai:case CPTBuyTicketType_PaiLie35:case CPTBuyTicketType_Shuangseqiu:case CPTBuyTicketType_DaLetou:case CPTBuyTicketType_QiLecai:case CPTBuyTicketType_3D:{
            NSInteger countBall = 0;
            CGFloat width = 35;
            CGFloat tmpL = 0.0;
            switch (self.type) {
                case CPTBuyTicketType_HaiNanQiXingCai:
                    countBall = 4;
                    tmpL = 50;
                    break;
                case CPTBuyTicketType_PaiLie35:
                    countBall = 5;
                    tmpL = 50;
                    break;
                case CPTBuyTicketType_Shuangseqiu:
                    countBall = 7;
                    break;
                case CPTBuyTicketType_DaLetou:
                    countBall = 7;
                    break;
                case CPTBuyTicketType_QiLecai:
                    width = 30;
                    countBall = 8;
                    break;
                case CPTBuyTicketType_3D:
                    countBall = 3;
                    tmpL = 120;
                    break;
                    
                default:
                    break;
            }
            width = width/SCAL;
            CGFloat tmpX = 10;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<countBall;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(17);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                btn.userInteractionEnabled = NO;
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(15);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(40);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
      
            }
            if(self.type==CPTBuyTicketType_PaiLie35){
                UILabel * la = [[UILabel alloc] init];
                la.font = FONT(14);
                la.backgroundColor = CLEAR;
                [self.contentView addSubview:la];
                la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs1_TextC];//[UIColor colorWithHex:@"d8d9d6"];
                la.textAlignment = NSTextAlignmentLeft;
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(tmpBtn.mas_bottom).offset(0);
                    make.left.offset(15);
                    make.width.offset(200);
                    make.height.equalTo(tmpBtn);
                }];
                [_subTitleArray addObject:la];
                [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.top.equalTo(la.mas_bottom).offset(0);
                    make.width.offset(150);
                    make.height.offset(15);
                }];
                [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-10);
                    make.top.equalTo(la.mas_bottom).offset(0);
                    make.width.offset(100);
                    make.height.offset(15);
                }];
                [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-67);
                    make.top.equalTo(la.mas_bottom).offset(0);
                    make.width.offset(150);
                    make.height.offset(15);
                }];
            }else{
                [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15);
                    make.top.equalTo(tmpBtn.mas_bottom).offset(15);
                    make.width.offset(150);
                    make.height.offset(15);
                }];
                [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-10);
                    make.top.equalTo(tmpBtn.mas_bottom).offset(15);
                    make.width.offset(100);
                    make.height.offset(15);
                }];
                [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).offset(-67);
                    make.top.equalTo(tmpBtn.mas_bottom).offset(15);
                    make.width.offset(150);
                    make.height.offset(15);
                }];
            }
        }break;
        case CPTBuyTicketType_PCDD:
        {
            CGFloat width = 35;
            CGFloat tmpX = 10;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<3;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(17);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                btn.userInteractionEnabled = NO;

                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(   15);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(40);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
                if(i==_titleBtnArray.count-1){
                    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.offset(15);
                        make.top.equalTo(btn.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-10);
                        make.top.equalTo(btn.mas_bottom).offset(10);
                        make.width.offset(100);
                        make.height.offset(15);
                    }];
                    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.mas_right).offset(-67);
                        make.top.equalTo(btn.mas_bottom).offset(10);
                        make.width.offset(150);
                        make.height.offset(15);
                    }];
                }
            }
            UILabel * la = [[UILabel alloc] init];
            la.layer.borderWidth = 0.5;
            la.layer.borderColor = [[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs1_TextC].CGColor;
            la.layer.cornerRadius = 3;
            la.font = FONT(12);
            la.textAlignment = NSTextAlignmentCenter;
            la.textColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SubTitle_TextC];//[UIColor colorWithHex:@"d8d9d6"];
            la.backgroundColor = CLEAR;
            [self.contentView addSubview:la];
            [la mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-26);
                make.centerY.equalTo(tmpBtn);
                make.width.offset(70);
                make.height.offset(25);
            }];
            [_subTitleArray addObject:la];
            
        }
            break;
        default:
            break;
    }
    self.line = [[UIView alloc] init];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.height.offset(1);
    }];
    
    self.line.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_SeperatorLineBackgroundColor];
}

- (void)sixModel:(SixInfoModel *)model{
    [self configTimer:model.nextTime nextIssue:model.nextIssue  issue:model.issue];

    self.dateL.text = [NSString stringWithFormat:@"第%@期",model.issue];
    NSArray * numberArry = [model.number componentsSeparatedByString:@","];
    NSArray * shengxiaoArry = [model.shengxiao componentsSeparatedByString:@","];

    for (int i = 0; i< numberArry.count; i++) {
        NSString *number = numberArry[i];
        NSString *shengxiao = shengxiaoArry[i];
        NSString *wuxin = [Tools numbertowuxin:number];
        UIButton *btn = self.titleBtnArray[i];
        UILabel  *lab = self.subTitleArray[i];
        
//        lab.textColor = [[CPTThemeConfig shareManager] OpenPrizeWuXing];
        lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao?shengxiao:@"💰",wuxin?wuxin:@"💰"];
        [btn setTitle:number forState:UIControlStateNormal];
        [btn setBackgroundImage:[Tools numbertoimage:number Withselect:NO] forState:UIControlStateNormal];
    }
}

- (void)pk10Model:(PK10InfoModel *)pk10Model{
    [self configTimer:pk10Model.nextTime nextIssue:[NSString stringWithFormat:@"%ld",pk10Model.nextIssue]  issue:pk10Model.issue];
    NSArray *numbers = [pk10Model.number componentsSeparatedByString:@","];
    if(!numbers){return;}
    if(numbers.count<=5){return;}
    //冠亚
    int guanInt = [[NSString stringWithFormat:@"%@", numbers[0]] intValue];
    int yaInt = [[NSString stringWithFormat:@"%@", numbers[1]] intValue];
    int jiInt = [[NSString stringWithFormat:@"%@", numbers[2]] intValue];
    int fourthInt = [[NSString stringWithFormat:@"%@", numbers[3]] intValue];
    int fifthInt = [[NSString stringWithFormat:@"%@", numbers[4]] intValue];
    int sixthInt = [[NSString stringWithFormat:@"%@", numbers[5]] intValue];
    int sevenInt = [[NSString stringWithFormat:@"%@", numbers[6]] intValue];
    
    NSString *guanYaStr = [NSString stringWithFormat:@"%d", guanInt + yaInt];
    int tenthNum = [[NSString stringWithFormat:@"%@", numbers[9]] intValue];
    
    int ninethNum = [[NSString stringWithFormat:@"%@", numbers[8]] intValue];
    int eightthNum = [[NSString stringWithFormat:@"%@", numbers[7]] intValue];
    for (int i = 0; i< numbers.count; i++) {
        if (_titleBtnArray.count-1<i) {
            break;
        }
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:numbers[i] forState:UIControlStateNormal];
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        int num = [[NSString stringWithFormat:@"%@", numbers[i]] intValue];
//        btn.titleLabel.font = BOLDFONT(14);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        
        btn.backgroundColor = [BallTool getColorWithNum:num];

//        switch (num) {
//            case 1:
//                break;
//            case 2:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color2];
//                break;
//            case 3:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color3];
//                break;
//            case 4:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color4];
//                break;
//            case 5:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color5];
//                break;
//            case 6:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color6];
//                break;
//            case 7:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color7];
//                break;
//            case 8:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color8];
//                break;
//            case 9:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color9];
//                break;
//            case 10:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color10];
//                break;
//            case 0:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color10];
//                break;
//            default:
//                break;
//        }
    }
    if(self.type == CPTBuyTicketType_FantanXYFT || self.type == CPTBuyTicketType_FantanPK10 || self.type == CPTBuyTicketType_NiuNiu_JiShu || self.type == CPTBuyTicketType_NiuNiu_AoZhou){

        if(self.type == CPTBuyTicketType_NiuNiu_JiShu || self.type == CPTBuyTicketType_NiuNiu_AoZhou){
//            UILabel *lbl = _subTitleArray[0];
//            lbl.text = pk10Model.niuWinner;
            
            NSArray * nnS = [pk10Model.niuWinner componentsSeparatedByString:@","];
            for(NSInteger i=0;i<5;i++){
                UILabel *lbl = _subTitleArray[i];
                if(i>nnS.count-1){
                    lbl.hidden = YES;
                }else{
                    lbl.text = nnS[i];
                    lbl.hidden = NO;
                }
            }
        }else{
            UILabel *lbl = _subTitleArray[0];
            NSInteger total = guanInt + yaInt + jiInt;
            NSInteger x = total%4;
            lbl.text = [NSString stringWithFormat:@"前三和值%ld %@ 4 = %ld",(long)total,@"%",(long)(x==0?4:x)];
        }
    }else{
        for (int i = 0; i < _subTitleArray.count; i++) {
            UILabel *lbl = _subTitleArray[i];
//            lbl.textColor = [[CPTThemeConfig shareManager] OpenPrizeWuXing];
            switch (i) {
                case 0://1冠亚
                    lbl.text = guanYaStr;
                    break;
                case 1://冠亚大小
                    if (guanInt + yaInt > 11) {
                        lbl.text = @"大";
                    }else{
                        lbl.text = @"小";
                    }
                    break;
                case 2://1冠亚单双
                    if ((guanInt + yaInt)%2) {
                        lbl.text = @"单";
                    } else{
                        lbl.text = @"双";
                    }
                    break;
                case 3://龙虎
                    if (guanInt > tenthNum) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 4://
                    if (yaInt > ninethNum) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 5://
                    if (jiInt > eightthNum) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 6:
                    if (fourthInt > sevenInt) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 7:
                    if (fifthInt > sixthInt) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                default:
                    break;
            }
        }

    }
    

}

- (void)sscModel:(ChongqinInfoModel *)model{
    ChongqinInfoModel * cqsscModel = model;
    //    self.dateL.text = [cqsscModel.issue substringFromIndex:8];
    [self configTimer:cqsscModel.nextTime nextIssue:cqsscModel.nextIssue issue:cqsscModel.issue];

    if(self.type == CPTBuyTicketType_AoZhouShiShiCai){
        NSMutableArray * sf = [NSMutableArray array];
        for (NSInteger i = 0; i< cqsscModel.numbers.count; i++) {
            NSString * ke = cqsscModel.numbers[i];
            if(![ke isEqualToString:@","]){
                [sf addObject:ke];
            }
        }
        for (NSInteger i = 0; i< sf.count; i++) {
            NSString *num = sf[i];
            UIButton *btn = [_titleBtnArray objectAtIndex:i];
            [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
            [btn setTitle:num forState:UIControlStateNormal];
        }

    }else{
        for (NSInteger i = 0; i< cqsscModel.numbers.count; i++) {
            if (_titleBtnArray.count-1<i) {
                break;
            }
            NSString *num = cqsscModel.numbers[i];
            UIButton *btn = [_titleBtnArray objectAtIndex:i];
            NSString *sscBallName = [[CPTThemeConfig shareManager] SscBallName];
            [btn setBackgroundImage:IMAGE(sscBallName) forState:UIControlStateNormal];
            [btn setTitle:num forState:UIControlStateNormal];
//            btn.titleLabel.font = BOLDFONT(14);
        }
    }
    if([cqsscModel.number isKindOfClass:[NSString class]]){
        if([cqsscModel.number containsString:@","]){
            cqsscModel.number = [cqsscModel.number stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
    }
    if(cqsscModel.number.length <1 && self.type == CPTBuyTicketType_FFC){
        return;
    }
    if(cqsscModel.numbers.count <2 ){
        return;
    }
    int num1 = [[cqsscModel.number substringWithRange:NSMakeRange(0, 1)] intValue];
    int num2 = [[cqsscModel.number substringWithRange:NSMakeRange(1, 1)] intValue];
    int num3 = [[cqsscModel.number substringWithRange:NSMakeRange(2, 1)] intValue];
    int num4 = [[cqsscModel.number substringWithRange:NSMakeRange(3, 1)] intValue];
    int num5 = [[cqsscModel.number substringWithRange:NSMakeRange(4, 1)] intValue];
    if(self.type == CPTBuyTicketType_FantanSSC || self.type == CPTBuyTicketType_NiuNiu_KuaiLe) {
        if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
            NSArray * nnS = [cqsscModel.niuWinner componentsSeparatedByString:@","];
            for(NSInteger i=0;i<5;i++){
                UILabel *lbl = _subTitleArray[i];
                if(i>nnS.count-1){
                    lbl.hidden = YES;
                }else{
                    lbl.text = nnS[i];
                    lbl.hidden = NO;
                }
            }
        }else{
             num1 = [cqsscModel.numbers[0] intValue];
             num2 = [cqsscModel.numbers[1] intValue];
             num3 = [cqsscModel.numbers[2] intValue];
             num4 = [cqsscModel.numbers[3] intValue];
             num5 = [cqsscModel.numbers[4] intValue];
            UILabel *lbl = _subTitleArray[0];
            NSInteger total = num1 + num2 + num3+ num4+ num5;
            NSInteger x = total%4;
            lbl.text = [NSString stringWithFormat:@"和值%ld %@ 4 = %ld",total,@"%",x==0?4:x];
//            lbl.textColor = WHITE;
        }
    }else{
        for (NSInteger i = 0; i< _subTitleArray.count; i++) {
            UILabel * lbl = _subTitleArray[i];
            switch (i) {
                case 0:
                    lbl.text = [NSString stringWithFormat:@"%d",(num1 + num2 + num3 + num4 + num5)];
                    break;
                case 1:
                    if (num1 + num2 + num3 + num4 + num5 >= 23) {
                        lbl.text = @"大";
                    }else{
                        lbl.text = @"小";
                    }
                    break;
                case 2:
                    if ((num1 + num2 + num3 + num4 + num5) % 2 == 0) {
                        lbl.text = @"双";
                    }else{
                        lbl.text = @"单";
                    }
                    break;
                case 3:
                    if (num1 > num5) {
                        lbl.text = @"龙";
                    }else if (num1 < num5){
                        lbl.text = @"虎";
                    } else{
                        lbl.text = @"和";
                    }
                    break;
                default:
                    break;
            }
        }

    }
}

- (void)pcddModel:(LotteryInfoModel *)model{
    self.dateL.text = model.issue;
    [self configTimer:model.nextTime nextIssue:model.nextIssue issue:model.issue];

    NSArray *numarray = [model.number componentsSeparatedByString:@","];
    if(numarray.count<=1){
        return;
    }
    NSString * text = [NSString stringWithFormat:@"和值 %ld",[numarray[0]integerValue] + [numarray[1]integerValue] + [numarray[2]integerValue]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:text];
    if(text.length<=4){
        [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextC] range:NSMakeRange(2, 2)];
    }else{
        [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextC] range:NSMakeRange(3, 2)];
    }

    UILabel * jj = _subTitleArray[0];
    jj.attributedText = attrStr;
    for (int i = 0; i< _titleBtnArray.count; i++) {
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:numarray[i] forState:UIControlStateNormal];
        NSString *sscBallName = [[CPTThemeConfig shareManager] SscBallName];
        [btn setBackgroundImage:IMAGE(sscBallName) forState:UIControlStateNormal];
    }
}

- (void)lotteryInfoModel:(LotteryInfoModel *)model{
    LotteryInfoModel * infoModel = model;
    [self configTimer:infoModel.nextTime nextIssue:infoModel.nextIssue issue:infoModel.issue];
    NSString *numS = [infoModel.number stringByReplacingOccurrencesOfString:@"+" withString:@","];
    if (numS.length == 0) {
        return;
    }
    NSArray *numarray = [numS componentsSeparatedByString:@","];
    NSInteger count = numarray.count;
    if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
        count = 4;
    }
  
    for (NSInteger i = 0; i< count; i++) {
//        if (_titleBtnArray.count-1<i) {
//            break;
//        }
        NSString *num = numarray[i];
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:num forState:UIControlStateNormal];
        NSString *sscBallName = [[CPTThemeConfig shareManager] SscBallName];
//        btn.titleLabel.font = BOLDFONT(14);
        [btn setBackgroundImage:IMAGE(sscBallName) forState:UIControlStateNormal];
        
        NSString *sscBlueBallName = [[CPTThemeConfig shareManager] SscBlueBallName];
        if(self.type == CPTBuyTicketType_Shuangseqiu ){
            if(i>=6){
                [btn setBackgroundImage:IMAGE(sscBlueBallName) forState:UIControlStateNormal];
            }
        }
        else if(self.type == CPTBuyTicketType_DaLetou){
            if(i>=5){
                [btn setBackgroundImage:IMAGE(sscBlueBallName) forState:UIControlStateNormal];
            }
        }
        if(self.type == CPTBuyTicketType_QiLecai ){
            if(i>=7){
                [btn setBackgroundImage:IMAGE(sscBlueBallName) forState:UIControlStateNormal];
            }
        }
        
        if (self.type == CPTBuyTicketType_AoZhouACT) {
            UIColor *color0 = [UIColor colorWithHex:@"C6202C"];
            UIColor *color1 = [UIColor colorWithHex:@"006AB4"];
            UIColor *color2 = [UIColor colorWithHex:@"00833D"];
            UIColor *color3 = [UIColor colorWithHex:@"F9A800"];
            UIColor *color4 = [UIColor colorWithHex:@"B52996"];
            UIColor *color5 = [UIColor colorWithHex:@"F15000"];
            UIColor *color6 = [UIColor colorWithHex:@"8CAAC2"];
            UIColor *color7 = [UIColor colorWithHex:@"533190"];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5;
            if (0<num.intValue  && num.intValue < 11) {
                btn.backgroundColor = color0;
            }else if (10<num.intValue  && num.intValue < 21){
                btn.backgroundColor = color1;
            }else if (20<num.intValue  && num.intValue < 31){
                btn.backgroundColor = color2;
            }else if (30<num.intValue  && num.intValue < 41){
                btn.backgroundColor = color3;
            }else if (40<num.intValue  && num.intValue < 51){
                btn.backgroundColor = color4;
            }else if (50<num.intValue  && num.intValue < 61){
                btn.backgroundColor = color5;
            }else if (60<num.intValue  && num.intValue < 71){
                btn.backgroundColor = color6;
            }else if (70<num.intValue  && num.intValue < 81){
                btn.backgroundColor = color7;
            }
            
        }
    }

    if(self.type == CPTBuyTicketType_PaiLie35){
        
        if (numarray.count < 5) {
            return;
        }
        int num1 = [numarray[0] intValue];
        int num2 = [numarray[1] intValue];
        int num3 = [numarray[2] intValue];
        int num4 = [numarray[3] intValue];
        int num5 = [numarray[4] intValue];
        if(_subTitleArray.count==1) {
            UILabel *lbl = _subTitleArray[0];
            NSInteger p5 = num1 + num2 + num3+ num4+ num5;
            NSInteger p3 = num1 + num2 + num3;
            lbl.text = [NSString stringWithFormat:@"P5和值：%ld        P3和值：%ld",(long)p5,(long)p3];
        }
    }

}

- (void)configTimer:(long long)finishLongLong nextIssue:(NSString*)nextIssue issue:(NSString *)issue{
    if([issue length]<=0){
        return;
    }
    NSString * nextIssueS = [NSString stringWithFormat:@"第%@期",nextIssue];
    NSString * issueS = [NSString stringWithFormat:@"第%@期  开奖结果",issue];
    NSMutableAttributedString *nextIssueSS = [[NSMutableAttributedString alloc]initWithString:nextIssueS];
    [nextIssueSS addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextB] range:NSMakeRange(0, nextIssue.length + 2)];

    [nextIssueSS addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextC] range:NSMakeRange(1, nextIssue.length)];
    self.nextLabel.attributedText = nextIssueSS;
    
    NSMutableAttributedString *issueSS = [[NSMutableAttributedString alloc]initWithString:issueS];
    [issueSS addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextB] range:NSMakeRange(0, issue.length + 8)];

    [issueSS addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] OpenLotteryVC_ColorLabs_TextC] range:NSMakeRange(1, issue.length)];

    self.currentLabel.attributedText = issueSS;

    @weakify(self)
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    [self.countDownForLabel countDownWithStratTimeStamp:now finishTimeStamp:finishLongLong completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        @strongify(self)
        NSString * hourS;
        NSString * minS;
        NSString * secondS;
        
        if (hour<10) {
            hourS = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourS = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            minS = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            minS = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            secondS = [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            secondS = [NSString stringWithFormat:@"%ld",(long)second];
        }
        if([hourS integerValue]<=0){
            self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",minS,secondS];
        }else{
            self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
        }
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if(totoalSecond ==0){
            self.timeLabel.text = @"开奖中";
//            return ;
//            [[CPTOpenLotteryManager shareManager] refreshModel:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
//                if(isSuccess){
//                    //                    [weakSelf configUIByModel:data target:weakSelf];
//                }
//            }];
//        }else{
//            //            [weakSelf pk10Anmation];
        }
    }];
}

- (void)actModel:(LotteryInfoModel *)model{
    LotteryInfoModel * infoModel = model;
    [self configTimer:infoModel.nextTime nextIssue:infoModel.nextIssue issue:infoModel.issue];
    NSArray *numarray = [infoModel.number componentsSeparatedByString:@","];
    for (NSInteger i = 0; i< numarray.count; i++) {
        //        if (_titleBtnArray.count-1<i) {
        //            break;
        //        }
        NSString *num = numarray[i];
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:num forState:UIControlStateNormal];
//        btn.titleLabel.font = BOLDFONT(14);
//        [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
        [btn setBackgroundImage:IMAGE(@"kj_lq") forState:UIControlStateNormal];
    }
//    UILabel *lbl = _subTitleArray[0];
//    lbl.text = [NSString stringWithFormat:@"P5和值：%ld        P3和值：%ld",(long)p5,(long)p3];
}

@end
