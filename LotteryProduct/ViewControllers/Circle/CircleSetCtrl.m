//
//  CircleSetCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CircleSetCtrl.h"
#import "HiddenPepoleCtrl.h"
@interface CircleSetCtrl ()

@property (weak, nonatomic) IBOutlet UISwitch *circlepushSet;

@property (weak, nonatomic) IBOutlet UISwitch *imagewifiSet;

@end

@implementation CircleSetCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self getSetDatasuccess:^(NSArray *data) {
        self.array = data;
        
        for (NSDictionary *dic in self.array) {
            
            if ([[dic valueForKey:@"settingId"]integerValue] == 1) {
                
                self.circlepushSet.on = [[dic valueForKey:@"onOff"]integerValue] == 1 ? YES : NO;
                self.circlepushSet.tag = [[dic valueForKey:@"settingId"]integerValue];
            }
            else if ([[dic valueForKey:@"settingId"]integerValue] == 2) {
                
                self.imagewifiSet.on = [[dic valueForKey:@"onOff"]integerValue] == 1 ? YES : NO;
                self.imagewifiSet.tag = [[dic valueForKey:@"settingId"]integerValue];
            }
        }
    }];
    
   
}

-(void)setArray:(NSMutableArray *)array {
    
    _array = array;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)pushSet:(UISwitch *)sender {
    
    [self changeWithsetid:sender.tag Withoff:sender.on];
}

- (IBAction)wifiSet:(UISwitch *)sender {
    
    [self changeWithsetid:sender.tag Withoff:sender.on];
}

- (IBAction)hiddenlistClick:(UIButton *)sender {
    
    HiddenPepoleCtrl *hidden = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"HiddenPepoleCtrl"];
    [self.navigationController pushViewController:hidden animated:YES];
}

-(void)changeWithsetid:(NSInteger)settingId Withoff:(BOOL)onoff {
    
    [WebTools postWithURL:@"/circle/postSetting" params:@{@"settingId":@(settingId),@"onOff":onoff == YES ? @1 : @0} success:^(BaseData *data) {
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}



-(void)getSetDatasuccess:(void (^)(NSArray *data))success {
    
    //    @weakify(self)
    [WebTools postWithURL:@"/circle/getPostSettingList" params:@{@"classify":@"circle"} success:^(BaseData *data) {
        
        //        @strongify(self)
        NSArray *array = data.data;
        
        for (NSDictionary *dic in array) {
            
            if ([[dic valueForKey:@"settingId"]integerValue] == 2) {
                
                [Person person].onlywifi = [[dic valueForKey:@"onOff"]boolValue];
            }
        }
        
        success(array);
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
