//
//  ConditionView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ConditionView.h"

@implementation ConditionView

static ConditionView *conditon = nil;

static dispatch_once_t onceToken;

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = WHITE;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    self.leftTableView.delegate = self;
    self.rightTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.tableFooterView = [UIView new];
    
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RJCellIdentifier];
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RJHeaderIdentifier];
    
    NSArray *arr = @[@"生肖",@"号码",@"五行",@"波色",@"家野",@"尾数"];
    
    NSArray *subarray = @[@[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"],@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49"],@[@"金",@"木",@"水",@"火",@"土"],@[@"红波",@"蓝波",@"绿波"],@[@"家禽",@"野兽"],@[@"1尾",@"2尾",@"3尾",@"4尾",@"5尾",@"6尾",@"7尾",@"8尾",@"9尾"]];
    
    NSMutableArray *marray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<arr.count; i++) {
        
        ConditionModel *model = [[ConditionModel alloc]init];
        
        model.title = arr[i];
        
        model.ID = i;
        
        NSArray *subarr = [subarray objectAtIndex:i];
        
        NSMutableArray *msubarray = [[NSMutableArray alloc]init];
        
        for (int j = 0; j<subarr.count ;j++) {
            
            ConditionClassModel *submodel = [[ConditionClassModel alloc]init];
            
            submodel.subtitle = [subarr objectAtIndex:j];
            
            submodel.selected = NO;
            
            [msubarray addObject:submodel];
        }
        
        model.classmodelArray = msubarray;
        
        [marray addObject:model];
    }
    
    self.array = [marray copy];
    self.selectmodel = self.array.firstObject;
    
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    
    _overlayView.alpha = 0.3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) {
        
        return self.array.count;
    }
    else {
        
        return self.selectmodel.classmodelArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ConditionModel *model = [self.array objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.title;
        
        cell.textLabel.font = FONT(14);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.contentView.backgroundColor = model.selected == YES ? [UIColor groupTableViewBackgroundColor] : WHITE;
        
        return cell;
    }
    else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        ConditionClassModel *model = [self.selectmodel.classmodelArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.subtitle;
        
        cell.textLabel.font = FONT(14);
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        
        NSArray *array = @[@"selectred",@"selectgree",@"selectblue"];
        if (model.selected) {
            
            UIImage *img = IMAGE(array[indexPath.row%3]);
            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
            imgv.backgroundColor = CLEAR;
            imgv.image = img;
            cell.accessoryView = imgv;
        }
        else{
            cell.accessoryView = nil;
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        ConditionModel *model = [self.array objectAtIndex:indexPath.row];
        
        model.selected = YES;
        
        self.selectmodel = model;
        self.selectmodel.count = 0;
        
        [self.rightTableView reloadData];
        
    }else {
        
        for (ConditionModel *model in self.array) {
            
            if (model != self.selectmodel) {
                
                for (ConditionClassModel *classmodel in model.classmodelArray) {
                    
                    if (classmodel.selected == YES) {
                        self.selectmodel.count -= 1;
                        if (self.selectmodel.count < 0) {
                            self.selectmodel.count = 0;
                        }
                    }
                    classmodel.selected = NO;
 
                }
            }
        }

        ConditionClassModel *submodel = [self.selectmodel.classmodelArray objectAtIndex:indexPath.row];
        
        if ([self.selectmodel.title isEqualToString:@"生肖"] || [self.selectmodel.title isEqualToString:@"号码"]) {
            
            if (submodel.selected == NO && self.selectmodel.count==3) {
                
                [MBProgressHUD showError:@"最多选择3个选项"];
            }
            else if (submodel.selected == YES) {
                
                submodel.selected = NO;
                self.selectmodel.count--;
            }
            else{
                submodel.selected = YES;
                self.selectmodel.count++;
            }
            if (self.selectmodel.count == 0) {
                
                self.selectmodel.submodelselect = NO;
            }
            else{
                self.selectmodel.submodelselect = YES;
            }
        }
        else {
            
            for (ConditionClassModel *m in self.selectmodel.classmodelArray) {
                
                m.selected = NO;
            }
            
            submodel.selected = YES;
            
            self.selectmodel.submodelselect = YES;
        }
        
        [self.rightTableView reloadData];
    }
}

- (IBAction)cancelClick:(UIButton *)sender {
    
    [self fadeOut];
}
- (IBAction)clearClick:(UIButton *)sender {
    
    for (ConditionModel *model in self.array) {
        
        for (ConditionClassModel *classmodel in model.classmodelArray) {
            
            classmodel.selected = NO;

        }
    }
    
    self.selectmodel.count = 0;
    self.selectmodel = nil;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    
    if (self.conditionclearBlock) {
        
        self.conditionclearBlock();
    }
    [self fadeOut];
}
- (IBAction)sureClick:(UIButton *)sender {
    
    if (self.selectmodel.submodelselect == NO) {
        
        [MBProgressHUD showError:@"请选择筛选条件"];
        
        return;
    }
    if (self.conditionBlock) {
        
        self.conditionBlock(self.selectmodel);
    }
    self.selectmodel.count = 0;
    self.selectmodel = nil;
    [self fadeOut];
}

+(ConditionView *)share {
  
    dispatch_once(&onceToken, ^{
        
        conditon = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ConditionView class]) owner:self options:nil]lastObject];
        
        conditon.frame = CGRectMake(0, 0, SCREEN_WIDTH - 50, 270);
    });
    return conditon;
}

+(void)tearDown {
    
    conditon = nil;
    
    onceToken = 0;
}

-(void)show {
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2);
    
    
    [self fadeIn];
}

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
        [_overlayView addTarget:self action:@selector(fadeOut) forControlEvents:UIControlEventTouchUpInside];
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self removeFromSuperview];
            [_overlayView removeFromSuperview];
        }
    }];
}


@end
