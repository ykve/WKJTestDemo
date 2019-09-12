//
//  CPTBuyHeadViewTableViewCell
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyHeadViewTableViewCell.h"
#import<XXShieldSDK.h>
#import "NiuWinLabel.h"
#import "BallTool.h"

@interface CPTBuyHeadViewTableViewCell()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{

}

@end

@implementation CPTBuyHeadViewTableViewCell

- (void)dealloc{
    [_subTitleArray removeAllObjects];
    [_titleBtnArray removeAllObjects];
    _subTitleArray = nil;
    _titleBtnArray = nil;
}

- (void)awakeFromNib{
    [super awakeFromNib];

    if(!_subTitleArray)_subTitleArray = [NSMutableArray array];
    if(!_titleBtnArray)_titleBtnArray = [NSMutableArray array];
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionViewLine_C];
    self.dateL.textColor = [[CPTThemeConfig shareManager] Buy_HeadView_Title_C];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI{
    if(_titleBtnArray){
        if(_titleBtnArray.count>0){
            return;
        }
    }
    MBLog(@"type: %ld",(long)self.type);
    switch (self.type) {
        case CPTBuyTicketType_AoZhouACT:
        {
            CGFloat width = 20;
            CGFloat tmpX = 5;
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
                            make.left.offset(112);
                        }else{
                            make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                        }
                        make.top.offset(10);
                    }else{
                        if(i==10){
                            make.left.offset(112);
                        }else{
                            make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                        }
                        make.top.offset(5 + width +8);
                    }
                    
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UILabel * tmpL;
            for(NSInteger i=0;i<4;i++){
                UILabel * la = [[UILabel alloc] init];
                la.layer.borderWidth = 0.5;
                la.layer.cornerRadius = 3;
                la.font = FONT(11);
                la.textAlignment = NSTextAlignmentCenter;
                la.backgroundColor = CLEAR;
                [self.contentView addSubview:la];
                UIButton *btn = _titleBtnArray[i+10];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btn.mas_bottom).offset(5);
                    if(i==0){
                        make.left.equalTo(btn);
                    }else{
                        make.left.equalTo(tmpL.mas_right).offset(10);
                    }
                    make.height.offset(17);
                    make.width.offset(32);
                }];
                
                la.layer.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_Label_border].CGColor;
                la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                
                tmpL = la;
                [_subTitleArray addObject:la];
            }
        }
            break;
        case CPTBuyTicketType_LiuHeCai: case CPTBuyTicketType_OneLiuHeCai: case CPTBuyTicketType_FiveLiuHeCai: case CPTBuyTicketType_ShiShiLiuHeCai:
        {
            CGFloat width = 30;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*7-14-10)/6;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<7;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(12);
                [btn setTitleColor:BLACK forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(-3, 0, 0, 0)];
                [self.contentView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(tmpX+122);
                    }else if(i!=6){
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(14);
                    }
                    make.top.offset(10);
                    make.width.height.offset(width);
                }];
                if(i==6){
                    UIButton * im = [UIButton buttonWithType:UIButtonTypeCustom];
                    im.backgroundColor = CLEAR;
                    im.titleLabel.font = FONT(12);
                    im.userInteractionEnabled = NO;
                    [im setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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
                la.textColor = [UIColor grayColor];
                la.backgroundColor = CLEAR;
                [self.contentView addSubview:la];
                UIButton *btn = _titleBtnArray[i];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btn.mas_bottom);
                    make.centerX.equalTo(btn);
                    make.width.equalTo(btn).offset(tmpX);
                    make.height.offset(20);
                }];
                [_subTitleArray addObject:la];
                
                la.layer.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_Label_border].CGColor;
                la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
            }
        }
            break;
        case CPTBuyTicketType_HaiNanQiXingCai:{
            CGFloat width = 35;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*5-10)/5;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<4;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(14);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(tmpX+122);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(10);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UILabel *tmpL;
            for(NSInteger i=0;i<1;i++){
                UILabel * la = [[UILabel alloc] init];
//                la.layer.borderWidth = 0.5;
//                la.layer.borderColor = [UIColor colorWithHex:@"d8d9d6"].CGColor;
//                la.layer.cornerRadius = 3;
                la.font = FONT(12);
                la.textAlignment = NSTextAlignmentCenter;
                la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                la.backgroundColor = CLEAR;
                [self.contentView addSubview:la];
                UIButton *btn = _titleBtnArray[i];
                [la mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btn.mas_bottom).offset(7);
                    if(i==0){
                        make.left.equalTo(btn).offset(3);
                    }else{
                        make.left.equalTo(tmpL.mas_right).offset(10);
                    }
                    make.width.offset(50);
                    make.height.offset(16);
                }];
                tmpL = la;
                [_subTitleArray addObject:la];
                la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                
            }
        }break;
        case CPTBuyTicketType_PK10:case CPTBuyTicketType_TenPK10:case CPTBuyTicketType_FivePK10:case CPTBuyTicketType_JiShuPK10:case CPTBuyTicketType_AoZhouF1:case CPTBuyTicketType_XYFT:case CPTBuyTicketType_FantanXYFT:case CPTBuyTicketType_FantanPK10:
        {
            CGFloat width = 20;
            CGFloat tmpX = (SCREEN_WIDTH-140- width*10-10)/9;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<10;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(12);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(tmpX+122);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(10);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            if(self.categoryId == CPTBuyCategoryId_FT){
                
            }else{
                for(NSInteger i=0;i<_titleBtnArray.count-2;i++){
                    UILabel * la = [[UILabel alloc] init];
                    la.layer.borderWidth = 0.5;
                    la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                    la.layer.cornerRadius = 3;
                    la.font = FONT(12);
                    la.textAlignment = NSTextAlignmentCenter;
                    la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                    la.backgroundColor = CLEAR;
                    [self.contentView addSubview:la];
                    UIButton *btn = _titleBtnArray[i];
                    [la mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(btn.mas_bottom).offset(4);
                        make.centerX.equalTo(btn);
                        make.width.equalTo(btn);
                        make.height.equalTo(btn);
                    }];
                    [_subTitleArray addObject:la];
                    la.layer.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_Label_border].CGColor;
                    la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                }
            }
            
        }
            break;

        case CPTBuyTicketType_SSC:case CPTBuyTicketType_XJSSC:case CPTBuyTicketType_TJSSC:case CPTBuyTicketType_TenSSC:case CPTBuyTicketType_FiveSSC:case CPTBuyTicketType_JiShuSSC:case CPTBuyTicketType_FFC:case CPTBuyTicketType_3D:case CPTBuyTicketType_AoZhouShiShiCai:case CPTBuyTicketType_PaiLie35:case CPTBuyTicketType_NiuNiu_KuaiLe:case CPTBuyTicketType_FantanSSC:
        {
            CGFloat width = 26;
            CGFloat tmpX = 15;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<5;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(16);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(tmpX+102);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(10);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UILabel *tmpL;
            if(_categoryId == CPTBuyCategoryId_FT ||self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
                
            }else{
                if(self.type == CPTBuyTicketType_PaiLie35){
                    for(NSInteger i=0;i<1;i++){
                         UILabel * la = [[UILabel alloc] init];
                        la.font = FONT(12);
                        la.textColor = [UIColor colorWithHex:@"999999"];
                        la.backgroundColor = CLEAR;
                        [self.contentView addSubview:la];
                        la.textAlignment = NSTextAlignmentLeft;
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
//                            if(i==0){
                                make.left.offset(tmpX+102+width);
//                            }else{
//                                la.textAlignment = NSTextAlignmentCenter;
//                                make.right.equalTo(tmpBtn.mas_right);
//                            }
                            make.top.equalTo(tmpBtn.mas_bottom);
                            make.width.offset(250);
                            make.height.offset(25);
                        }];
                        [_subTitleArray addObject:la];
                        la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                        
                    }
                }else{
                    for(NSInteger i=0;i<_titleBtnArray.count-1;i++){
                        UILabel * la = [[UILabel alloc] init];
                        la.layer.borderWidth = 0.5;
                        la.layer.borderColor = [UIColor colorWithHex:@"666666"].CGColor;
                        la.layer.cornerRadius = 3;
                        la.font = FONT(12);
                        la.textAlignment = NSTextAlignmentCenter;
                        la.textColor = [UIColor colorWithHex:@"d8d9d6"];
                        la.backgroundColor = CLEAR;
                        [self.contentView addSubview:la];
                        UIButton *btn = _titleBtnArray[i];
                        [la mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(btn.mas_bottom).offset(7);
                            if(i==0){
                                make.left.equalTo(btn).offset(3);
                            }else{
                                make.left.equalTo(tmpL.mas_right).offset(10);
                            }
                            make.width.offset(23);
                            make.height.offset(16);
                            
                        }];
                        tmpL = la;
                        [_subTitleArray addObject:la];
                        la.layer.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_Label_border].CGColor;
                        la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
                    }
                }
            }
            
        }
            break;
        case CPTBuyTicketType_PCDD:
        {
            CGFloat width = 35;
            CGFloat tmpX = (SCREEN_WIDTH-122- width*3-10-70)/5;
            __block UIButton * tmpBtn;
            for(NSInteger i=0;i<3;i++){
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = CLEAR;
                btn.titleLabel.font = BOLDFONT(18);
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
                [self.contentView addSubview:btn];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if(i==0){
                        make.left.offset(tmpX+122);
                    }else{
                        make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                    }
                    make.top.offset(10);
                    make.width.height.offset(width);
                }];
                tmpBtn = btn;
                [_titleBtnArray addObject:btn];
            }
            UILabel * la = [[UILabel alloc] init];
            la.layer.borderWidth = 0.5;
            la.layer.borderColor = [UIColor colorWithHex:@"d8d9d6"].CGColor;
            la.layer.cornerRadius = 3;
            la.font = FONT(12);
            la.textAlignment = NSTextAlignmentCenter;
            la.textColor = [UIColor colorWithHex:@"d8d9d6"];
            la.backgroundColor = CLEAR;
            [self.contentView addSubview:la];
            [la mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tmpBtn.mas_right).offset(tmpX);
                make.centerY.equalTo(tmpBtn);
                make.width.offset(70);
                make.height.offset(25);
            }];
            [_subTitleArray addObject:la];
            la.layer.borderColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_Label_border].CGColor;
            la.textColor = [[CPTThemeConfig shareManager] CO_BuyLot_HeadView_LabelText];
        }
            break;
        default:
            break;
    }
}

- (void)sixModel:(SixInfoModel *)model{
    _model = model;
    self.dateL.text = [NSString stringWithFormat:@"第%@期",_model.issue];
    NSArray * numberArry = [_model.numberstr componentsSeparatedByString:@","];
    NSArray * shengxiaoArry = [_model.shengxiao2 componentsSeparatedByString:@","];

    for (int i = 0; i< 7; i++) {
        NSString *number = numberArry[i];
        NSString *shengxiao = shengxiaoArry[i];
        NSString *wuxin = [Tools numbertowuxin:number];
        UIButton *btn = self.titleBtnArray[i];
        UILabel  *lab = self.subTitleArray[i];
        
        lab.text = [NSString stringWithFormat:@"%@/%@",shengxiao,wuxin];
        [btn setTitle:number forState:UIControlStateNormal];
        [btn setBackgroundImage:[Tools numbertoimage:number Withselect:NO] forState:UIControlStateNormal];
    }
}

- (void)pk10Model:(PK10InfoModel *)pk10Model{
    self.dateL.text = pk10Model.issue;
    NSArray *numbers = [pk10Model.number componentsSeparatedByString:@","];
    if(!numbers){return;}
    if(numbers.count < 10){return;}
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
    if(_categoryId == CPTBuyCategoryId_FT){
        NSInteger total = 0;
        for(NSInteger i = 0;i<3;i++){
            NSString *num = numbers[i];
            total += num.integerValue;
            MBLog(@"%@",num);
        }
        MBLog(@"%ld",(long)total);
        NSInteger x = total%4;
        _fantanLabel.text = [NSString stringWithFormat:@"和值%ld %@ 4 = %ld",total,@"%",x==0?4:x];
        _fantanLabel.textColor = [[CPTThemeConfig shareManager] CO_Fantan_HeadView_Label];
    }else{        for (int i = 0; i < _subTitleArray.count; i++) {
            UILabel *lbl = _subTitleArray[i];
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
    
    for (int i = 0; i< numbers.count; i++) {
        
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:numbers[i] forState:UIControlStateNormal];
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        int num = [[NSString stringWithFormat:@"%@", numbers[i]] intValue];
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [BallTool getColorWithNum:num];

//        switch (num) {
//            case 1:
//                btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color1];
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
}

- (void)sscModel:(ChongqinInfoModel *)model{
    ChongqinInfoModel * cqsscModel = model;
//    self.dateL.text = [cqsscModel.issue substringFromIndex:8];

    self.dateL.text = cqsscModel.issue;
    if(_titleBtnArray.count<1)return;
    if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe||self.type == CPTBuyTicketType_FantanSSC){
        NSString *str = self.type == CPTBuyTicketType_FantanSSC?cqsscModel.numberstr:cqsscModel.number;
        for (NSInteger i = 0; i< str.length; i++) {
            NSString *num = [str substringWithRange:NSMakeRange(i, 1)];
            if(i>_titleBtnArray.count-1){
                continue;
            }
            UIButton *btn = [_titleBtnArray objectAtIndex:i];
            [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
            [btn setTitle:num forState:UIControlStateNormal];
        }
    }else{
        for (NSInteger i = 0; i< cqsscModel.numbers.count; i++) {
            NSString *num = cqsscModel.numbers[i];
            if(i>_titleBtnArray.count-1){
                continue;
            }
            UIButton *btn = [_titleBtnArray objectAtIndex:i];
            [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
            [btn setTitle:num forState:UIControlStateNormal];
        }
    }
    int num1 = [[cqsscModel.number substringWithRange:NSMakeRange(0, 1)] intValue];
    int num2 = [[cqsscModel.number substringWithRange:NSMakeRange(1, 1)] intValue];
    int num3 = [[cqsscModel.number substringWithRange:NSMakeRange(2, 1)] intValue];
    int num4 = [[cqsscModel.number substringWithRange:NSMakeRange(3, 1)] intValue];
    int num5 = [[cqsscModel.number substringWithRange:NSMakeRange(4, 1)] intValue];
    if(_categoryId == CPTBuyCategoryId_FT){
        NSInteger total = 0;
        for(NSInteger i = 0;i<cqsscModel.numbers.count;i++){
            NSString *num = cqsscModel.numbers[i];
            total += num.integerValue;
            MBLog(@"%@",num);
        }
        MBLog(@"%ld",(long)total);
        NSInteger x = total%4;
        _fantanLabel.text = [NSString stringWithFormat:@"和值%ld %@ 4 = %ld",total,@"%",x==0?4:x];
       
       _fantanLabel.textColor = [[CPTThemeConfig shareManager] CO_Fantan_HeadView_Label];
    }else{
        if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
            if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
                NSArray *names = [model.niuWinner componentsSeparatedByString:@","];
                for (UIView *v in _niuWinBgView.subviews) {
                    [v removeFromSuperview];
                }
                for(int i=0;i< names.count;i++){
                    NiuWinLabel *lab = [[NiuWinLabel alloc] initWithFrame:CGRectMake(34*i+(SCREEN_WIDTH-122- 35*5-10)/5+23, 10, 32, 20)];
                    lab.text = names[i];
                    lab.backgroundColor = [UIColor clearColor];
                    [_niuWinBgView addSubview:lab];
                }
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
    
}

- (void)pcddModel:(PCInfoNewModel *)model{
    self.dateL.text = model.issue;

    NSArray *numarray = [model.number componentsSeparatedByString:@","];
    NSInteger totle = [numarray[0]integerValue] + [numarray[1]integerValue] + [numarray[2]integerValue];
    NSString * totleString = [NSString stringWithFormat:@"%ld",(long)totle];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"和值 %@",totleString]];

    [attrStr addAttribute:NSForegroundColorAttributeName value: [[CPTThemeConfig shareManager] Fantan_MoneyColor] range:NSMakeRange(3, [totleString length])];

    UILabel * jj = _subTitleArray[0];
    jj.attributedText = attrStr;
    MBLog(@"attrStr%@",attrStr);
    for (int i = 0; i< _titleBtnArray.count; i++) {
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:numarray[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
    }
}

- (void)pailie35Model:(ChongqinInfoModel *)model{
    ChongqinInfoModel * cqsscModel = model;
    //    self.dateL.text = [cqsscModel.issue substringFromIndex:8];
    
    self.dateL.text = cqsscModel.issue;
    for (NSInteger i = 0; i< cqsscModel.numbers.count; i++) {
        NSString *num = cqsscModel.numbers[i];
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
        [btn setTitle:num forState:UIControlStateNormal];
    }
}

- (void)lotteryInfoModel:(LotteryInfoModel *)model{
    LotteryInfoModel * infoModel = model;
//    [self configTimer:infoModel.nextTime nextIssue:infoModel.nextIssue issue:infoModel.issue];
    self.dateL.text = model.issue;
    NSArray *numarray = [infoModel.number componentsSeparatedByString:@","];
    if(numarray.count<2){
        return;
    }
    NSInteger count = numarray.count;
    if(self.type == CPTBuyTicketType_HaiNanQiXingCai){
        count = 4;
    }else     if(self.type == CPTBuyTicketType_3D){
        count = 3;
    }
    if(_titleBtnArray.count<=0)return;
    for (NSInteger i = 0; i< count; i++) {
        //        if (_titleBtnArray.count-1<i) {
        //            break;
        //        }
        NSString *num = numarray[i];
        UIButton *btn = [_titleBtnArray objectAtIndex:i];
        [btn setTitle:num forState:UIControlStateNormal];
        [btn setBackgroundImage:IMAGE(@"kj_hq") forState:UIControlStateNormal];
        if(self.type == CPTBuyTicketType_Shuangseqiu ){
            if(i>=6){
                [btn setBackgroundImage:IMAGE(@"kj_lq") forState:UIControlStateNormal];
            }
        }
        else if(self.type == CPTBuyTicketType_DaLetou){
            if(i>=5){
                [btn setBackgroundImage:IMAGE(@"kj_lq") forState:UIControlStateNormal];
            }
        }
        if(self.type == CPTBuyTicketType_QiLecai ){
            if(i>=7){
                [btn setBackgroundImage:IMAGE(@"kj_lq") forState:UIControlStateNormal];
            }
        }
    }
 
    if(self.type == CPTBuyTicketType_PaiLie35){
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
    }else     if(self.type == CPTBuyTicketType_3D){
        int num1 = [numarray[0] intValue];
        int num2 = [numarray[1] intValue];
        int num3 = [numarray[2] intValue];

        NSInteger p3 = num1 + num2 + num3;
        for (NSInteger i = 0; i< _subTitleArray.count; i++) {
            UILabel *lbl = _subTitleArray[i];
            lbl.layer.borderWidth = 0.0;
            if(i==0){
                [lbl mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.offset(100.0);
                }];
                lbl.textAlignment = NSTextAlignmentLeft;
                lbl.text = [NSString stringWithFormat:@"和值：%ld",(long)p3];
            }
        }
       
    }else if(self.type == CPTBuyTicketType_AoZhouShiShiCai){
        int num1 = [numarray[0] intValue];
        int num2 = [numarray[1] intValue];
        int num3 = [numarray[2] intValue];
        int num4 = [numarray[3] intValue];
        int num5 = [numarray[4] intValue];
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
    }else if (self.type == CPTBuyTicketType_HaiNanQiXingCai){
        int num1 = [numarray[0] intValue];
        int num2 = [numarray[1] intValue];
        int num3 = [numarray[2] intValue];
        int num4 = [numarray[3] intValue];
        UILabel * lbl = _subTitleArray[0];
        lbl.text = [NSString stringWithFormat:@"和值%d",(num1 + num2 + num3 + num4 )];
    }
    else     if(self.type == CPTBuyTicketType_AoZhouACT){
        NSInteger totle = 0;

        for (NSInteger i = 0; i< _titleBtnArray.count; i++) {
            UIButton *btn = _titleBtnArray[i];
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
            NSString *num = numarray[i];
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
            totle = totle + num.integerValue;
        }
        if(_subTitleArray.count!=4)
        {
            return;
        }
        NSString * oneS;
        NSString * twoS;
        NSString * threeS;
        for (NSInteger i = 0; i < 4; i++) {
            UILabel *lbl = _subTitleArray[i];
            switch (i) {
                case 0:{
                    if(totle>810){
                        oneS = @"大";
                    }else if (totle<810){
                        oneS = @"小";
                    }else{
                        oneS = @"和";
                    }
                    lbl.text = [NSString stringWithFormat:@"%@",oneS];
                }
                    break;
                case 1:{
                    if(totle%2 ==0){
                        twoS = @"双";
                    }else{
                        twoS = @"单";
                    }
                    lbl.text = [NSString stringWithFormat:@"%@%@",oneS,twoS];
                }
                    break;
                case 2:{
                    //                        金（210～695）、木（696～763）、水（764～855）、火（856～923）和土（924～1410）
                    if(totle>=210 && totle <=695){
                        threeS = @"金";
                    }else if(totle>=696 && totle <=763){
                        threeS = @"木";
                    }else if(totle>=764 && totle <=855){
                        threeS = @"水";
                    }else if(totle>=856 && totle <=923){
                        threeS = @"火";
                    }else if(totle>=924 && totle <=1410){
                        threeS = @"土";
                    }
                    lbl.text = [NSString stringWithFormat:@"%@",threeS];
                }
                    break;
                case 3:{
                    lbl.text = [NSString stringWithFormat:@"%ld",(long)totle];
                }
                    break;
                default:
                    break;
            }
        }
    }

    
}
@end
