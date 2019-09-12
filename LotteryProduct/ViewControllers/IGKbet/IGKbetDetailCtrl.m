//
//  IGKbetDetailCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/16.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetDetailCtrl.h"
#import "IGKbetSixCell.h"
#import "IGKbetchongqinCell.h"
#import "IGKbetPK10Cell.h"
#import "UIImage+color.h"
#import "IGKbetResultCell.h"
#import "OpenListTableViewCell.h"
#import "NewLotteryDetailHeader.h"
#import "BallTool.h"


@interface IGKbetDetailCtrl ()

@property (nonatomic, strong) IGKbetSixCell *sixhead;
@property (nonatomic, strong) IGKbetchongqinCell *chongqinhead;
@property (nonatomic, strong) IGKbetPK10Cell *pk10head;
@property (nonatomic, strong) IGKbetchongqinCell *pchead;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong)OpenListTableViewCell *aoZhouSSCHeader;
@property (nonatomic, strong)NewLotteryDetailHeader *newHeader;;



/**北京PK10   各种颜色*/
@property (nonatomic, strong) UIImage *backgroundColor1;
@property (nonatomic, strong) UIImage *backgroundColor2;
@property (nonatomic, strong) UIImage *backgroundColor3;
@property (nonatomic, strong) UIImage *backgroundColor4;
@property (nonatomic, strong) UIImage *backgroundColor5;
@property (nonatomic, strong) UIImage *backgroundColor6;
@property (nonatomic, strong) UIImage *backgroundColor7;
@property (nonatomic, strong) UIImage *backgroundColor8;
@property (nonatomic, strong) UIImage *backgroundColor9;
@property (nonatomic, strong) UIImage *backgroundColor10;


@end

@implementation IGKbetDetailCtrl

-(IGKbetSixCell *)sixhead {
    
    if (!_sixhead) {
        
        _sixhead = [[[NSBundle mainBundle]loadNibNamed:@"IGKbetSixCell" owner:self options:nil]firstObject];
        _sixhead.nextimgv.hidden = YES;
        _sixhead.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110/SCAL);
        _sixhead.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];
        _sixhead.titlelab.textColor = [[CPTThemeConfig shareManager] QicCiDetailSixheadTitleColor];
    }
    return _sixhead;
}

-(IGKbetchongqinCell *)chongqinhead{
    
    if (!_chongqinhead) {
        
        _chongqinhead = [[[NSBundle mainBundle]loadNibNamed:@"IGKbetchongqinCell" owner:self options:nil]firstObject];
        _chongqinhead.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130/SCAL);
        _chongqinhead.bottomMargin = 0;
        _chongqinhead.centerY.constant = 15;
        _chongqinhead.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];
        _chongqinhead.nextimgv.hidden = YES;
        _chongqinhead.titlelab.textColor = [[CPTThemeConfig shareManager] QicCiDetailSixheadTitleColor];

    }
    return _chongqinhead;
}

-(IGKbetPK10Cell *)pk10head {
    
    if (!_pk10head) {
        
        _pk10head = [[[NSBundle mainBundle]loadNibNamed:@"IGKbetPK10Cell" owner:self options:nil]firstObject];
//        _pk10head.backgroundColor = MAINCOLOR;
        _pk10head.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140/SCAL);
        _pk10head.nextimgv.hidden = YES;
        _pk10head.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];
        _pk10head.titlelab.textColor = [[CPTThemeConfig shareManager] QicCiDetailSixheadTitleColor];

    }
    return _pk10head;
}

-(IGKbetchongqinCell *)pchead {
    
    if (!_pchead) {
        
        _pchead = [[[NSBundle mainBundle]loadNibNamed:@"IGKbetchongqinCell" owner:self options:nil]firstObject];
        _pchead.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130/SCAL);
        _pchead.centerY.constant = 10;
        _pchead.nextimgv.hidden = YES;
        _pchead.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];
        _pchead.titlelab.textColor = [[CPTThemeConfig shareManager] QicCiDetailSixheadTitleColor];

    }
    return _pchead;
}

- (OpenListTableViewCell *)aoZhouSSCHeader{
    
    if (!_aoZhouSSCHeader) {
        _aoZhouSSCHeader = [[OpenListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OpenListTableViewCellID];
        _aoZhouSSCHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
        _aoZhouSSCHeader.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];
        _aoZhouSSCHeader.nameLabel.textColor = [[CPTThemeConfig shareManager] QicCiDetailSixheadTitleColor];

    }
    return _aoZhouSSCHeader;
}

- (NewLotteryDetailHeader *)newHeader{
    if (!_newHeader) {
        _newHeader = [[[NSBundle mainBundle]loadNibNamed:@"NewLotteryDetailHeader" owner:self options:nil]firstObject];
        
        if (self.type == CPTBuyTicketType_AoZhouACT) {
            _newHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
        }
        _newHeader.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];
        _newHeader.titleLbl.textColor = [[CPTThemeConfig shareManager] QicCiDetailSixheadTitleColor];
        _newHeader.subTitleLbl.textColor = [[CPTThemeConfig shareManager] QiCiXQSixHeaderSubtitleTextColor];
        

    }
    return _newHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE;
    self.titlestring = @"期次详情";
    self.tableView.backgroundColor = [[CPTThemeConfig shareManager] QiCiDetailCellBackgroundColor];

    [self.tableView registerNib:[UINib nibWithNibName:@"IGKbetResultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 35;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT);
    self.titlesArray = nil;

    if (self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC || self.type == CPTBuyTicketType_FFC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC || self.type == CPTBuyTicketType_NiuNiu_KuaiLe || self.type == CPTBuyTicketType_Shuangseqiu|| self.type == CPTBuyTicketType_DaLetou|| self.type == CPTBuyTicketType_PaiLie35|| self.type == CPTBuyTicketType_3D|| self.type == CPTBuyTicketType_QiLecai || self.type == CPTBuyTicketType_AoZhouShiShiCai) {
        
        self.titlesArray = @[@"五星",@"前四",@"后四",@"前三",@"中三",@"后三",@"前二",@"后二",@"五星大小单双",@"五星总和大小",@"五星总和大小单双组合",@"前四大小单双",@"后四大小单双",@"前三大小单双",@"后三大小单双",@"前二大小单双",@"后二大小单双"];
        self.tableView.tableHeaderView = self.chongqinhead;
        self.tableView.tableHeaderView.backgroundColor = [[CPTThemeConfig shareManager] chongqinheadBackgroundColor];

        for (UILabel *lbl in self.chongqinhead.numSubTitleLbls) {
            lbl.hidden = YES;
        }
        
        self.chongqinhead.titlelab.text = self.lotteryname;
        
        self.chongqinhead.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",[self.pcmodel.issue substringFromIndex:self.type == CPTBuyTicketType_FFC ? 9 : self.pcmodel.issue.length >= 8 ? 8 : self.pcmodel.issue.length],self.pcmodel.time];
        
        
        NSMutableArray *numarray = [NSMutableArray array];
        
        if ([self.pcmodel.number  containsString:@","]) {
            [numarray addObjectsFromArray:[self.pcmodel.number componentsSeparatedByString:@","]];
        }else{
            for (int i = 0; i < self.pcmodel.number.length; i++) {
                [numarray addObject:[self.pcmodel.number substringWithRange:NSMakeRange(i, 1)]];
            }
        }
        
        self.chongqinhead.totallab.text = [NSString stringWithFormat:@"和值：%d",[numarray[0]intValue]+[numarray[1]intValue]+[numarray[2]intValue]+[numarray[3]intValue]+[numarray[4]intValue]];
        
        NSInteger count = numarray.count;
        if(self.type == CPTBuyTicketType_3D){
            count = 3;
        }

        for (UIButton *btn in self.chongqinhead.numberlabs) {
            
            NSString *num = numarray[btn.tag - 100];
            
            [btn setTitle:num forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        
        [self initchongqinData];
    }
    else if (self.type == CPTBuyTicketType_LiuHeCai ||self.type == CPTBuyTicketType_OneLiuHeCai ||self.type == CPTBuyTicketType_FiveLiuHeCai||self.type == CPTBuyTicketType_ShiShiLiuHeCai) {
        
        self.titlesArray = @[@"特码",@"正码",@"正码1",@"正码2",@"正码3",@"正码4",@"正码5",@"正码6",@"正1特",@"正2特",@"正3特",@"正4特",@"正5特",@"正6特",@"半波",@"全尾",@"特尾",@"平特",@"特肖",@"五行"];
        self.tableView.tableHeaderView = self.sixhead;

        self.sixhead.titlelab.text = self.lotteryname;
        self.sixhead.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",self.sixmodel.issue,self.sixmodel.time];
        int i = 0;
        NSArray * numberArry = [self.sixmodel.numberstr componentsSeparatedByString:@","];
        NSArray * shengxiaoArry = [self.sixmodel.shengxiao2 componentsSeparatedByString:@","];

        for (NSString *str in numberArry) {
            UIButton *btn = [self.sixhead.numberBtns objectAtIndex:i];
            UILabel *lab = [self.sixhead.numberlabs objectAtIndex:i];
            [btn setTitle:str forState:UIControlStateNormal];
            [btn setBackgroundImage:[Tools numbertoimage:str Withselect:NO] forState:UIControlStateNormal];
            NSString *wuxing = [Tools numbertowuxin:numberArry[i]];
            lab.text = [NSString stringWithFormat:@"%@/%@", shengxiaoArry[i],wuxing]					;
            
            i++;
        }
        [self initsixData:self.sixmodel.time];
    } else if (self.type == CPTBuyTicketType_PK10 || self.type == CPTBuyTicketType_XYFT|| self.type == CPTBuyTicketType_TenPK10|| self.type == CPTBuyTicketType_FivePK10|| self.type == CPTBuyTicketType_JiShuPK10|| self.type == CPTBuyTicketType_AoZhouF1|| self.type == CPTBuyTicketType_NiuNiu_JiShu|| self.type == CPTBuyTicketType_NiuNiu_AoZhou|| self.type == CPTBuyTicketType_FantanPK10|| self.type == CPTBuyTicketType_FantanXYFT) {
        
        self.titlesArray = @[@"冠亚和两面",@"冠军两面",@"亚军两面",@"第三名两面",@"第四名两面",@"第五名两面",@"第六名两面",@"第七名两面",@"第八名两面",@"第九名两面",@"第十名两面",@"冠亚和",@"猜冠军",@"猜亚军",@"猜第三名",@"猜第四名",@"猜第五名",@"猜第六名",@"猜第七名",@"猜第八名",@"猜第九名",@"猜第十名",@"定位胆前五",@"定位胆后五"];
        self.tableView.tableHeaderView = self.pk10head;
        
        self.pk10head.titlelab.text = self.lotteryname;
        self.pk10head.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",self.pk10model.issue.length > 8 ? [self.pk10model.issue substringFromIndex:8] : self.pk10model.issue ,self.pk10model.time];
        
        NSArray *numArray;
        if (self.pk10model.num.count > 0) {
            numArray = [NSArray arrayWithArray:self.pk10model.num];
        }else{
            numArray = [self.pk10model.number componentsSeparatedByString:@","];
        }
        
        for (UIButton *btn in self.pk10head.numberBtns) {
        
            [btn setTitle:STRING(numArray[btn.tag-100]) forState:UIControlStateNormal];
            [btn setTitleColor:HomeMainWhiteColor forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            
            int num = [[NSString stringWithFormat:@"%@", numArray[btn.tag-100]] intValue];
            btn.backgroundColor = [BallTool getColorWithNum:num];

//            switch (num) {
//                case 1:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color1];
//                    break;
//                case 2:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color2];
//                    break;
//                case 3:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color3];
//                    break;
//                case 4:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color4];
//                    break;
//                case 5:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color5];
//                    break;
//                case 6:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color6];
//                    break;
//                case 7:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color7];
//                    break;
//                case 8:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color8];
//                    break;
//                case 9:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color9];
//                    break;
//                case 10:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color10];
//                    break;
//                case 0:
//                    btn.backgroundColor = [[CPTThemeConfig shareManager] PK10_color10];
//                    break;
//
//                default:
//                    break;
//            }

        }
        
        NSArray *numbers = self.pk10model.num;
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
        
        
        
        for (int i = 0; i < self.pk10head.numberLbls.count; i++) {
            UILabel *lbl =self.pk10head.numberLbls[i];
            lbl.layer.masksToBounds = YES;
            lbl.layer.cornerRadius = 2;
            lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
            lbl.layer.borderWidth = 1;
            lbl.textColor = [UIColor darkGrayColor];
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
        
        
        [self initpk10Data];
    }else if(self.type == CPTBuyTicketType_PCDD){
        
        self.titlesArray = @[@"两面",@"色波",@"豹子",@"特码包三",@"特码"];
        self.tableView.tableHeaderView = self.pchead;
        
        self.pchead.titlelab.text = self.lotteryname;
        self.pchead.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",self.pcmodel.issue,self.pcmodel.time];
        
        
        NSArray *numbrs = [self.pcmodel.number componentsSeparatedByString:@","];
        
        NSArray *array = [NSArray arrayWithObjects:self.pchead.numberlabs[0],self.pchead.numberlabs[1],self.pchead.numberlabs[2], nil];
        
        int num1 = [numbrs[0] intValue];
        int num2 = [numbrs[1] intValue];
        int num3 = [numbrs[2] intValue];

        self.pchead.totallab.text = [NSString stringWithFormat:@"和值：%@",[NSString stringWithFormat:@"%d", num1 + num2 + num3]];

        for (UIButton *btn in array) {
            
            btn.hidden = btn.tag > 102 ? YES : NO;
            
            if (btn.tag< 103) {
                
                [btn setTitle:numbrs[btn.tag -100] forState:UIControlStateNormal];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
                
            }
            //            btn.size = CGSizeMake(45, 45);
            
        }
        
        for (UIButton *btn in self.pchead.numberlabs) {
            btn.hidden = btn.tag > 102 ? YES : NO;
        }
        
        for (UILabel *lbl in self.pchead.numSubTitleLbls) {
            lbl.hidden = YES;
        }
        
        [self initpcData];
    }
//    else if(self.type == 27 || self.type == 28|| self.type == 29|| self.type == 30|| self.type == 31|| self.type == 32){//澳洲ACT
//
//        self.titlesArray = @[@"五星",@"前四",@"后四",@"前三",@"中三",@"后三",@"前二",@"后二",@"五星大小单双",@"五星总和大小",@"五星总和大小单双组合",@"前四大小单双",@"后四大小单双",@"前三大小单双",@"后三大小单双",@"前二大小单双",@"后二大小单双"];
//        self.tableView.tableHeaderView = self.newHeader;
//        self.newHeader.titleLbl.text = self.lotteryname;
//        self.newHeader.subTitleLbl.text = [NSString stringWithFormat:@"第%@期 %@",[self.lotteryInfoModel.issue substringFromIndex:self.type == 3 ? 9 : self.lotteryInfoModel.issue.length >= 8 ? 8 : self.lotteryInfoModel.issue.length],self.lotteryInfoModel.time];
//
//        NSMutableArray *numarray = [NSMutableArray array];
//
//        if ([self.lotteryInfoModel.number  containsString:@","]) {
//            [numarray addObjectsFromArray:[self.lotteryInfoModel.number componentsSeparatedByString:@","]];
//        }else{
//            for (int i = 0; i < self.lotteryInfoModel.number.length; i++) {
//                [numarray addObject:[self.lotteryInfoModel.number substringWithRange:NSMakeRange(i, 1)]];
//            }
//        }
//
//        for (int i = 0; i < numarray.count; i++) {
//
//            CGFloat margin = 5;
//            CGFloat w = 30;
//            CGFloat h = w;
//            CGFloat y = (i/10) * (h + margin) + margin ;
//            CGFloat x = margin + (w + margin)*(i%10);
//
//            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//            lbl.backgroundColor = [UIColor redColor];
//            lbl.text = numarray[i];
//            lbl.layer.cornerRadius = lbl.height/2;
//            lbl.layer.masksToBounds = YES;
//            lbl.textAlignment = NSTextAlignmentCenter;
//            lbl.textColor = WHITE;
//            [self.newHeader.contentView addSubview:lbl];
//        }
//
//        NSInteger count = numarray.count;
//        if(self.type == CPTBuyTicketType_3D){
//            count = 3;
//        }
//
////        [self initchongqinData];
//    }
//  else
//      if(self.type == CPTBuyTicketType_PCDD ){
//      [self initpcData];
//  }else

}

- (UIImage *)getBackgroundImage:(UIColor *)color size:(CGSize)size{
    
    UIImage *bacgrroundImage = [[UIImage imageWithColor:color size:size] circleImage];
    return bacgrroundImage;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titlesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 37;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    IGKbetResultCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IGKbetResultCell" owner:self options:nil]firstObject];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);

    cell.titlelab.textColor = cell.infolab.textColor = WHITE;
    cell.backgroundColor = [[CPTThemeConfig shareManager] CO_OpenLotHeaderInSectionView];
    cell.titlelab.text = @"玩法";
    cell.infolab.text = @"投注中奖的号码";
    cell.line.hidden = YES;
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IGKbetResultCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *title = [self.titlesArray objectAtIndex:indexPath.row];
    
    cell.titlelab.text = title;
    MBLog(@"title: %@",title);
    if (self.dataArray) {
        
        cell.infolab.text = [self.dataArray[indexPath.row] isKindOfClass:[NSString class]] == YES ? self.dataArray[indexPath.row] : STRING(self.dataArray[indexPath.row]) ;
    }
      cell.backgroundColor = [[CPTThemeConfig shareManager] QiCiDetailCellBackgroundColor];
    
    return cell;
}




-(void)initchongqinData {
    
    NSString *url = nil;
    if (self.type == CPTBuyTicketType_SSC) {//重庆时时彩
         url = @"/cqsscSg/sgDetails.json";
    }else if (self.type == CPTBuyTicketType_XJSSC) {//新疆时时彩
         url = @"/xjsscSg/sgDetails.json";
    }else if (self.type == CPTBuyTicketType_FFC) {//比特币分分彩
        url = @"/txffcSg/sgDetails.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"sgIssue":self.pcmodel.issue} success:^(BaseData *data) {
        @strongify(self)
        self.dataArray = @[data.data[@"wuxing"],data.data[@"qiansi"],data.data[@"housi"],data.data[@"qiansan"],data.data[@"zhongsan"],data.data[@"housan"],data.data[@"qianer"],data.data[@"houer"],data.data[@"wuxingdxds"],data.data[@"wuxingzhdx"],data.data[@"wuxingzhdxds"],data.data[@"qiansidxds"],data.data[@"housidxds"],data.data[@"qiansandxds"],data.data[@"housandxds"],data.data[@"qianerdxds"],data.data[@"houerdxds"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)initsixData:(NSString *)date {
    
    NSString *url = nil;
    if (self.type == CPTBuyTicketType_LiuHeCai) {
        url = @"/lhcSg/sgDetails.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"date":date} success:^(BaseData *data) {
       @strongify(self)
        self.dataArray = @[data.data[@"tema"],data.data[@"zhengma"],data.data[@"zhengmaOne"],data.data[@"zhengmaTwo"],data.data[@"zhengmaThree"],data.data[@"zhengmaFour"],data.data[@"zhengmaFive"],data.data[@"zhengmaSix"],data.data[@"zhengOne"],data.data[@"zhengTwo"],data.data[@"zhengThree"],data.data[@"zhengFour"],data.data[@"zhengFive"],data.data[@"zhengSix"],data.data[@"banbo"],data.data[@"quanwei"],data.data[@"tewei"],data.data[@"pingte"],data.data[@"texiao"],data.data[@"wuxing"]];
    
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)initpk10Data {
    
    NSString *url = nil;
    if (self.type == CPTBuyTicketType_PK10) {//北京PK10
        url = @"/bjpksSg/sgDetails.json";
    }else if (self.type == CPTBuyTicketType_XYFT) {//幸运飞艇
        url = @"/xyftSg/sgDetails.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"sgIssue":self.pk10model.issue} success:^(BaseData *data) {
  
        @strongify(self)
        self.dataArray = @[data.data[@"guanyahelm"],data.data[@"guanlm"],data.data[@"yalm"],data.data[@"threelm"],data.data[@"fourlm"],data.data[@"fivelm"],data.data[@"sixlm"],data.data[@"sevenlm"],data.data[@"eightlm"],data.data[@"ninelm"],data.data[@"tenlm"],data.data[@"guanyahe"],data.data[@"guan"],data.data[@"ya"],data.data[@"three"],data.data[@"four"],data.data[@"five"],data.data[@"six"],data.data[@"seven"],data.data[@"eight"],data.data[@"nine"],data.data[@"ten"],data.data[@"qianwu"],data.data[@"houwu"]];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)initpcData {
    
    @weakify(self)
    
    [WebTools postWithURL:@"/pceggSg/sgDetails.json" params:@{@"sgIssue":self.pcmodel.issue} success:^(BaseData *data) {
        @strongify(self)
        MBLog(@"%@", data);
        self.dataArray = @[data.data[@"lm"],data.data[@"sebo"],data.data[@"baozi"],data.data[@"baosan"],data.data[@"tema"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
