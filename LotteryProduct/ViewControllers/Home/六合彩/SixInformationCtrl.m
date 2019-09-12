//
//  SixInformationCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixInformationCtrl.h"
#import "SixInfoCell.h"
#import "SixPropertyCtrl.h"
#import "TemaHistoryCtrl.h"
#import "LastnumberCtrl.h"
@interface SixInformationCtrl ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tenumberlabs;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *temissnumberlabs;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *zhengnumberlabs;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *zhengmissnumberlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *tezodiaclabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *temisszodiaclabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *zhengzodiaclabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *zhengmisszodiaclabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *tecolorlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *temisscolorlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *zhengcolorlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *zhengmisscolorlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *telastlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *temisslastlabs;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;




@end

@implementation SixInformationCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topconst.constant = NAV_HEIGHT;
    [self setwhiteC];
    self.titlestring = @"资讯统计";
    
    self.versionnumber = @"100";
    
    //投注按钮
    [self buildBettingBtn];
    for (NSLayoutConstraint *rightconst in self.rights) {
        
        rightconst.constant = 3/SCAL;
    }

}

-(void)setVersionnumber:(NSString *)versionnumber {
    
    [super setVersionnumber:versionnumber];
    
    [self initData];
    
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getInfoE.json" params:@{@"type":@"651",@"issue":self.versionnumber} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *array = data.data;
        
        for (NSDictionary *dic in array) {
            
            if ([[dic valueForKey:@"type"] isEqualToString:@"temaNumIn"]) {
                
                [self getDataWithbuttonarray:self.tenumberlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaNumOut"]) {
                
                [self getDataWithbuttonarray:self.temissnumberlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"zhengmaNumIn"]) {
                
                [self getDataWithbuttonarray:self.zhengnumberlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"zhengmaNumOut"]) {
                
                [self getDataWithbuttonarray:self.zhengmissnumberlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaSxIn"]) {
                
                [self getDataWithlabelarray:self.tezodiaclabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaSxOut"]) {
                
                [self getDataWithlabelarray:self.temisszodiaclabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"zhengmaSxIn"]) {
                
                [self getDataWithlabelarray:self.zhengzodiaclabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"zhengmaSxOut"]) {
                
                [self getDataWithlabelarray:self.zhengmisszodiaclabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaBsIn"]) {
                
                [self getDataWithlabelarray:self.tecolorlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaBsOut"]) {
                
                [self getDataWithlabelarray:self.temisscolorlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"zhengmaBsIn"]) {
                
                [self getDataWithlabelarray:self.zhengcolorlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"zhengmaBsOut"]) {
                
                [self getDataWithlabelarray:self.zhengmisscolorlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaWsIn"]) {
                
                [self getDataWithlabelarray:self.telastlabs Withdata:dic[@"value"]];
            }
            else if ([[dic valueForKey:@"type"] isEqualToString:@"temaWsOut"]) {
                
                [self getDataWithlabelarray:self.temisslastlabs Withdata:dic[@"value"]];
            }
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}


-(void)getDataWithbuttonarray:(NSArray<UIButton *>*)array Withdata:(NSArray *)datas {
    
    if (array.count >= datas.count) {
        
        for (UIButton *btn in array) {
            
            btn.hidden = YES;
        }
        
        int i = 0;
        
        for (NSString *data in datas) {
            
            UIButton *btn = [array objectAtIndex:i];
            
            [btn setTitle:data forState:UIControlStateNormal];
            
            [btn setBackgroundImage:[Tools numbertoimage:data Withselect:NO] forState:UIControlStateNormal];
            
            btn.hidden = NO;
            
            i++;
        }
    }
    else {
        
        int i = 0;
    
        for (UIButton *btn in array) {
            
            NSString *data = [datas objectAtIndex:i];
            
            [btn setTitle:data forState:UIControlStateNormal];
            
            [btn setBackgroundImage:[Tools numbertoimage:data Withselect:NO] forState:UIControlStateNormal];
            
            i++;
        }
    }
}

-(void)getDataWithlabelarray:(NSArray<UILabel *>*)array Withdata:(NSArray *)datas {
    
    if (array.count >= datas.count) {
        
        for (UILabel *lab in array) {
            
            lab.hidden = YES;
        }
        
        int i = 0;
        
        for (NSString *data in datas) {
            
            UILabel *lab = [array objectAtIndex:i];
            
            lab.text = data;
            
            [self settextcolor:lab withdata:data];
            
            lab.hidden = NO;
            
            i++;
        }
    }
    else {
        
        int i = 0;
        
        for (UILabel *lab in array) {
            
            NSString *data = [datas objectAtIndex:i];
            
            lab.text = data;
            
            [self settextcolor:lab withdata:data];
            
            i++;
        }
    }
}

-(void)settextcolor:(UILabel *)lab withdata:(NSString *)data {
    
    if ([data isEqualToString:@"红波"]) {
        
        lab.textColor = [UIColor colorWithHex:@"f15347"];
    }
    else if ([data isEqualToString:@"蓝波"]) {
        
        lab.textColor = [UIColor colorWithHex:@"0587c5"];
    }
    else if ([data isEqualToString:@"绿波"]) {
        
        lab.textColor = [UIColor colorWithHex:@"46be64"];
    }
    else {
        lab.textColor = [UIColor darkTextColor];
    }
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
