//
//  VersionsPickerView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPickerView+YLT.h"
#import "PickerCell.h"
#import "PhotoModel.h"
@interface VersionsPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@property (weak, nonatomic) IBOutlet UIView *topView;


@property (strong, nonatomic) NSMutableArray *arrayYears;
@property (strong, nonatomic) NSMutableArray *arrayVersion;

@property (copy, nonatomic) NSString *strYear;      //  年
@property (copy, nonatomic) NSString *strVersion;     //  月
@property (copy, nonatomic) NSString *lastDate;    

@property (strong, nonatomic) UIControl *overlayView;

@property (assign, nonatomic) BOOL onlyshowyear;

@property (copy, nonatomic) void (^VersionBlock)(NSString *time,NSString *version,NSString *url);

@property (strong, nonatomic) NSArray <PhotoModel *> *datas;

@property (strong, nonatomic) PhotoModel *currentModel;

+(VersionsPickerView *)share;
+(VersionsPickerView *)shareWithDate:(NSString *)date;
-(void)setpicker ;

-(void)show;

@end
