//
//  HobbyCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HobbyCtrl.h"
#import "HobbyCell.h"
#import "HobbyModel.h"
#import "UIImage+color.h"

@interface HobbyCtrl ()

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation HobbyCtrl

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat spacing = 15;
        
        layout.minimumInteritemSpacing = spacing;
        
        layout.minimumLineSpacing = spacing;
        
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
        
        NSInteger columnsNum = 3;
        
        CGFloat itemwidth = (SCREEN_WIDTH - spacing *(columnsNum + 1))/columnsNum;
        
        layout.itemSize = CGSizeMake(itemwidth, 44);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.backgroundColor = CLEAR;
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HobbyCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:RJCellIdentifier];
        
        if (@available(iOS 11.0, *)) {
            
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _collectionView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = @"偏好设置";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 64) andTitle:@"选择你感兴趣的彩种" andfont:FONT(15) andTitleColor:[[CPTThemeConfig shareManager] HobbyVC_MessLab_TextC] andBackgroundColor:CLEAR andTextAlignment:1];
    lab.backgroundColor = [[CPTThemeConfig shareManager] HobbyVC_MessLab_BackgroundC];
    self.view.backgroundColor = [[CPTThemeConfig shareManager] HobbyVC_View_BackgroundC];
    
    [self.view addSubview:lab];
    
    [self.view addSubview:self.collectionView];
    
    UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:@"确定" andTitleColor:[[CPTThemeConfig shareManager] HobbyVC_OKButton_TitleBackgroundC] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(sureClick) andType:UIButtonTypeCustom];
    btn.backgroundColor = [[CPTThemeConfig shareManager] HobbyVC_OKButton_BackgroundC];
    
   
    btn.titleLabel.font = FONT(16);
    [self.view addSubview:btn];
    
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.navView.mas_bottom).offset(0);
//        make.centerX.equalTo(self.view);
//    }];
    @weakify(self)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)

        make.top.equalTo(lab.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@0);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)

        make.top.equalTo(self.collectionView.mas_bottom).offset(45);
        make.height.equalTo(@45);
        make.right.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(20);
    }];
    
    [self initData:lab];
}

-(void)initData:(UILabel *)lab {

    NSArray *array = @[
                             @{@"title":@"重庆时时彩",@"ID":@(1),@"icon":[[CPTThemeConfig shareManager] IC_Home_CQSSC],@"subtitle":@"全天59期",@"hotTitle":@"xin"},
                             @{@"title":@"六合彩",@"ID":@(4),@"icon":[[CPTThemeConfig shareManager] IC_Home_LHC],@"subtitle":@"一周开三期",@"hotTitle":@"huo"},
                             @{@"title":@"澳洲F1赛车",@"ID":@(11),@"icon":[[CPTThemeConfig shareManager] IC_Home_LHC],@"subtitle":@"全天528期",@"hotTitle":@"huo"},
                             @{@"title":@"北京PK10",@"ID":@(6),@"icon":[[CPTThemeConfig shareManager] IC_Home_BJPK10],@"subtitle":@"全天44期",@"hotTitle":@"huo"},
                             @{@"title":@"新疆时时彩",@"ID":@(2),@"icon":[[CPTThemeConfig shareManager] IC_Home_XJSSC],@"subtitle":@"全天48期",@"hotTitle":@"huo"},
                             @{@"title":@"幸运飞艇",@"ID":@(7),@"icon":[[CPTThemeConfig shareManager] IC_Home_XYFT],@"subtitle":@"全天180期",@"hotTitle":@"huo"},
                             @{@"title":@"比特币分分彩",@"ID":@(3),@"icon":[[CPTThemeConfig shareManager] IC_Home_TXFFC],@"subtitle":@"全天1440期",@"hotTitle":@"huo"},
                             @{@"title":@"PC蛋蛋",@"ID":@(5),@"icon":[[CPTThemeConfig shareManager] IC_Home_PCDD],@"subtitle":@"全天179期",@"hotTitle":@"huo"}, @{@"title":@"足彩资讯",@"ID":@(9),@"icon":[[CPTThemeConfig shareManager] IC_Home_ZCZX],@"subtitle":@"专业数据分析",@"hotTitle":@"huo"}];




    NSArray *modelarray = [HobbyModel mj_objectArrayWithKeyValuesArray:array];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([userDefault valueForKey:LOTTERYTYPE]) {
        
        for (HobbyModel *model in modelarray) {
            
            for (NSDictionary *userdefaultdic in [userDefault valueForKey:LOTTERYTYPE]) {
                
                if (model.ID.integerValue == [userdefaultdic[@"ID"]integerValue]) {
                    
                    model.select = YES;
                }
            }
        }
    }
    else {
        for (HobbyModel *model in modelarray) {
            
            if ([model.ID isEqualToNumber:@4] || [model.ID isEqualToNumber:@9]) {
                model.select = YES;
            }else{
                model.select = NO;
            }
        }
    }
    [self.dataSource addObjectsFromArray:modelarray];
    
    @weakify(self)
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)

        make.top.equalTo(lab.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(64 * (array.count+2)/3));
    }];
    
    [self.collectionView reloadData];
    
    [self.view layoutIfNeeded];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HobbyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    HobbyModel *model = [self.dataSource objectAtIndex:indexPath.item];
    
    cell.titlelab.text = model.title;
    
    cell.selectimgv.hidden = !model.select;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.titlelab.layer.borderColor = [UIColor clearColor].CGColor;
    cell.titlelab.layer.borderWidth = 2;
    if (cell.selectimgv.hidden) {
        cell.titlelab.backgroundColor = [[CPTThemeConfig shareManager] HobbyVC_UnSelButton_BackgroundC];
        cell.titlelab.textColor = [[CPTThemeConfig shareManager] HobbyVC_UnSelButton_TitleBackgroundC];
    }else{
        cell.titlelab.backgroundColor = [[CPTThemeConfig shareManager] HobbyVC_SelButton_BackgroundC];
        cell.titlelab.textColor = [[CPTThemeConfig shareManager] HobbyVC_SelButton_TitleBackgroundC];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HobbyModel *model = [self.dataSource objectAtIndex:indexPath.item];
    
    model.select = !model.select;
    
    [self.collectionView reloadData];
}

-(void)sureClick {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (HobbyModel *model in self.dataSource) {
        
        if (model.select) {
            
            [array addObject:[model mj_keyValues]];
        }
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
      if (array.count > 8) {
        [MBProgressHUD showError:@"至多选择8项感兴趣的彩种！"];
        return;
    }
    else  if (array.count <2){
        [MBProgressHUD showError:@"至少选择2项感兴趣的彩种！"];
        return;
    }
    else    {
        [userDefault setObject:array forKey:LOTTERYTYPE];
        
        [userDefault synchronize];
    }
    if (self.updataBlock) {
        
        self.updataBlock(array);
    }
    [self popback];
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
