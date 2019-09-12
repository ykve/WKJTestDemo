//
//  HomeFootView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeFootView.h"
#import "HomeSubCell.h"
#import "HomesubHeader_1View.h"
#import "HomesubHeader_2View.h"
#import "HomesubHeader_3View.h"
#import "HomesubFootView.h"
#import "PCInfoModel.h"
#import "BallTool.h"

@interface HomeFootView ()<WB_StopWatchDelegate>

@property (nonatomic, strong) PCInfoModel *pcmodel;

@property (nonatomic, strong) ChongqinInfoModel *chongqinmodel;

@property (nonatomic, strong) ChongqinInfoModel *xinjiangmodel;

@property (nonatomic, strong) ChongqinInfoModel *tengxunmodel;

@property (nonatomic, strong) PK10InfoModel *pk10model;
@property (nonatomic, strong) PK10InfoModel *azF1model;

@property (nonatomic, strong) PK10InfoModel *feitingmodel;

@property (nonatomic, strong) SixInfoModel *sixmodel;

@property (nonatomic, strong) ZuCaiInfoModel *zucaiModel;

@property (nonatomic, strong) LotteryInfoModel *lotteryInfoModel;



@property (nonatomic, assign) NSInteger curenttime;

/**北京PK10   各种颜色*/
@property (nonatomic, strong) UIColor *background1;
@property (nonatomic, strong) UIColor *background2;
@property (nonatomic, strong) UIColor *background3;
@property (nonatomic, strong) UIColor *background4;
@property (nonatomic, strong) UIColor *background5;
@property (nonatomic, strong) UIColor *background6;
@property (nonatomic, strong) UIColor *background7;
@property (nonatomic, strong) UIColor *background8;
@property (nonatomic, strong) UIColor *background9;
@property (nonatomic, strong) UIColor *background10;


@end

@implementation HomeFootView

-(NSArray *)chongqinArray {
    
    if (!_chongqinArray) {
        _chongqinArray = @[ 
                           @{@"title":@"历史开奖",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_History]},
                           @{@"title":@"遗漏统计",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_YLTJ]},
                           @{@"title":@"今日统计",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_JRTJ]},
                           @{@"title":@"免费推荐",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_MFTJ]},
                           @{@"title":@"曲线图",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_QXT]},
                           @{@"title":@"公式杀号",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_GSSH]}];
    }
    
    return _chongqinArray;
}

-(NSArray *)liuheArray {
    
    if (!_liuheArray) {
        NSString *title = @"心水推荐";
        if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
            title = @"小鱼论坛";
        }
        _liuheArray = @[
                        @{@"title":@"历史开奖",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_History]},
                        @{@"title":@"六合图库",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LHTK]},
                        @{@"title":title,@"icon":[[CPTThemeConfig shareManager] IC_home_sub_XSTJ]},
                        @{@"title":@"挑码助手",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_TMZS]},
                        @{@"title":@"查询助手",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_CXZS]},
                        @{@"title":@"资讯统计",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_ZXTJ]},
                        @{@"title":@"开奖日历",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_KJRL]},
                        @{@"title":@"公式杀号",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_GSSH]},
                        @{@"title":@"AI智能选号",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_AIZNXH]},
                        @{@"title":@"属性参照",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_SXCZ]},
                        @{@"title":@"特码历史",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_TMLS]},
                        @{@"title":@"正码历史",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_ZMLS]},
                        @{@"title":@"尾数大小",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_WSDX]},
                        @{@"title":@"生肖特码",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_SXTM]},
                        @{@"title":@"生肖正码",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_SXZM]},
                        @{@"title":@"波色特码",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_BSTM]},
                        @{@"title":@"波色正码",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_BSZM]},
                        @{@"title":@"特码两面",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_TMLM]},
                        @{@"title":@"特码尾数",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_TMWS]},
                        @{@"title":@"正码尾数",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_ZMWS]},
                        @{@"title":@"正码总分",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_ZMZF]},
                        @{@"title":@"号码波段",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_HMBD]},
                        @{@"title":@"家禽野兽",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_JQYS]},
                        @{@"title":@"连码走势",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LMZS]},
                        @{@"title":@"连肖走势",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LXZS]},
                        @{@"title":@"六合大神",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LHDS]}
                        ];
        
    }
    return _liuheArray;
}

-(NSArray *)beijinArray {
    
    if (!_beijinArray) {
        
        _beijinArray = @[@{@"title":@"历史开奖",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_History]},
                         @{@"title":@"号码遗漏",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_HMYL]},
                         @{@"title":@"今日号码",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_JRHM]},
                         @{@"title":@"免费推荐",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_MFTJ]},
                         @{@"title":@"冷热分析",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LRFX]},
                         @{@"title":@"公式杀号",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_GSSH]},
                         @{@"title":@"冠亚和统计",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_GYHTJ]},
                         @{@"title":@"两面长龙",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LMCL]},
                         @{@"title":@"两面路珠",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LMLZ]},
                         @{@"title":@"两面遗漏",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LMYL]},
                         @{@"title":@"前后路珠",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_QHLZ]},
                         @{@"title":@"两面历史",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_LMLS]},
                         @{@"title":@"冠亚和路珠",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_GYHLZ]},
                         @{@"title":@"横版走势",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_HBZS]}];
    }
    return _beijinArray;
}

-(NSArray *)dandanArray {
    
    if (!_dandanArray) {
        
        _dandanArray = @[@{@"title":@"历史开奖",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_History]},
                         @{@"title":@"今日统计",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_JRTJ]},
                         @{@"title":@"免费推荐",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_MFTJ]},
                         @{@"title":@"号码走势",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_HMZS]}];
    }
    return _dandanArray;
}

-(NSArray *)zucaiArray {
    
    if (!_zucaiArray) {
        
        _zucaiArray = @[
                        @{@"title":@"赛事",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_SS]},
                        @{@"title":@"预测",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_YC]},
                        @{@"title":@"专家",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_ZJ]},
                        @{@"title":@"比分",@"icon":[[CPTThemeConfig shareManager] IC_home_sub_BF]},
                        ];
    }
    
    return _zucaiArray;
}

-(UICollectionView *)subcollectionView {
    
    if (!_subcollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 15;
        
        layout.minimumLineSpacing = 15;
        
        CGFloat itemWidth = (SCREEN_WIDTH - 15 * 5) / 4;
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        _subcollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _subcollectionView.delegate = self;
        _subcollectionView.dataSource = self;
        _subcollectionView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_ViewBack2];
        _subcollectionView.scrollEnabled = NO;
        //注册
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeSubCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:RJCellIdentifier];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_3View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"azF1"];

        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_1View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cqssc"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_1View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xjssc"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_1View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"txffc"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_1View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"pcdd"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_2View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lhc"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_3View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bjpk10"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubHeader_3View class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xyft"];
        [_subcollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomesubFootView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homesubfoot"];
        [self addSubview:_subcollectionView];
        
        [_subcollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 2, 0));
        }];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            _subcollectionView.backgroundColor = [UIColor hexStringToColor:@"F0F0F0"];
        }
        UIView *seperatorLine = [[UIView alloc] init];
        [self addSubview:seperatorLine];
        seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_PCDanDan_ViewBack2];
        [seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subcollectionView.mas_bottom);
            make.bottom.left.right.equalTo(self);
        }];
    }
    
    return _subcollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background1 = [UIColor colorWithHex:@"e5de14"];
        self.background2 = [UIColor colorWithHex:@"106ced"];
        self.background3 = [UIColor colorWithHex:@"4c4a4a"];
        self.background4 = [UIColor colorWithHex:@"ec6412"];
        self.background5 = [UIColor colorWithHex:@"1ed0d3"];
        self.background6 = [UIColor colorWithHex:@"1e0df4"];
        self.background7 = [UIColor colorWithHex:@"a6a6a6"];
        self.background8 = [UIColor colorWithHex:@"e9281f"];
        self.background9 = [UIColor colorWithHex:@"770800"];
        self.background10 = [UIColor colorWithHex:@"2e9c18"];
        
    }
    return self;
}

/**
 1:重庆时时彩
 2：新疆时时彩
 3：比特币分分彩
 4：六合彩
 5：PC蛋蛋
 6：北京PK10
 7：幸运快艇
 */
-(void)setType:(NSInteger)type {
    
    _type = type;
    
    [self.subcollectionView reloadData];
    
    switch (type) {
        case 1:
            [self initChongqinData];
            break;
        case 4:
            [self initsixData];
            break;
        case 6:
            [self initbeijinData];
            break;
        case 2:
            [self initChongqinData];
            break;
        case 7:
            [self initbeijinData];
            break;
        case 3:
            [self initChongqinData];
            break;
        case 5:
            [self initPCData];
            break;
        case 11:
            [self initbeijinData];
            break;

        default:
            break;
    }
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.type == 1 || self.type == 2 || self.type == 3) {
        //1 重庆时时彩  2新疆时时彩  3 比特币分分彩 4 六合彩 5 pc 蛋蛋 6北京PK10 7 幸运飞艇 9 足彩资讯
        return self.chongqinArray.count;
    }
    else if (self.type == 4) {
        
        if (self.showall) {
            
            return self.liuheArray.count;
        }
        else {
            return 8;
        }
    }
    else if (self.type == 6 || self.type == 7|| self.type == 11) {
        
        if (self.showall) {
            
            return self.beijinArray.count;
        }
        else {
            return 8;
        }
    }
    else if (self.type == 5) {
        return self.dandanArray.count;
    }else{
        return self.zucaiArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = nil;
    
    if (self.type == 1 || self.type == 2 || self.type == 3) {
        
        dic = [self.chongqinArray objectAtIndex:indexPath.item];
    }
    else if (self.type == 4) {
        
        dic = [self.liuheArray objectAtIndex:indexPath.item];
    }
    else if (self.type == 6 || self.type == 7 || self.type == 11) {
        
        dic = [self.beijinArray objectAtIndex:indexPath.item];
    }else if (self.type == 5){
        dic = [self.dandanArray objectAtIndex:indexPath.item];
    }else{
        dic = [self.zucaiArray objectAtIndex:indexPath.item];
    }
    
    cell.iconimgv.image = IMAGE(dic[@"icon"]);
    cell.titlelab.text = dic[@"title"];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (self.type == 1 || self.type == 2 || self.type == 3 || self.type == 5) {
            
            HomesubHeader_1View *head = nil;
            
            ChongqinInfoModel *model;
            
            if (self.type == 1) {
                
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"cqssc" forIndexPath:indexPath];
                
                model = self.chongqinmodel;
            }
            else if (self.type == 2) {
                
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"xjssc" forIndexPath:indexPath];
                
                model = self.xinjiangmodel;
            }
            else if (self.type == 3) {
                
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"txffc" forIndexPath:indexPath];
                
                model = self.tengxunmodel;
            }
            else if (self.type == 5) {
                
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"pcdd" forIndexPath:indexPath];
            }
            [head.stopWatchLabel reset];
            NSArray * numbers = nil;
            NSString *isssue = nil;
            NSString *noOpen = nil;
            NSString *open = nil;
            NSInteger nexttime = 0;
            
            for (UILabel *lab in head.numberlabs) {
                lab.hidden = YES;
            }
            if (self.type == 5) {
                
                isssue = self.lotteryInfoModel.issue;
                numbers = [self.lotteryInfoModel.number componentsSeparatedByString:@","];
                open = self.lotteryInfoModel.openCount;
                noOpen = self.lotteryInfoModel.noOpenCount;
                nexttime = self.lotteryInfoModel.nextTime;
                //                isssue = self.pcmodel.lastSg.issue;
                //                numbers = [self.pcmodel.lastSg.number componentsSeparatedByString:@","];
                //                open = INTTOSTRING(self.pcmodel.count);
                //                noOpen = INTTOSTRING(self.pcmodel.surplus);
                //                nexttime = self.pcmodel.time;
                
            }
            else {
                if ([model.issue isEqualToString:@""]) {

                    isssue = @"-";
                }else{
                    isssue = [model.issue substringFromIndex:self.type == 3 ? 9 : 8];
                }
                
                numbers = model.numbers;
                
                noOpen = INTTOSTRING(model.noOpenCount);
                
                open = INTTOSTRING(model.openCount);
                
                nexttime = model.nextTime;
                
            }
            
            head.versionlab.text = isssue;
            head.sellversionlab.text = open;
            head.releaseversionlab.text = noOpen;
            
            if (nexttime - self.curenttime >= 0) {
                
                head.stopWatchLabel.delegate = self;
                head.stopWatchLabel.startTimeInterval = self.curenttime;
                [head.stopWatchLabel setCountDownTime:nexttime - self.curenttime];//多少秒 （1分钟 == 60秒）
                [head.stopWatchLabel start];
            }
            else{
                head.timelab.text = @"还未配置开盘时间";
            }
            
            
            if (numbers.count == 0 || self.waiting == YES) {
                
                head.statuslab.text = @"期正在开奖";
                return head;
            }
            head.statuslab.text = @"期开奖结果:";
            for (int i = 0; i< numbers.count; i++) {
                
                UILabel *lab = [head.numberlabs objectAtIndex:i];
                lab.text = numbers[i];
                lab.hidden = NO;
            }
            
            return head;
        }
        
        else if (self.type == 4) {
            
            HomesubHeader_2View *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"lhc" forIndexPath:indexPath];
            
            head.versionlab.text = self.sixmodel.issue;
            
            head.statuslab.text = @"期开奖结果:";
            NSArray * numberArry = [self.sixmodel.number componentsSeparatedByString:@","];
            NSArray * shengxiaoArry = [self.sixmodel.shengxiao componentsSeparatedByString:@","];
            
            for (int i = 0; i<numberArry.count; i++) {
                
                NSString *num = numberArry[i];
                NSString *shengxiao = shengxiaoArry[i];
                NSString *wuxing = [Tools numbertowuxin:numberArry[i]];
                
                UIButton *btn = head.numberBtns[i];
                [btn setBackgroundImage:[Tools numbertoimage:num Withselect:NO] forState:UIControlStateNormal];
                UILabel *lab = head.numberlabs[i];
                [btn setTitle:num forState:UIControlStateNormal];
                lab.text = [NSString stringWithFormat:@"%@/%@", shengxiao,wuxing];
            }
            
            
            if (self.sixmodel.nextOpenTime - self.curenttime >= 0) {
                
                [Tools getDateWithTime:self.sixmodel.nextOpenTime success:^(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second, NSString *week) {
                    
                    head.timelab.text = [NSString stringWithFormat:@"%ld年%ld月%ld日 %ld点%ld分 %@",year,month,day,hour,minute,week];
                }];
            }
            else{
                head.timelab.text = @"还未配置开盘时间";
            }
            
            return head;
        }
        else if (self.type == 6 || self.type == 7 || self.type == 11){
            
            HomesubHeader_3View *head = nil;
            
            PK10InfoModel *model;
            
            if (self.type == 6) {
                
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"bjpk10" forIndexPath:indexPath];
                
                model = self.pk10model;
            }
            else if (self.type == 11) {
                
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"azF1" forIndexPath:indexPath];
                
                model = self.azF1model;
            }
            else {
                head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"xyft" forIndexPath:indexPath];
                
                model = self.feitingmodel;
            }
            
            [head.stopWatchLabel reset];
            head.versionlab.text = model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue;
            head.sellversionlab.text = INTTOSTRING(model.openCount);
            head.releaseversionlab.text = INTTOSTRING(model.noOpenCount);
            head.stopWatchLabel.delegate = self;
            head.stopWatchLabel.startTimeInterval = self.curenttime;
            [head.stopWatchLabel setCountDownTime:model.nextTime - self.curenttime];//多少秒 （1分钟 == 60秒）
            [head.stopWatchLabel start];
            NSArray *numbers = [model.number componentsSeparatedByString:@","];
            [head layoutIfNeeded];
            
            if (self.waiting == YES) {
                
                head.statuslab.text = @"期正在开奖";
                
                for (int i = 0; i< numbers.count; i++) {
                    UILabel *lab = [head.numberlabs objectAtIndex:i];
                    lab.text = @"?";
                    lab.hidden = NO;
                    lab.layer.cornerRadius = lab.size.height/2;
                    lab.layer.masksToBounds = YES;
                }
            }
            else{
                head.statuslab.text = @"期开奖结果:";
                
                for (int i = 0; i< numbers.count; i++) {
                    UILabel *lab = [head.numberlabs objectAtIndex:i];
                    lab.text = numbers[i];
                    lab.layer.cornerRadius = 5;//lab.width/2;
                    lab.layer.masksToBounds = YES;
                    
                    int num = [[NSString stringWithFormat:@"%@", numbers[i]] intValue];
                    lab.backgroundColor = [BallTool getColorWithNum:num];

//                    switch (num) {
//                        case 1: lab.backgroundColor = self.background1;
//                            break;
//                        case 2: lab.backgroundColor = self.background2;
//                            break;
//                        case 3: lab.backgroundColor = self.background3;
//                            break;
//                        case 4: lab.backgroundColor = self.background4;
//                            break;
//                        case 5: lab.backgroundColor = self.background5;
//                            break;
//                        case 6: lab.backgroundColor = self.background6;
//                            break;
//                        case 7: lab.backgroundColor = self.background7;
//                            break;
//                        case 8: lab.backgroundColor = self.background8;
//                            break;
//                        case 9: lab.backgroundColor = self.background9;
//                            break;
//                        case 10: lab.backgroundColor = self.background10;
//                            break;
//                        default:
//                            break;
//                    }
                    lab.hidden = NO;
                    
                }
            }
            
            
            return head;
        }else{
            
            HomesubHeader_1View *head = nil;
            
            head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"pcdd" forIndexPath:indexPath];
            head.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.001);
            
            return head;
        }
        
    }
    else {
        
        HomesubFootView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"homesubfoot" forIndexPath:indexPath];
        
        foot.moreBtn.selected = self.showall;
        
        foot.showallBlock = ^(BOOL showall) {
            
            self.showall = showall;
            
            if (self.footshowallBlock) {
                
                self.footshowallBlock(showall);
            }
            
            [self.subcollectionView reloadData];
        };
        
        return foot;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (self.type == 1 || self.type == 2 || self.type == 3 || self.type == 5) {
        
        return CGSizeMake(SCREEN_WIDTH, 83);
    }
    else if (self.type == 4) {
        
        return CGSizeMake(SCREEN_WIDTH, 145);
    }
    else if (self.type == 6 || self.type == 7 || self.type == 11){
        return CGSizeMake(SCREEN_WIDTH, 120);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 0.0001);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (self.type == 4) {
        
        if (self.showall) {
            
            return CGSizeMake(SCREEN_WIDTH, 60);
        }
        else {
            return CGSizeMake(SCREEN_WIDTH, 60);
        }
    }
    else if (self.type == 6 || self.type == 7|| self.type == 11) {
        
        if (self.showall) {
            
            return CGSizeMake(SCREEN_WIDTH, 60);
        }
        else {
            return CGSizeMake(SCREEN_WIDTH, 60);
        }
    }else if (self.type == 9){
        return CGSizeMake(SCREEN_WIDTH, 0.0001);
    }
    else {
        return CGSizeMake(SCREEN_WIDTH, 0);
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectcontentBlock) {
        
        self.selectcontentBlock(self.type, indexPath.item);
    }
}

#pragma mark - 获取PC蛋蛋
-(void)initPCData {
    
    [WebTools postWithURL:@"/pceggSg/getSgInfo.json" params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        self.pcmodel = [PCInfoModel mj_objectWithKeyValues:data.data];
        LotteryInfoModel *model = [LotteryInfoModel mj_objectWithKeyValues:data.data];
        self.lotteryInfoModel = model;
//        MBLog(@"%@", self.lotteryInfoModel.issue);
        
        self.curenttime = data.time;
        
        self.waiting = NO;
        
        [self.subcollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
/**
 0:重庆时时彩
 1：六合彩
 2：北京PK10
 3：新疆时时彩
 4：幸运快艇
 5：比特币分分彩
 6：PC蛋蛋
 */
/**
 1:重庆时时彩
 2：新疆时时彩
 3：比特币分分彩
 4：六合彩
 5：PC蛋蛋
 6：北京PK10
 7：幸运快艇
 */
-(void)initChongqinData {
    
    NSString *url = nil;
    if (self.type == 1) {
        
        url = @"/cqsscSg/getNewestSgInfo.json";
    }
    else if (self.type == 2) {
        url = @"/xjsscSg/getNewestSgInfo.json";
    }else if (self.type == 3) {
        url = @"/txffcSg/getNewestSgInfo.json";
    }
    [WebTools postWithURL:url params:nil success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        switch (self.type) {
            case 1:
                self.chongqinmodel = [ChongqinInfoModel mj_objectWithKeyValues:data.data];
                break;
            case 2:
                self.xinjiangmodel = [ChongqinInfoModel mj_objectWithKeyValues:data.data];
                break;
            case 3:
                self.tengxunmodel = [ChongqinInfoModel mj_objectWithKeyValues:data.data];
                break;
            default:
                break;
        }
        
        
        self.curenttime = data.time;
        
//        NSLog(@"倒计时时间差：%ld",self.chongqinmodel.nextTime - self.curenttime);
        
        [self.subcollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)initsixData {
    
    [WebTools postWithURL:@"/lhcSg/getNewestSgInfo.json" params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        self.sixmodel = [SixInfoModel mj_objectWithKeyValues:data.data];
        
        //        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //        [center postNotificationName:@"liuHeCaiResultModel" object:self.sixmodel];
        
        self.curenttime = data.time;
        
        [self.subcollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)initbeijinData {
    
    NSString *url = nil;
    if (self.type == 6) {
        
        url = @"/bjpksSg/getNewestSgInfo.json";
    }
    else if (self.type == 7) {
        url = @"/xyftSg/getNewestSgInfo.json";
    }
    else if (self.type == 11) {
        url = @"/azPrixSg/getNewestSgInfo.json";
    }
    
    [WebTools postWithURL:url params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        if (self.type == 6) {
            
            self.pk10model = [PK10InfoModel mj_objectWithKeyValues:data.data];
        }
        else if (self.type == 11){
            self.azF1model = [PK10InfoModel mj_objectWithKeyValues:data.data];
        }
        else{
            self.feitingmodel = [PK10InfoModel mj_objectWithKeyValues:data.data];
        }
        
        self.curenttime = data.time;
        
        [self.subcollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

//时间到了
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    //    [timerLabel pause];
    
    //    self.waiting = YES;
    
    switch (self.type) {
        case 1:
            [self initChongqinData];
            break;
        case 4:
            [self initsixData];
            break;
        case 6:
            [self initbeijinData];
            break;
        case 2:
            [self initChongqinData];
            break;
        case 7:
            [self initbeijinData];
            break;
        case 11:
            [self initbeijinData];
            break;
        case 3:
            [self initChongqinData];
            break;
        case 5:
            [self initPCData];
            break;
        default:
            break;
    }
    
    
    //
    //    if (self.pcmodel || self.chongqinmodel || self.pk10model || self.sixmodel) {
    //
    //        [self.subcollectionView reloadData];
    //    }
    //
    int time = self.type == 3 ? 10 : 100;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //        self.waiting = NO;
        
        switch (self.type) {
            case 1:
                [self initChongqinData];
                break;
            case 4:
                [self initsixData];
                break;
            case 6:
                [self initbeijinData];
                break;
            case 11:
                [self initbeijinData];
                break;
            case 2:
                [self initChongqinData];
                break;
            case 7:
                [self initbeijinData];
                break;
            case 3:
                [self initChongqinData];
                break;
            case 5:
                [self initPCData];
                break;
            default:
                break;
        }
        
        
    });
    
    
}

//开始倒计时
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType {
    //    NSLog(@"time:%f",time);
    
}

@end
