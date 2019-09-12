//
//  VersionsPickerView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "VersionsPickerView.h"

@implementation VersionsPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)arrayYears
{
    if (!_arrayYears) {
        _arrayYears = [NSMutableArray array];
        
        for (NSInteger i = 1980; i <= [NSDate date].getYear; i++) {
            NSString *strYear = [NSString stringWithFormat:@"%04li", (long)i];
            [_arrayYears addObject:strYear];
        }
    }
    
    return _arrayYears;
}

- (NSMutableArray *)arrayVersion
{
    if (!_arrayVersion) {
        _arrayVersion = [NSMutableArray array];
        
        for (int i = 1; i <= 58; i++) {
            NSString *str = [NSString stringWithFormat:@"第%02i期", i];
            [_arrayVersion addObject:str];
        }
    }
    
    return _arrayVersion;
}



-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = WHITE;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    _overlayView.alpha = 0.3;
    
}

-(void)setpicker {
    
    self.myPickerView.delegate = self;
    self.myPickerView.dataSource = self;
    NSInteger currentYear;
    if(!self.lastDate){
        currentYear = [[NSDate date] getYear];
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        NSDate *date = [formatter dateFromString:self.lastDate];
        currentYear = [date getYear];
    }
    //  更新年
    NSString *strYear = [NSString stringWithFormat:@"%04li", currentYear];
    NSInteger indexYear = [self.arrayYears indexOfObject:strYear];
    if (indexYear == NSNotFound) {
        indexYear = 0;
    }
    [self.myPickerView selectRow:indexYear inComponent:0 animated:YES];
    self.strYear = self.arrayYears[indexYear];;
    
    // 期数
    [self.myPickerView selectRow:0 inComponent:1 animated:YES];
    self.strVersion = self.arrayVersion[0];
  
    [self.myPickerView clearSpearatorLine];
    
}

-(void)setDatas:(NSArray<PhotoModel *> *)datas {
    
    _datas = datas;
   
    [self.arrayYears removeAllObjects];
    
    [self.arrayVersion removeAllObjects];
    
    for (PhotoModel *model in datas) {
        
        [self.arrayYears addObject:model.year];
    }
    
    self.currentModel = datas.lastObject;
    
    for (PhotoListModel *model in self.currentModel.photoList) {
        
        [self.arrayVersion addObject:model.issue];
    }
    
    self.strYear = self.currentModel.year;
    
    self.strVersion = self.arrayVersion.lastObject;
    
    [self.myPickerView reloadAllComponents];
    
    [self.myPickerView selectRow:self.arrayYears.count-1 inComponent:0 animated:YES];
    if (self.onlyshowyear == NO) {
        @try {
            [self.myPickerView selectRow:self.arrayVersion.count-1 inComponent:1 animated:YES];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    [self.myPickerView clearSpearatorLine];
}

-(void)setOnlyshowyear:(BOOL)onlyshowyear {
    
    _onlyshowyear = onlyshowyear;
    
    if (onlyshowyear) {
        
        self.titlelab.text = @"选择年份";
    }
}

#pragma mark - UIPickerView DataSource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.onlyshowyear) {
        
        return 1;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayYears.count;
    }
    else {
        return self.arrayVersion.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    if (component == 0) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayYears[row]];
        return cell;
    } else {
        NSString *versionstr = [NSString stringWithFormat:@"第%@期",self.arrayVersion[row]];
        PickerCell *cell = [PickerCell cellWithName:versionstr];
        return cell;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        if (_datas) {
            
            [self.arrayVersion removeAllObjects];
            
            self.currentModel = self.datas[row];
            
            for (PhotoListModel *model in self.currentModel.photoList) {
                
                [self.arrayVersion addObject:model.issue];
            }
            
            self.strYear = self.currentModel.year;
            
            self.strVersion = self.arrayVersion.lastObject;
            
            [self.myPickerView reloadComponent:1];
            
            [self.myPickerView selectRow:self.arrayVersion.count-1 inComponent:1 animated:YES];
            
            
            
            [self.myPickerView clearSpearatorLine];
        }
        else {
            self.strYear = self.arrayYears[row];
        }
    
    } else if (component == 1) {
        self.strVersion = self.arrayVersion[row];
    }
}

+(VersionsPickerView *)share {
    
    VersionsPickerView *picker = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([VersionsPickerView class]) owner:self options:nil]lastObject];
    
    picker.frame = CGRectMake(0, 0, SCREEN_WIDTH - 50, 225);
    
    return picker;
}

+(VersionsPickerView *)shareWithDate:(NSString *)date {
    
    VersionsPickerView *picker = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([VersionsPickerView class]) owner:self options:nil]lastObject];
    
    picker.frame = CGRectMake(0, 0, SCREEN_WIDTH - 50, 225);
    picker.lastDate = date;
    return picker;
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
            [self.arrayVersion removeAllObjects];
            [self.arrayYears removeAllObjects];
            self.datas = nil;
            [_overlayView removeFromSuperview];
        }
    }];
}

- (IBAction)cancelClick:(UIButton *)sender {
    
    [self fadeOut];
}

- (IBAction)sureClick:(UIButton *)sender {
    
    NSString *url = nil;
    
    if (_datas) {
        
        NSInteger index = [self.arrayVersion indexOfObject:self.strVersion];
        
        PhotoListModel *model = self.currentModel.photoList[index];
        
        url = model.url;
    }

    if (self.VersionBlock) {
        
        self.VersionBlock(self.strYear, self.strVersion,url);
    }
    [self fadeOut];
}


@end
