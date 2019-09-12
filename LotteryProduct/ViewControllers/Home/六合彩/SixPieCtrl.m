//
//  SixPieCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/3.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixPieCtrl.h"
#import "CollectionBaseCell.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
@interface SixPieCtrl ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;

@property (weak, nonatomic) IBOutlet UILabel *currentversionslab;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UIView *piebgView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionView_height;

@property (weak, nonatomic) IBOutlet UILabel *statuslab;

/**
 网络请求的type，接口和我当初定的不一致，重新申明个新变量
 */
@property (assign, nonatomic) NSInteger webtype;

@property (strong, nonatomic) NSMutableArray *pieDataArray;

@end

@implementation SixPieCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.topconst.constant = NAV_HEIGHT;
    [self setwhiteC];
    switch (self.type) {
        case 1:
        {
            self.titlestring = @"生肖特码冷热图";
            
            self.webtype = 641;
        }
            break;
        case 2:
        {
            self.titlestring = @"生肖正码冷热图";
            
            self.webtype = 643;
        }
            break;
        case 3:
        {
            self.titlestring = @"波色特码冷热图";
            
            self.webtype = 601;
        
        }
            break;
        case 4:
        {
            self.titlestring = @"波色正码冷热图";
            
            self.webtype = 603;
            
        }
            break;
        case 5:
        {
            self.titlestring = @"特码尾数冷热图";
            
            self.webtype = 607;
            
        }
            break;
        case 6:
        {
            self.titlestring = @"正码尾数冷热图";
            
            self.webtype = 609;
        }
            break;
        case 7:
        {
            self.titlestring = @"号码波段统计图";
            
            [self.segment setTitle:@"正码" forSegmentAtIndex:0];
            [self.segment setTitle:@"特码" forSegmentAtIndex:1];
            
            self.webtype = 612;
        }
            break;
        default:
            break;
    }
    
    self.versionnumber = @"100";
    
//    [self getDataWithtype:self.webtype Withnumber:self.versionnumber];
    
    [_collectionView registerClass:[CollectionBaseCell class] forCellWithReuseIdentifier:RJCellIdentifier];
    
    self.collectionView_height.constant = self.type < 3 ? 20*3 : self.type > 4 ? 20*2 : 20;
    
    //投注按钮
    [self buildBettingBtn];
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = 0;
    if (self.type == 1 || self.type == 2 || self.type == 5 || self.type == 6) {
        
        itemWidth = collectionView.bounds.size.width/5-1;
    }
    else {
        itemWidth = collectionView.bounds.size.width/3-1;
    }
    return CGSizeMake(itemWidth, 18);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    DVFoodPieModel *model = [self.dataSource objectAtIndex:indexPath.item];
    
    [cell.iconBtn setTitle:[NSString stringWithFormat:@"%@%d",model.type,(int)model.num] forState:UIControlStateNormal];
    [cell.iconBtn setTitleColor:model.color forState:UIControlStateNormal];
    [cell.iconBtn setImage:[Tools createImageWithColor:model.color Withsize:CGSizeMake(8, 8)] forState:UIControlStateNormal];
    [cell.iconBtn setImagePosition:WPGraphicBtnTypeLeft spacing:3];
    cell.iconBtn.titleLabel.font = FONT(12);
    cell.backgroundColor = CLEAR;
    return cell;
}

-(void)setVersionnumber:(NSString *)versionnumber {
    
    [super setVersionnumber:versionnumber];
    
    self.currentversionslab.text = [NSString stringWithFormat:@"当前统计的期数：%@",versionnumber];
    
    [self getDataWithtype:self.webtype Withnumber:versionnumber];
    
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    
    self.statuslab.text = sender.selectedSegmentIndex == 0 ? @"出现次数（所选期数范围内出现的次数）" : @"未出现次数（当前遗漏次数）";
    
    [self getDataWithtype:self.webtype Withnumber:self.versionnumber];
}

-(void)getDataWithtype:(NSInteger)type Withnumber:(NSString *)version {
    
    NSInteger t = type + self.segment.selectedSegmentIndex;
    
    [self.dataSource removeAllObjects];
    
    NSString *url = nil;
    
    if (self.webtype == 643 || self.webtype == 641) {
        
        url = @"/lhcSg/getInfoD.json";
    }
    else {
        url = @"/lhcSg/getInfoA.json";
    }
    
    @weakify(self)
    NSDictionary *dic = @{@"type":[NSString stringWithFormat:@"%ld",t],@"issue":version};
    [WebTools postWithURL:url params:dic success:^(BaseData *data) {
        @strongify(self)
        for (DVPieChart *chart in self.piebgView.subviews) {
            
            [chart removeFromSuperview];
        }
        
        NSArray *arr = [DVFoodPieModel mj_objectArrayWithKeyValuesArray:data.data];
        
        CGFloat totalnum = 0;
        
        for (DVFoodPieModel *model in arr) {
        
            totalnum = model.num + totalnum;
        }
        
        if (self.webtype == 601 || self.webtype == 603) {
            
            for (DVFoodPieModel *model in arr) {
                
                if ([model.type isEqualToString:@"红波"]) {
                    
                    model.color = [UIColor colorWithHex:@"f15347"];
                }
                else if ([model.type isEqualToString:@"蓝波"]) {
                    
                    model.color = [UIColor colorWithHex:@"0587c5"];
                }
                else {
                    model.color = [UIColor colorWithHex:@"46be64"];
                }
                model.rate = model.num/totalnum;
                
                [self.dataSource addObject:model];
            }
        }
        else if (self.webtype == 607 || self.webtype == 609) {
            
            NSDictionary *colordic = @{@"0尾":kColor(52, 86, 31),
                                       @"1尾":kColor(234, 100, 48),
                                       @"2尾":kColor(222, 55, 16),
                                       @"3尾":kColor(220, 119, 10),
                                       @"4尾":kColor(237, 154, 49),
                                       @"5尾":kColor(215, 159, 9),
                                       @"6尾":kColor(50, 108, 187),
                                       @"7尾":kColor(94, 147, 49),
                                       @"8尾":kColor(18, 80, 140),
                                       @"9尾":kColor(178, 28, 33)
                                       };
            
            for (DVFoodPieModel *model in arr) {
                
                model.type = [NSString stringWithFormat:@"%@尾",model.type];
                model.rate = model.num/totalnum;
                model.color = colordic[model.type];
                
                [self.dataSource addObject:model];
            }
            
        }
        else {
            
            if (self.type == 1 || self.type == 2) {
                NSDictionary *colordic = @{@"鼠":kColor(52, 86, 31),
                                           @"牛":kColor(234, 100, 48),
                                           @"虎":kColor(222, 55, 16),
                                           @"兔":kColor(220, 119, 10),
                                           @"龙":kColor(237, 154, 49),
                                           @"蛇":kColor(215, 159, 9),
                                           @"马":kColor(50, 108, 187),
                                           @"羊":kColor(94, 147, 49),
                                           @"猴":kColor(18, 80, 140),
                                           @"鸡":kColor(178, 28, 33),
                                           @"狗":kColor(29, 49, 99),
                                           @"猪":kColor(70, 130, 197)
                                           };
                for (DVFoodPieModel *model in arr) {
                    model.type = model.type;
                    model.rate = model.num/totalnum;
                    model.num = model.num;
                    model.color = colordic[model.type];
                    
                    [self.dataSource addObject:model];
                }
            }
            else {
                
//                NSArray *arr = @[@"1-10段",@"11-20段",@"21-30段",@"31-40段",@"41-49段"];
                NSDictionary *colordic = @{@"1-10段":kColor(52, 86, 31),
                                           @"11-20段":kColor(234, 100, 48),
                                           @"21-30段":kColor(222, 55, 16),
                                           @"31-40段":kColor(220, 119, 10),
                                           @"41-49段":kColor(237, 154, 49)
                                           };
                for (DVFoodPieModel *model in arr) {
                    
                    model.type = model.type;
                    model.rate = model.num/totalnum;
                    model.num = model.num;
                    model.color = colordic[model.type];
                    [self.dataSource addObject:model];
                }
            }
        }
        
        [self.collectionView reloadData];
        
        DVPieChart *chart1 = [[DVPieChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, SCREEN_WIDTH - 60)];
        chart1.backgroundColor = CLEAR;
        [self.piebgView addSubview:chart1];
        
        [self.pieDataArray removeAllObjects];
        
        for (DVFoodPieModel *model in self.dataSource) {
            
            if (model.num != 0) {
                
                [self.pieDataArray addObject:model];
            }
        }
        chart1.dataArray = self.pieDataArray;
        
        [chart1 draw];
        
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
}


-(NSMutableArray *)pieDataArray {
    
    if (!_pieDataArray) {
        
        _pieDataArray = [[NSMutableArray alloc]init];
    }
    return _pieDataArray;
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
