//
//  Buyself.m
//  LotteryProduct
//
//  Created by vsskyblue on 2019/1/5.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "BuyTools.h"
#import "MBProgressHUD+WD.h"
#define INTTOSTRING(X) [NSString stringWithFormat:@"%ld",(long)X]

@implementation BuyTools

static  BuyTools*tools=nil;

+(instancetype)tools{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        tools=[[BuyTools alloc]init];
    });
    return tools;
}
/**************************时时彩*************************************/
#pragma mark - 获取时时彩数据源
-(NSArray *)getchongqinDataSourceWith:(CartTypeModel *)selectModel With:(CartChongqinMissModel *)missmodel With:(IQTextView *)textView{
    
    NSMutableArray *dataSource = [[NSMutableArray alloc]init];
    
    if (selectModel.ID == 27 || selectModel.ID == 97) {
        
        NSArray *array = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.same = 1;
            model.missdata = i == 0 ? missmodel.wan : i == 1 ? missmodel.qian : i == 2 ? missmodel.bai : i == 3 ? missmodel.shi : missmodel.ge;
            [dataSource addObject:model];
            
            i++;
        }
    }
    /**
     选择不同选号方式展示不同列表
     
     2：五星单式--------28
     
     10:前四直选单式----42
     16:后四直选单式-----51
     
     22：前三直选单式-----60
     26：中三直选单式------67
     30：后三直选单式-----74
     
     34：后二单式--------92
     36：前二单式---------84
     40：前二组选单式-----86
     
     */
    else if (selectModel.ID == 28 || selectModel.ID == 42 || selectModel.ID == 60 || selectModel.ID == 51 || selectModel.ID == 67 || selectModel.ID == 74 || selectModel.ID == 92 || selectModel.ID == 84 || selectModel.ID == 89 || selectModel.ID == 86) {
        
        textView.text = nil;
        NSString *placeholder = nil;
        if (selectModel.ID == 28) {
            
            placeholder = @"每注号码之间的间隔符支持回车、空格[]、逗号[,]、分号[;]，具体组合规则可以是[]需要成对出现，其他则每任意两个以上间隔符中间有连续的5个数字";
        }else if (selectModel.ID == 42 || selectModel.ID == 51){
            placeholder = @"每注号码之间的间隔符支持回车、空格[]、逗号[,]、分号[;]，具体组合规则可以是[]需要成对出现，其他则每任意两个以上间隔符中间有连续的4个数字";
        }else if (selectModel.ID == 60 || selectModel.ID == 67 || selectModel.ID == 74) {
            placeholder = @"每注号码之间的间隔符支持回车、空格[]、逗号[,]、分号[;]，具体组合规则可以是[]需要成对出现，其他则每任意两个以上间隔符中间有连续的2个数字";
        }else {
            placeholder = @"每注号码之间的间隔符支持回车、空格[]、逗号[,]、分号[;]，具体组合规则可以是[]需要成对出现，其他则每任意两个以上间隔符中间有连续的2个数字";
        }
        
        textView.placeholder = placeholder;
//        showfoot = YES;
    }
    else if (selectModel.ID == 30) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"组选120";
        model.same = 1;
        model.missdata = missmodel.missVal;
        model.isgroup = YES;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 31 || selectModel.ID == 32 || selectModel.ID == 44 || selectModel.ID == 53) {
        
        NSArray *array = @[@"二重号",@"单号"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.isgroup = YES;
            model.same = i == 0 ? 2 : 1;
            model.missdata = missmodel.missVal;
            [dataSource addObject:model];
            
            i++;
        }
    }
    else if (selectModel.ID == 33 || selectModel.ID == 46 || selectModel.ID == 55) {
        
        NSArray *array = @[@"三重号",@"单号"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.isgroup = YES;
            model.same = i == 0 ? 3 : 1;
            model.missdata = missmodel.missVal;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 34) {
        
        NSArray *array = @[@"三重号",@"二重号"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.isgroup = YES;
            model.same = i == 0 ? 3 : 2;
            model.missdata = missmodel.missVal;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 35) {
        
        NSArray *array = @[@"四重号",@"单号"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.isgroup = YES;
            model.same = i == 0 ? 4 : 1;
            model.missdata = missmodel.missVal;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 41) {
        
        NSArray *array = @[@"万位",@"千位",@"百位",@"十位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.wan : i == 1 ? missmodel.qian : i == 2 ? missmodel.bai : missmodel.shi;
            model.same = 1;
            [dataSource addObject:model];
            
            i++;
        }
    }
    else if (selectModel.ID == 43) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"组选24";
        model.isgroup = YES;
        model.missdata = missmodel.missVal;
        model.same = 1;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 45 || selectModel.ID == 54) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"二重号";
        model.isgroup = YES;
        model.same = 2;
        model.missdata = missmodel.missVal;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 50) {
        
        NSArray *array = @[@"千位",@"百位",@"十位",@"个位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.qian : i == 1 ? missmodel.bai : i == 2 ? missmodel.shi : missmodel.ge;
            model.same = 1;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 52) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"组选24";
        model.isgroup = YES;
        model.same = 1;
        model.missdata = missmodel.missVal;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 59) {
        
        NSArray *array = @[@"万位",@"千位",@"百位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.wan : i == 1 ? missmodel.qian : missmodel.bai;
            
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 62 || selectModel.ID == 69 || selectModel.ID == 76) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"组三";
        model.isgroup = YES;
        model.missdata = missmodel.missVal;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 61 || selectModel.ID == 68 || selectModel.ID == 75) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"组六";
        model.isgroup = YES;
        model.same = 1;
        model.missdata = missmodel.missVal;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 66) {
        
        NSArray *array = @[@"千位",@"百位",@"十位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.qian : i == 1 ? missmodel.bai : missmodel.shi;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 73) {
        
        NSArray *array = @[@"百位",@"十位",@"个位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.bai : i == 1 ? missmodel.shi : missmodel.ge;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 90) {
        
        NSArray *array = @[@"十位",@"个位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.shi : missmodel.ge;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 83) {
        
        NSArray *array = @[@"万位",@"千位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.wan : missmodel.qian;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 87) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"后二复式";
        model.isgroup = YES;
        model.missdata = missmodel.missVal;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 85) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"前二复式";
        model.isgroup = YES;
        model.missdata = missmodel.missVal;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 101) {
        
        NSArray *array = @[@"万位",@"千位",@"百位",@"十位",@"个位"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    else if (selectModel.ID == 102) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"总和";
        model.numbers = @[@"大",@"小",@"单",@"双"];
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 103) {
        
        CartChongqinModel *model = [[CartChongqinModel alloc]init];
        model.title = @"总和";
        model.numbers = @[@"大单",@"大双",@"小单",@"小双"];
        [dataSource addObject:model];
    }
    
    else if (selectModel.ID == 104) {
        
        NSArray *array = @[@"万位",@"千位",@"百位",@"十位"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    else if (selectModel.ID == 105) {
        
        NSArray *array = @[@"千位",@"百位",@"十位",@"个位"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    else if (selectModel.ID == 106) {
        
        NSArray *array = @[@"万位",@"千位",@"百位"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    else if (selectModel.ID == 107) {
        
        NSArray *array = @[@"百位",@"十位",@"个人"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    else if (selectModel.ID == 108) {
        
        NSArray *array = @[@"万位",@"千位"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    else if (selectModel.ID == 109) {
        
        NSArray *array = @[@"十位",@"个位"];
        
        for (NSString *title in array) {
            
            CartChongqinModel *model = [[CartChongqinModel alloc]init];
            model.title = title;
            model.numbers = @[@"大",@"小",@"单",@"双"];
            [dataSource addObject:model];
        }
    }
    
    return dataSource;
}
#pragma mark - 获取下注注数
-(void)getchongqintotallotteryCountWith:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(IQTextView *)textView success:(void (^)(NSString *cout, NSString *price))success{
    
    if (selectModel.ID >= 27 && selectModel.ID <101) {
        
        //文本输入号码购买注数
        if (selectModel.ID == 28 || selectModel.ID == 42 || selectModel.ID == 60 || selectModel.ID == 51 || selectModel.ID == 67 || selectModel.ID == 74 || selectModel.ID == 92 || selectModel.ID == 84 || selectModel.ID == 89 || selectModel.ID == 86) {
            
            NSArray *numberarray = nil;
            
            if ([textView.text containsString:@","] ||[textView.text containsString:@"，"] ||[textView.text containsString:@"\n"] ||[textView.text containsString:@";"] || [textView.text containsString:@"；"] ||[textView.text containsString:@" "]) {
                
                NSString *result = [textView.text stringByReplacingOccurrencesOfString:@"," withString:@" "];
                result = [result stringByReplacingOccurrencesOfString:@"，" withString:@" "];
                result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
                result = [result stringByReplacingOccurrencesOfString:@";" withString:@" "];
                result = [result stringByReplacingOccurrencesOfString:@"；" withString:@" "];
                result = [self getmoreblanktoone:result];
                
                numberarray = [result componentsSeparatedByString:@" "];
            }
            else {
                numberarray = @[textView.text];
            }
            if (selectModel.ID == 28) {
                
                for (NSString *str in numberarray) {
                    
                    if (str.length != 5) {
                        numberarray = @[];
                        return;
                    }
                }
            }
            else if (selectModel.ID == 42 || selectModel.ID == 51) {
                
                for (NSString *str in numberarray) {
                    
                    if (str.length != 4) {
                        numberarray = @[];
                        return;
                    }
                }
            }
            else if (selectModel.ID == 60 || selectModel.ID == 67 || selectModel.ID == 74) {
                
                for (NSString *str in numberarray) {
                    
                    if (str.length != 3) {
                        numberarray = @[];
                        return;
                    }
                }
            }
            else if (selectModel.ID == 84 || selectModel.ID == 92 || selectModel.ID == 89 || selectModel.ID == 86) {
                
                for (NSString *str in numberarray) {
                    
                    if (str.length != 2) {
                        numberarray = @[];
                        return;
                    }
                    NSString *str1 = [str substringToIndex:1];
                    NSString *str2 = [str substringFromIndex:1];
                    if ([str1 isEqualToString:str2]) {
                        numberarray = @[];
                        return;
                    }
                }
            }
            
            success([NSString stringWithFormat:@"%lu",(unsigned long)numberarray.count],[NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * numberarray.count]);
            
        }
        //直选复式购买号码数量
        else if (selectModel.ID == 27 || selectModel.ID == 41 || selectModel.ID == 50 || selectModel.ID == 59 || selectModel.ID == 66 || selectModel.ID == 73 || selectModel.ID == 83 || selectModel.ID == 90) {
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            for (CartChongqinModel *model in dataSource) {
                
                if (model.selectnumbers.count == 0) {
                    
                    return;
                }
                else {
                    
                    [array addObject:model.selectnumbers];
                }
            }
            
            NSMutableArray *array1 = [self publishlottery:array];
            
            success(INTTOSTRING(array1.count),[NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * array1.count]);
            
        }
        else if (selectModel.ID == 97) {
            
            NSInteger i = 0;
            
            for (CartChongqinModel *model in dataSource) {
                
                i += model.selectnumbers.count;
            }
            
            success([NSString stringWithFormat:@"%ld",(long)i],[NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * i]);
            
        }
        else {//组选号码购买注数
            
            NSInteger total = 0;
            
            if (selectModel.ID == 30){//五星组选120
                
                CartChongqinModel *model = dataSource.firstObject;
                
                if (model.selectnumbers.count < 5) {
                    
                    return;
                }
                
                total = [self getstep:model.selectnumbers.count With:5];
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 31) {
                
                CartChongqinModel *firstmodel = dataSource.firstObject;
                CartChongqinModel *lastmodel = dataSource.lastObject;
                
                if (firstmodel.selectnumbers.count<1 || lastmodel.selectnumbers.count<3) {
                    
                    return;
                }
                if (lastmodel.selectnumbers.count == 3) {
                    
                    NSSet *set1 = [NSSet setWithArray:firstmodel.selectnumbers];
                    NSSet *set2 = [NSSet setWithArray:lastmodel.selectnumbers];
                    
                    if ([set1 isSubsetOfSet:set2]) {
                        
                        return;
                    }
                }
                
                for (NSString *number in firstmodel.selectnumbers) {
                    
                    if ([lastmodel.selectnumbers containsObject:number]) {
                        
                        NSInteger total1 = [self getstep:lastmodel.selectnumbers.count-1 With:3];
                        
                        total += total1;
                    }
                    else {
                        NSInteger total1 = [self getstep:lastmodel.selectnumbers.count With:3];
                        
                        total += total1;
                    }
                }
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 32) {
                
                CartChongqinModel *firstmodel = dataSource.firstObject;
                CartChongqinModel *lastmodel = dataSource.lastObject;
                
                if (firstmodel.selectnumbers.count<2 || lastmodel.selectnumbers.count<1) {
                    
                    return;
                }
                if (firstmodel.selectnumbers.count == 2) {
                    
                    NSSet *set1 = [NSSet setWithArray:firstmodel.selectnumbers];
                    NSSet *set2 = [NSSet setWithArray:lastmodel.selectnumbers];
                    
                    if ([set2 isSubsetOfSet:set1]) {
                        
                        return;
                    }
                }
                
                for (NSString *number in lastmodel.selectnumbers) {
                    
                    if ([firstmodel.selectnumbers containsObject:number]) {
                        
                        NSInteger total1 = [self getstep:firstmodel.selectnumbers.count-1 With:2];
                        
                        total += total1;
                    }
                    else {
                        NSInteger total1 = [self getstep:firstmodel.selectnumbers.count With:2];
                        
                        total += total1;
                    }
                }
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 33 || selectModel.ID == 44 || selectModel.ID == 53) {
                
                CartChongqinModel *firstmodel = dataSource.firstObject;
                CartChongqinModel *lastmodel = dataSource.lastObject;
                
                if (firstmodel.selectnumbers.count<1 || lastmodel.selectnumbers.count<2) {
                    
                    return;
                }
                if (lastmodel.selectnumbers.count == 2) {
                    
                    NSSet *set1 = [NSSet setWithArray:firstmodel.selectnumbers];
                    NSSet *set2 = [NSSet setWithArray:lastmodel.selectnumbers];
                    
                    if ([set1 isSubsetOfSet:set2]) {
                        
                        return;
                    }
                }
                for (NSString *number in firstmodel.selectnumbers) {
                    
                    if ([lastmodel.selectnumbers containsObject:number]) {
                        
                        NSInteger total1 = [self getstep:lastmodel.selectnumbers.count-1 With:2];
                        
                        total += total1;
                    }
                    else {
                        NSInteger total1 = [self getstep:lastmodel.selectnumbers.count With:2];
                        
                        total += total1;
                    }
                }
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 34 || selectModel.ID == 35 || selectModel.ID == 46 || selectModel.ID == 55) {
                
                CartChongqinModel *firstmodel = dataSource.firstObject;
                CartChongqinModel *lastmodel = dataSource.lastObject;
                
                if (firstmodel.selectnumbers.count<1 || lastmodel.selectnumbers.count<1) {
                    
                    return;
                }
                if (lastmodel.selectnumbers.count == 1) {
                    
                    NSSet *set1 = [NSSet setWithArray:firstmodel.selectnumbers];
                    NSSet *set2 = [NSSet setWithArray:lastmodel.selectnumbers];
                    
                    if ([set1 isSubsetOfSet:set2]) {
                        
                        return;
                    }
                }
                for (NSString *number in firstmodel.selectnumbers) {
                    
                    if ([lastmodel.selectnumbers containsObject:number]) {
                        
                        NSInteger total1 = [self getstep:lastmodel.selectnumbers.count-1 With:1];
                        
                        total += total1;
                    }
                    else {
                        NSInteger total1 = [self getstep:lastmodel.selectnumbers.count With:1];
                        
                        total += total1;
                    }
                }
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 43 || selectModel.ID == 52) {
                
                CartChongqinModel *model = dataSource.firstObject;
                
                if (model.selectnumbers.count < 4) {
                    
                    return;
                }
                
                total = [self getstep:model.selectnumbers.count With:4];
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 45 || selectModel.ID == 54) {
                
                CartChongqinModel *model = dataSource.firstObject;
                
                if (model.selectnumbers.count < 2) {
                    
                    return;
                }
                
                total = [self getstep:model.selectnumbers.count With:2];
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 62 || selectModel.ID == 69 || selectModel.ID == 76) {
                
                CartChongqinModel *model = dataSource.firstObject;
                
                if (model.selectnumbers.count < 2) {
                    
                    return;
                }
                
                total = model.selectnumbers.count * (model.selectnumbers.count-1);
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 61 || selectModel.ID == 68 || selectModel.ID == 75) {
                
                CartChongqinModel *model = dataSource.firstObject;
                
                if (model.selectnumbers.count < 3) {
                    
                    return;
                }
                
                total = [self getstep:model.selectnumbers.count With:3];
                
                NSLog(@"投注：%ld注",(long)total);
            }
            else if (selectModel.ID == 87 || selectModel.ID == 85) {
                
                CartChongqinModel *model = dataSource.firstObject;
                
                if (model.selectnumbers.count < 2) {
                    
                    return;
                }
                
                total = [self getstep:model.selectnumbers.count With:2];
                
                NSLog(@"投注：%ld注",(long)total);
            }
            
            success(INTTOSTRING(total),[NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * total]);
            
        }
    }
    else {//获取大小单双注数
        
        if (selectModel.ID == 102 || selectModel.ID == 103) {
            
            CartChongqinModel *model = dataSource.firstObject;
            
            NSString *count = INTTOSTRING(model.selectnumbers.count);
            NSString *price = [NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * model.selectnumbers.count];
            success(count,price);
        }
        else if (selectModel.ID == 101) {
            
            NSInteger index = 0;
            for (CartChongqinModel *model in dataSource) {
                
                index += model.selectnumbers.count;
                
            }
            NSString *count = INTTOSTRING(index);
            NSString *price = [NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * index];
            success(count,price);
        }
        else {
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            for (CartChongqinModel *model in dataSource) {
                
                if (model.selectnumbers.count == 0) {
                    
                    return;
                }
                else {
                    
                    [array addObject:model.selectnumbers];
                }
            }
            
            NSMutableArray *array1 = [self publishlottery:array];
            [NSString stringWithFormat:@"%ld",array1.count];
            NSString *count = INTTOSTRING(array1.count);
            NSString *price = [NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * array1.count];
            success(count,price);
        }
    }
}

#pragma mark - 文本输入号码购买
-(void)publishchongqintextViewData:(BOOL)cart With:(CartTypeModel *)selectModel With:(IQTextView *)textView With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray  success:(void (^)(NSArray *data))success{
    
    if ([self isEmptyOrNull:textView.text]) {
        
        [MBProgressHUD showError:@"请输入号码"];
        
        return;
    }
    
    NSArray *numberarray = nil;
    
    if ([textView.text containsString:@","] ||[textView.text containsString:@"，"] ||[textView.text containsString:@"\n"] ||[textView.text containsString:@";"] || [textView.text containsString:@"；"] ||[textView.text containsString:@" "]) {
        
        NSString *result = [textView.text stringByReplacingOccurrencesOfString:@"," withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@"，" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@";" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@"；" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@" " withString:@" "];
        
        numberarray = [result componentsSeparatedByString:@" "];
    }
    else {
        numberarray = @[textView.text];
    }
    if (selectModel.ID == 28) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 5) {
                
                [MBProgressHUD showError:@"无效投注"];
                
                return;
            }
        }
    }
    else if (selectModel.ID == 42 || selectModel.ID == 51) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 4) {
                
                [MBProgressHUD showError:@"无效投注"];
                
                return;
            }
        }
    }
    else if (selectModel.ID == 60 || selectModel.ID == 67 || selectModel.ID == 74) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 3) {
                
                [MBProgressHUD showError:@"无效投注"];
                
                return;
            }
        }
    }
    else if (selectModel.ID == 84 || selectModel.ID == 92 || selectModel.ID == 89 || selectModel.ID == 86) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 2) {
                
                [MBProgressHUD showError:@"无效投注"];
                
                return;
            }
            NSString *str1 = [str substringToIndex:1];
            NSString *str2 = [str substringFromIndex:1];
            if ([str1 isEqualToString:str2]) {
                
                [MBProgressHUD showError:@"无效投注"];
                
                return;
            }
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *str in numberarray) {
        
        NSString *doneTitle = @"";
        int count = 0;
        for (int i = 0; i < str.length; i++) {
            
            count++;
            doneTitle = [doneTitle stringByAppendingString:[str substringWithRange:NSMakeRange(i, 1)]];
            if (count == 1) {
                doneTitle = [NSString stringWithFormat:@"%@,", doneTitle];
                count = 0;
            }
        }
        doneTitle = [doneTitle substringToIndex:doneTitle.length - 1];
        
        NSLog(@"%@", doneTitle);
        
        NSDictionary *dict = [self getlistdicWithcount:1 Withnumber:doneTitle With:selectModel With:pricetype With:times With:missmodel];
        
        [array addObject:dict];
        
        if (cart) {
            
            NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
            [cartdic setValue:doneTitle forKey:@"number"];
            [cartdic setValue:@(pricetype) forKey:@"pricetype"];
            [cartdic setValue:@(times) forKey:@"times"];
            [cartdic setValue:@(1) forKey:@"count"];
            [cartdic setValue:selectModel forKey:@"type"];
            [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
            [cartArray addObject:cartdic];
        }
    }
    
    success(array);
}

#pragma mark - 一星定位胆号码购买
-(void)publishchongqindingweidanData:(BOOL)cart  With:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSArray *data))success{
    
    NSMutableString *mutablestring = [NSMutableString string];
    
    for (CartChongqinModel *model in dataSource) {
        
        NSMutableString *numstring = [NSMutableString string];
        
        for (NSString *num in model.selectnumbers) {
            
            [numstring appendString:num];
        }
        [mutablestring appendString:numstring];
        [mutablestring appendString:@","];
    }
    NSString *str = [mutablestring substringWithRange:NSMakeRange(0, mutablestring.length-1)];
    
    NSDictionary *dict = [self getlistdicWithcount:count Withnumber:str With:selectModel With:pricetype With:times With:missmodel];
    if (cart) {
        
        NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
        [cartdic setValue:str forKey:@"number"];
        [cartdic setValue:@(pricetype) forKey:@"pricetype"];
        [cartdic setValue:@(times) forKey:@"times"];
        [cartdic setValue:@(count) forKey:@"count"];
        [cartdic setValue:selectModel forKey:@"type"];
        [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
        [cartArray addObject:cartdic];
    }
    success(@[dict]);
    
}

#pragma mark - 直选复式购买号码/大小单双码购买
-(void)publishchongqinnumberData:(BOOL)cart With:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSArray *data))success{
    
    if (selectModel.ID == 101 || selectModel.ID == 102 || selectModel.ID == 103) {
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (CartChongqinModel *model in dataSource) {
            
            for (NSString *number in model.selectnumbers) {
                
                NSString *str = nil;
                
                if (selectModel.ID == 101) {
                    str = [NSString stringWithFormat:@"%@%@",model.title,number];
                }
                else{
                    str = number;
                }
                
                NSDictionary *dic1 = [self getlistdicWithcount:1 Withnumber:str With:selectModel With:pricetype With:times With:missmodel];
                
                [array addObject:dic1];
                
                if (cart) {
                    
                    NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
                    [cartdic setValue:str forKey:@"number"];
                    [cartdic setValue:@(pricetype) forKey:@"pricetype"];
                    [cartdic setValue:@(times) forKey:@"times"];
                    [cartdic setValue:@(1) forKey:@"count"];
                    [cartdic setValue:selectModel forKey:@"type"];
                    [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
                    [cartArray addObject:cartdic];
                    
                }
            }
        }
        
        success(array);

    }
    else{
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (CartChongqinModel *model in dataSource) {
            
            if (model.selectnumbers.count == 0) {
                
                [MBProgressHUD showError:@"还没选择任何有效投注"];
                
                return;
            }
            else {
                
                [array addObject:model.selectnumbers];
            }
        }
        NSMutableString *str = [NSMutableString string];
        for (NSArray *numarr in array) {
            if (str.length) {
                [str appendString:@","];
            }
            NSMutableString *numstr = [NSMutableString string];
            for (NSString *num in numarr) {
                
                [numstr appendString:num];
            }
            [str appendString:numstr];
        }
        
        NSDictionary *dict = [self getlistdicWithcount:count Withnumber:str With:selectModel With:pricetype With:times With:missmodel];
        
        if (cart) {
            
            NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
            [cartdic setValue:str forKey:@"number"];
            [cartdic setValue:@(pricetype) forKey:@"pricetype"];
            [cartdic setValue:@(times) forKey:@"times"];
            [cartdic setValue:@(count) forKey:@"count"];
            [cartdic setValue:selectModel forKey:@"type"];
            [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
            [cartArray addObject:cartdic];
        }
        
        success(@[dict]);
        
    }
    
    
}

#pragma mark - 组选号码购买
-(void)publishchongqinGroupData:(BOOL)cart With:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel With:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSArray *data))success {
    
    NSMutableString *mutablestr = [NSMutableString string];
    
    for (CartChongqinModel *model in dataSource) {
        
        NSArray *array = model.selectnumbers;
        
        NSMutableString *numstr = [NSMutableString string];
        
        if (mutablestr.length) {
            
            [mutablestr appendString:@","];
        }
        if (model.same != 0) {
            [numstr appendFormat:@"%ld:",(long)model.same];
        }
        for (NSString *num in array) {
            
            [numstr appendString:num];
        }
        
        [mutablestr appendString:numstr];
    }
    
    NSDictionary *dict = [self getlistdicWithcount:count Withnumber:mutablestr With:selectModel With:pricetype With:times With:missmodel];
    
    if (cart) {
        
        NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
        [cartdic setValue:mutablestr forKey:@"number"];
        [cartdic setValue:@(pricetype) forKey:@"pricetype"];
        [cartdic setValue:@(times) forKey:@"times"];
        [cartdic setValue:@(count) forKey:@"count"];
        [cartdic setValue:selectModel forKey:@"type"];
        [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
        [cartArray addObject:cartdic];
    }
    
    success(@[dict]);
    
}

#pragma mark - 文本输入号码购买注数
-(NSInteger)getchongqintextDataCountWith:(IQTextView *)textView With:(CartTypeModel *)selectModel{
    
    NSArray *numberarray = nil;
    
    if ([self isEmptyOrNull:textView.text]) {
        
        return 0;
    }
    
    if ([textView.text containsString:@","] ||[textView.text containsString:@"，"] ||[textView.text containsString:@"\n"] ||[textView.text containsString:@";"] || [textView.text containsString:@"；"] ||[textView.text containsString:@" "]) {
        
        NSString *result = [textView.text stringByReplacingOccurrencesOfString:@"," withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@"，" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@";" withString:@" "];
        result = [result stringByReplacingOccurrencesOfString:@"；" withString:@" "];
        result = [self getmoreblanktoone:result];
        
        numberarray = [result componentsSeparatedByString:@" "];
    }
    else {
        numberarray = @[textView.text];
    }
    if (selectModel.ID == 28) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 5) {
                numberarray = @[];
                return 0;
            }
        }
    }
    else if (selectModel.ID == 42 || selectModel.ID == 51) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 4) {
                numberarray = @[];
                return 0;
            }
        }
    }
    else if (selectModel.ID == 60 || selectModel.ID == 67 || selectModel.ID == 74) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 3) {
                numberarray = @[];
                return 0;
            }
        }
    }
    else if (selectModel.ID == 84 || selectModel.ID == 92 || selectModel.ID == 89 || selectModel.ID == 86) {
        
        for (NSString *str in numberarray) {
            
            if (str.length != 2) {
                numberarray = @[];
                return 0;
            }
            NSString *str1 = [str substringToIndex:1];
            NSString *str2 = [str substringFromIndex:1];
            if ([str1 isEqualToString:str2]) {
                numberarray = @[];
                return 0;
            }
        }
    }
    return numberarray.count;
}

/**************************北京PK10*************************************/
#pragma mark - 获取北京PK10数据
-(void)getpk10DataSource:(NSMutableArray *)dataSource With:(CartTypeModel *)selectModel With:(CartBeijinMissModel *)missmodel With:(CartOddsModel *)oddmodel With:(IQTextView *)textView With:(BOOL)showfoot{
    
    if (selectModel.ID == 135) {
        
        NSArray *array = @[@"冠亚和",@"冠军位",@"亚军位",@"季军位",@"第四位",@"第五位",@"第六位",@"第七位",@"第八位",@"第九位",@"第十位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartBeijingModel *model = [[CartBeijingModel alloc]init];
            model.title = title;
            switch (i) {
                    case 0:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"冠亚和"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 1:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第一名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 2:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第二名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 3:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第三名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 4:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第四名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 5:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第五名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 6:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第六名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 7:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第七名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 8:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第八名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 9:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第九名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                    case 10:
                {
                    for (OddsList *list in oddmodel.oddsList) {
                        
                        if ([list.name containsString:@"第十名"]) {
                            
                            [model.odds addObject:list];
                        }
                    }
                }
                    break;
                default:
                    break;
            }
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 136) {
        
        CartBeijingModel *model = [[CartBeijingModel alloc]init];
        model.title = @"冠军位";
        model.missdata = missmodel.one;
        model.missdata = missmodel.one;
        [dataSource addObject:model];
    }
    else if (selectModel.ID == 137) {
        
        NSArray *array = @[@"冠军位",@"亚军位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartBeijingModel *model = [[CartBeijingModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.one : missmodel.two;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 138 || selectModel.ID == 141 || selectModel.ID == 143 || selectModel.ID == 145) {
        
        textView.text = nil;
        showfoot = YES;
    }
    else if (selectModel.ID == 139) {
        
        NSArray *array = @[@"冠军位",@"亚军位",@"季军位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartBeijingModel *model = [[CartBeijingModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.one : i == 1 ? missmodel.two : missmodel.three;
            [dataSource addObject:model];
            i++;
        }
    }
    
    else if (selectModel.ID == 142) {
        
        NSArray *array = @[@"第一位",@"第二位",@"第三位",@"第四位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartBeijingModel *model = [[CartBeijingModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.one : i == 1 ? missmodel.two : i == 2 ? missmodel.three : missmodel.four;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 144 || selectModel.ID == 146) {
        
        NSArray *array = @[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartBeijingModel *model = [[CartBeijingModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.one : i == 1 ? missmodel.two : i == 2 ? missmodel.three : i == 3 ? missmodel.four : missmodel.five;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 147) {
        
        NSArray *array = @[@"第六位",@"第七位",@"第八位",@"第九位",@"第十位"];
        int i = 0;
        for (NSString *title in array) {
            
            CartBeijingModel *model = [[CartBeijingModel alloc]init];
            model.title = title;
            model.missdata = i == 0 ? missmodel.six : i == 1 ? missmodel.seven : i == 2 ? missmodel.eight : i == 3 ? missmodel.nine : missmodel.ten;
            [dataSource addObject:model];
            i++;
        }
    }
    else if (selectModel.ID == 148) {
        
        CartBeijingModel *model = [[CartBeijingModel alloc]init];
        model.title = @"冠亚和";
        NSArray *number = @[@"冠亚大",@"冠亚小",@"冠亚单",@"冠亚双",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19"];
        for (NSString *str in number) {
            
            for (OddsList *list in oddmodel.oddsList) {
                
                if ([str isEqualToString:list.name]) {
                    
                    [model.odds addObject:list];
                }
            }
        }
        [dataSource addObject:model];
    }
}



#pragma mark - 获取下注注数
-(void)getpk10totallotteryCountWith:(CartTypeModel *)selectModel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times success:(void (^)(NSString *cout, NSString *price))success{
    
    NSInteger count = 0;
    
    if (selectModel.ID == 135 || selectModel.ID == 136 || selectModel.ID == 146 || selectModel.ID == 147 || selectModel.ID == 148) {
        
        for (CartBeijingModel *model in dataSource) {
            
            count += model.selectnumbers.count;
        }
    }
    else {
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (CartBeijingModel *model in dataSource) {
            
            if (model.selectnumbers.count == 0) {
                
                return;
            }
            else {
                
                [array addObject:model.selectnumbers];
            }
        }
        
        NSMutableArray *marray = [self publishlottery:array];
        
        NSArray *array1 = [NSArray arrayWithArray:marray];
        for (NSString *str in array1) {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            for (int i = 0; i< str.length; i+=2) {
                
                NSString *cell = [str substringWithRange:NSMakeRange(i, 2)];
                
                [dic setValue:cell forKey:cell];
            }
            
            if (dic.allValues.count<str.length/2) {
                
                [marray removeObject:str];
            }
        }
        
        count = marray.count;
    }
    
    NSString *countstr = [NSString stringWithFormat:@"%ld",count];
    NSString *price = [NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * count];
    
    success(countstr,price);
}


#pragma mark - 单式输入号码的注数
-(void)getpk10textlotterycountWith:(CartTypeModel *)selectModel With:(IQTextView *)textView With:(NSInteger)pricetype With:(NSInteger)times success:(void (^)(NSString *cout, NSString *price))success{
    
    NSInteger count = 0;
    
    if (selectModel.ID == 138 || selectModel.ID == 141 || selectModel.ID == 143 || selectModel.ID == 145) {
        
        if ([textView.text containsString:@","] ||[textView.text containsString:@"，"] ||[textView.text containsString:@"\n"] ||[textView.text containsString:@";"] || [textView.text containsString:@"；"]) {
            
            NSString *result = [textView.text stringByReplacingOccurrencesOfString:@"," withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@"，" withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@";" withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@"；" withString:@","];
            result = [self getmoreblanktoone:result];
            
            NSArray *numberarray = [result componentsSeparatedByString:@","];
            
            for (NSString *str in numberarray) {
                
                NSArray *cellarr = [str componentsSeparatedByString:@" "];
                
                for (NSString *cell in cellarr) {
                    
                    if (cell.integerValue > 10 || cell.integerValue < 1) {
                        
                        return;
                    }
                }
                NSSet *set = [NSSet setWithArray:cellarr];
                NSArray *resultArray = [set allObjects];
                if (resultArray.count != cellarr.count) {
                    
                    return;
                }
                
                if(selectModel.ID == 138 && cellarr.count != 2) {
                    
                    return;
                }
                else if (selectModel.ID == 141 && cellarr.count != 3) {
                    
                    return;
                }
                else if (selectModel.ID == 143 && cellarr.count != 4) {
                    
                    return;
                }
                else if (selectModel.ID == 145 && cellarr.count != 5) {
                    
                    return;
                }
            }
            count = numberarray.count;
        }
        else {
            
            NSString *result = [self getmoreblanktoone:textView.text];
            
            NSArray *cellarr = [result componentsSeparatedByString:@" "];
            
            for (NSString *cell in cellarr) {
                
                if (cell.integerValue > 10 || cell.integerValue < 1) {
                    
                    return;
                }
            }
            
            if(selectModel.ID == 138 && cellarr.count != 2) {
                
                return;
            }
            else if (selectModel.ID == 141 && cellarr.count != 3) {
                
                return;
            }
            else if (selectModel.ID == 143 && cellarr.count != 4) {
                
                return;
            }
            else if (selectModel.ID == 145 && cellarr.count != 5) {
                
                return;
            }
            
            count = 1;
        }
        
        NSString *countstr = INTTOSTRING(count);
        NSString *price = [NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * count];
        
        success(countstr, price);
    }
    
}

#pragma mark - 最高可中
-(void)getpk10maxpriceWith:(CartTypeModel *)selectModel With:(CartBeijinMissModel *)missmodel With:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times success:(void (^)(NSString *price))success;{
    
    if (selectModel.ID == 135 ) {
        
        CGFloat price = 0.0;
        
        for (CartBeijingModel *model in dataSource) {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            for (OddsList *list in model.selectnumbers) {
                
                if ([list.name containsString:@"大"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"bigsmall"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"bigsmall"];
                    }
                    
                }
                else if ([list.name containsString:@"小"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"bigsmall"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"bigsmall"];
                    }
                    
                }
                else if ([list.name containsString:@"单"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"sigledouble"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"sigledouble"];
                    }
                    
                }
                else if ([list.name containsString:@"双"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"sigledouble"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"sigledouble"];
                    }
                }
                else if ([list.name containsString:@"龙"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"longhu"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"longhu"];
                    }
                }
                else if ([list.name containsString:@"虎"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"longhu"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"longhu"];
                    }
                }
            }
            
            for (OddsList *list in dic.allValues) {
                
                price += [self lotteryprice:pricetype] * times * list.odds.floatValue;
            }
        }
        
        success([NSString stringWithFormat:@"最高可中%.2f元",price]);
       
    }
    else if (selectModel.ID == 148) {
        
        CGFloat price = 0.0;
        OddsList *maxoddsmodel = nil;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        CartBeijingModel *model = dataSource.firstObject;
        
        for (OddsList *list in model.selectnumbers) {
            
            if ([self isPureInt:list.name]) {
                
                if (maxoddsmodel) {
                    
                    if (maxoddsmodel.odds.floatValue < list.odds.floatValue) {
                        
                        maxoddsmodel = list;
                    }
                }
                else{
                    maxoddsmodel = list;
                }
            }
            else{
                if ([list.name containsString:@"大"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"bigsmall"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"bigsmall"];
                    }
                    
                }
                else if ([list.name containsString:@"小"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"bigsmall"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"bigsmall"];
                    }
                    
                }
                else if ([list.name containsString:@"单"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"sigledouble"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"sigledouble"];
                    }
                    
                }
                else if ([list.name containsString:@"双"]) {
                    
                    OddsList *oldlist = [dic valueForKey:@"sigledouble"];
                    
                    if (oldlist && oldlist.odds.floatValue > list.odds.floatValue) {
                        
                        continue;
                    }
                    else {
                        [dic setValue:list forKey:@"sigledouble"];
                    }
                }
            }
        }
        
        CGFloat pure_price = [self lotteryprice:pricetype] * times * maxoddsmodel.odds.floatValue;
        
        for (OddsList *list in dic.allValues) {
            
            price += [self lotteryprice:pricetype] * times * list.odds.floatValue;
        }
        price += pure_price;
        
        success([NSString stringWithFormat:@"最高可中%.2f元",price]);
    }
    else{
        CGFloat price = [self lotteryprice:pricetype] * times * [missmodel.play[@"odds"]floatValue];
        
        success([NSString stringWithFormat:@"最高可中%.2f元",price]);
    }
    
    
}

#pragma mark - NO:号码投注/YES:号码加购物车
-(void)publishpk10lotteryData:(BOOL)cart With:(CartTypeModel *)selectModel With:(CartBeijinMissModel *)missmodel With:(NSMutableArray *)dataSource Withcar:(NSMutableArray *)cartArray With:(IQTextView *)textView With:(NSInteger)pricetype With:(NSInteger)times Withcount:(NSInteger)count success:(void (^)(NSString*data))success {
    
    if (selectModel.ID == 138 || selectModel.ID == 141 || selectModel.ID == 143 || selectModel.ID == 145) {
        
        NSString *result = nil;
        
        NSMutableString *newresult = [NSMutableString string];
        
        if ([textView.text containsString:@","] ||[textView.text containsString:@"，"] ||[textView.text containsString:@"\n"] ||[textView.text containsString:@";"] || [textView.text containsString:@"；"]) {
            
            result = [textView.text stringByReplacingOccurrencesOfString:@"," withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@"，" withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@";" withString:@","];
            result = [result stringByReplacingOccurrencesOfString:@"；" withString:@","];
            result = [self getmoreblanktoone:result];
            
            NSArray *numberarray = [result componentsSeparatedByString:@","];
            
            for (NSString *str in numberarray) {
                
                NSArray *cellarr = [str componentsSeparatedByString:@" "];
                
                NSMutableString *newresult2 = [NSMutableString string];
                
                for (NSString *cell in cellarr) {
                    
                    NSString *newcell = [NSString stringWithFormat:@"%02ld",(long)cell.integerValue];
                    
                    if (newresult2.length) {
                        
                        [newresult2 appendString:@" "];
                    }
                    
                    [newresult2 appendString:newcell];
                    
                    if (cell.integerValue > 10 || cell.integerValue < 1) {
                        
                        [MBProgressHUD showError:@"请输入1-10的数字号码"];
                        return;
                    }
                }
                
                if (newresult.length) {
                    
                    [newresult appendString:@","];
                }
                
                [newresult appendString:newresult2];
                
                NSSet *set = [NSSet setWithArray:cellarr];
                NSArray *resultArray = [set allObjects];
                if (resultArray.count != cellarr.count) {
                    [MBProgressHUD showError:@"每注输入值不能有两个相同号码"];
                    return;
                }
                if(selectModel.ID == 138 && cellarr.count != 2) {
                    [MBProgressHUD showError:@"请每注输入两个号码"];
                    return;
                }
                else if (selectModel.ID == 141 && cellarr.count != 3) {
                    [MBProgressHUD showError:@"请每注输入三个号码"];
                    return;
                }
                else if (selectModel.ID == 143 && cellarr.count != 4) {
                    [MBProgressHUD showError:@"请每注输入四个号码"];
                    return;
                }
                else if (selectModel.ID == 145 && cellarr.count != 5) {
                    [MBProgressHUD showError:@"请每注输入五个号码"];
                    return;
                }
            }
            
        }
        else {
            result = [self getmoreblanktoone:textView.text];
            
            NSArray *cellarr = [result componentsSeparatedByString:@" "];
            
            for (NSString *cell in cellarr) {
                
                NSString *newcell = [NSString stringWithFormat:@"%02ld",(long)cell.integerValue];
                
                if (newresult.length) {
                    
                    [newresult appendString:@" "];
                }
                [newresult appendString:newcell];
                
                if (cell.integerValue > 10 || cell.integerValue < 1) {
                    
                    [MBProgressHUD showError:@"请输入1-10的数字号码"];
                    return;
                }
            }
            NSSet *set = [NSSet setWithArray:cellarr];
            NSArray *resultArray = [set allObjects];
            if (resultArray.count != cellarr.count) {
                [MBProgressHUD showError:@"每注输入值不能有两个相同号码"];
                return;
            }
            if(selectModel.ID == 138 && cellarr.count != 2) {
                [MBProgressHUD showError:@"请每注输入两个号码"];
                return;
            }
            else if (selectModel.ID == 141 && cellarr.count != 3) {
                [MBProgressHUD showError:@"请每注输入三个号码"];
                return;
            }
            else if (selectModel.ID == 143 && cellarr.count != 4) {
                [MBProgressHUD showError:@"请每注输入四个号码"];
                return;
            }
            else if (selectModel.ID == 145 && cellarr.count != 5) {
                [MBProgressHUD showError:@"请每注输入五个号码"];
                return;
            }
        }
        if (cart) {
            
            NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
            [cartdic setValue:newresult forKey:@"number"];
            [cartdic setValue:@(pricetype) forKey:@"pricetype"];
            [cartdic setValue:@(times) forKey:@"times"];
            [cartdic setValue:@(count) forKey:@"count"];
            [cartdic setValue:selectModel forKey:@"type"];
            [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
            [cartArray addObject:cartdic];
            
        }
        
        success(newresult);
        
    }
    else {
        if (count == 0) {
            
            [MBProgressHUD showError:@"无效投注"];
            
            return;
        }
        
        NSMutableString *mstring = [NSMutableString string];
        NSInteger settingId = 0;
        for (CartBeijingModel *model in dataSource) {
            
            if (selectModel.ID == 135 || selectModel.ID == 148 || selectModel.ID == 136) {
                
                if (selectModel.ID == 136) {
                    
                    for (NSString *mstr in model.selectnumbers) {
                        
                        [mstring appendString:mstr];
                        
                        [mstring appendString:@","];
                    }
                }
                else{
                    for (OddsList *list in model.selectnumbers) {
                        
                        settingId = list.settingId;
                        
                        [mstring appendString:list.name];
                        
                        [mstring appendString:@","];
                    }
                }
                
            }
            else {
                
                NSMutableString *mstr = [NSMutableString string];
                
                for (NSString *str in model.selectnumbers) {
                    
                    if (mstr.length) {
                        
                        [mstr appendString:@" "];
                    }
                    [mstr appendString:str];
                }
                
                [mstring appendString:mstr];
                
                [mstring appendString:@","];
            }
        }
        
        NSString *resultstring = [mstring substringToIndex:mstring.length-1];
        if (cart) {
            
            if (selectModel.ID == 135 || selectModel.ID == 148 || selectModel.ID == 136) {
                
                NSArray *array = [resultstring componentsSeparatedByString:@","];
                
                for (NSString *str in array) {
                    
                    NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
                    [cartdic setValue:str forKey:@"number"];
                    [cartdic setValue:@(pricetype) forKey:@"pricetype"];
                    [cartdic setValue:@(times) forKey:@"times"];
                    [cartdic setValue:@(1) forKey:@"count"];
                    [cartdic setValue:selectModel forKey:@"type"];
                    if (selectModel.ID == 136) {
                        [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
                    }
                    else{
                        [cartdic setValue:@(settingId) forKey:@"settingId"];
                    }
                    
                    [cartArray addObject:cartdic];
                }
            }
            else{
                NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
                [cartdic setValue:resultstring forKey:@"number"];
                [cartdic setValue:@(pricetype) forKey:@"pricetype"];
                [cartdic setValue:@(times) forKey:@"times"];
                [cartdic setValue:@(count) forKey:@"count"];
                [cartdic setValue:selectModel forKey:@"type"];
                [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
                [cartArray addObject:cartdic];
            }
        }
        success(resultstring);
        
    }
    
}
/*****************************pc蛋蛋************************************/
#pragma mark - 获取pc蛋蛋彩票下注注数
-(void)getpclotteryCountWith:(CartTypeModel *)selectModel With:(NSInteger)pricetype With:(NSInteger)times Withface:(NSArray *)faceDataArray Withcolor:(NSArray *)colorDataArray Withsame:(NSArray *)sameDataArray Withnumber:(NSArray *)numberDataArray success:(void (^)(NSString *cout, NSString *price))success;{
    
    NSInteger count = 0;
    
    if (selectModel.ID == 10) {
        
        for (CartPCModel *model in faceDataArray) {
            
            if (model.select) {
                
                count++;
            }
        }
    }
    else if (selectModel.ID == 11) {
        
        for (CartPCModel *model in colorDataArray) {
            
            if (model.select) {
                
                count++;
            }
        }
    }
    else if (selectModel.ID == 12) {
        
        CartPCModel *model = sameDataArray.firstObject;
        
        if (model.select) {
            
            count++;
        }
    }
    else if (selectModel.ID== 13) {
        int j = 0;
        for (CartPCModel *model in numberDataArray) {
            
            if (model.select) {
                
                j++;
            }
            if (j == 3) {
                
                count = 1;
            }
        }
    }
    else if (selectModel.ID == 14) {
        
        for (CartPCModel *model in numberDataArray) {
            
            if (model.select) {
                
                count++;
            }
        }
    }
    
    NSString *countstr = INTTOSTRING(count);
    NSString *price = [NSString stringWithFormat:@"%.2f",[self lotteryprice:pricetype] * times * count];
    
    success(countstr,price);
}

#pragma mark - cart = no:立即购买/cart = yes:加入购彩篮，
-(void)publishpclotteryData:(BOOL)cart With:(CartTypeModel *)selectModel With:(CartChongqinMissModel *)missmodel With:(NSInteger)pricetype With:(NSInteger)times Withface:(NSArray *)faceDataArray Withcolor:(NSArray *)colorDataArray Withsame:(NSArray *)sameDataArray Withnumber:(NSArray *)numberDataArray Withcar:(NSMutableArray *)cartArray Withcount:(NSInteger)count success:(void (^)(NSString*data,NSArray*dataArray))success{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableString *str = [NSMutableString string];
    if (selectModel.ID == 10) {
        
        for (CartPCModel *model in faceDataArray) {
            
            if (model.select) {
                
                NSDictionary *dic = [self getlistdicWithcount:1 Withnumber:model.name With:selectModel With:pricetype With:times With:missmodel];
                
                [array addObject:dic];
            }
        }
    }
    else if (selectModel.ID == 11) {
        
        for (CartPCModel *model in colorDataArray) {
            
            if (model.select) {
                
                NSDictionary *dic = [self getlistdicWithcount:1 Withnumber:model.name With:selectModel With:pricetype With:times With:missmodel];
                
                [array addObject:dic];
            }
        }
    }
    else if (selectModel.ID == 12) {
        
        CartPCModel *model = sameDataArray.firstObject;
        
        if (model.select) {
            
            NSDictionary *dic = [self getlistdicWithcount:1 Withnumber:model.name With:selectModel With:pricetype With:times With:missmodel];
            
            [array addObject:dic];
        }
    }
    else if (selectModel.ID == 13) {
        
        for (CartPCModel *model in numberDataArray) {
            
            if (model.select) {
                
                if(str.length) {
                    [str appendString:@","];
                }
                [str appendString:model.name];
            }
        }
    }
    else if (selectModel.ID == 14) {
        
        for (CartPCModel *model in numberDataArray) {
            
            if (model.select) {
                
                NSDictionary *dic = [self getlistdicWithcount:1 Withnumber:model.name With:selectModel With:pricetype With:times With:missmodel];
                
                [array addObject:dic];
            }
        }
    }
    if (cart) {
        
        if (str.length == 0) {
            
            for (NSDictionary *dic in array) {
                
                NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
                [cartdic setValue:dic[@"betNumber"] forKey:@"number"];
                [cartdic setValue:@(pricetype) forKey:@"pricetype"];
                [cartdic setValue:@(times) forKey:@"times"];
                [cartdic setValue:@(1) forKey:@"count"];
                [cartdic setValue:selectModel forKey:@"type"];
                [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
                [cartArray addObject:cartdic];
            }
        }
        else{
            NSMutableDictionary *cartdic = [[NSMutableDictionary alloc]init];
            [cartdic setValue:str forKey:@"number"];
            [cartdic setValue:@(pricetype) forKey:@"pricetype"];
            [cartdic setValue:@(times) forKey:@"times"];
            [cartdic setValue:@(count) forKey:@"count"];
            [cartdic setValue:selectModel forKey:@"type"];
            [cartdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
            [cartArray addObject:cartdic];
        }
    }
    
    success(str,array);
    
}


#pragma mark - 获取六合彩下注注数及金额
-(void)getsixlotteryCountWith:(CartTypeModel *)selectModel WithballArr:(NSMutableArray *)ballDataArray WithblockArr:(NSMutableArray *)blockDataArray Withblock2Arr:(NSMutableArray *)block2DataArray WithdatasourceArr:(NSMutableArray *)dataSource With:(NSInteger)pricetype With:(NSInteger)times With:(UITableView *)tableView success:(void (^)(NSString*countstr,NSString*pricestr,NSString*maxprice))success{
    
    CGFloat price = 0.0;
    NSInteger count = 0;
    /*
     1：特码A-------------- 297
     2：特码B-------------- 313
     */
    if (selectModel.ID == 297 || selectModel.ID == 313) {
        
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                count++;
                price = model.odds.floatValue * times * [self lotteryprice:pricetype];
            }
        }
        NSArray *titeleArray = @[@[@"1-10",@"11-20",@"21-30",@"31-40",@"41-49"],@[@"单",@"双"],@[@"大",@"小"],@[@"合单",@"合双"],@[@"家禽",@"野兽"],@[@"尾大",@"尾小"],@[@"红波",@"蓝波",@"绿波"]];
        
        NSDictionary *blockdic = [self getblockprice:titeleArray WithblockArr:blockDataArray With:pricetype With:times];
        
        count += [blockdic[@"count"]integerValue];
        price += [blockdic[@"price"]floatValue];
        
    }
    /*
     3：正码A--------------298
     4：正码B--------------321
     */
    else if (selectModel.ID == 298 || selectModel.ID == 321) {
        
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                count++;
                if (count <= 6) {
                    
                    price += model.odds.floatValue * times * [self lotteryprice:pricetype];
                }
            }
        }
        for (NSArray *array in blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    count++;
                    
                    price += model.odds.floatValue * times * [self lotteryprice:pricetype];
                }
            }
        }
        
    }
    //5：正码1-6------------299
    else if (selectModel.ID == 299) {
        
        NSArray *titeleArray = @[@[@"大",@"小"],@[@"单",@"双"],@[@"合单",@"合双"],@[@"红波",@"蓝波",@"绿波"],@[@"尾大",@"尾小"]];
        
        NSDictionary *blockdic = [self getblockprice:titeleArray WithblockArr:blockDataArray With:pricetype With:times];
        
        count += [blockdic[@"count"]integerValue];
        price += [blockdic[@"price"]floatValue];
        
    }
    /*
     6：正特1--------------300
     7：正特2--------------328
     8：正特3--------------330
     9：正特4--------------332
     10：正特5-------------333
     11：正特6-------------334
     */
    else if (selectModel.ID == 300 || selectModel.ID == 328 || selectModel.ID == 330 || selectModel.ID == 332 || selectModel.ID == 333 || selectModel.ID == 334) {
        
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                count++;
                
                price = model.odds.floatValue * times * [self lotteryprice:pricetype];
            }
        }
        
        NSArray *titeleArray = @[@[@"大",@"小"],@[@"单",@"双"],@[@"合单",@"合双"],@[@"红波",@"蓝波",@"绿波"],@[@"尾大",@"尾小"]];
        
        NSDictionary *blockdic = [self getblockprice:titeleArray WithblockArr:blockDataArray With:pricetype With:times];
        
        count += [blockdic[@"count"]integerValue];
        price += [blockdic[@"price"]floatValue];
        
    }
    /*
     12：三全中-------------343
     13：三中二-------------345
     14：二全中-------------372
     15：二中特-------------346
     16：特串---------------301
     */
    else if (selectModel.ID == 343 || selectModel.ID == 345 || selectModel.ID == 346 || selectModel.ID == 372 || selectModel.ID == 301) {
        
        NSInteger selectcount = 0;
        CGFloat odds = 0.0;
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                selectcount++;
                
                if ([model.odds containsString:@"/"]) {
                    
                    NSString *maxodds = [model.odds componentsSeparatedByString:@"/"].firstObject;
                    
                    odds = maxodds.floatValue;
                }
                else {
                    odds = model.odds.floatValue;
                }
                
            }
        }
        
        if (selectModel.ID == 346 || selectModel.ID == 372 || selectModel.ID == 301) {
            
            count = [self getstep:selectcount With:2];
            
        }
        else {
            count = [self getstep:selectcount With:3];
        }
        
        if (selectModel.ID == 301 && selectcount>7) {
            
            NSInteger tecount = [self getstep:7 With:2];
            price = odds * times * [self lotteryprice:pricetype] *tecount;
        }
        else{
            price = odds * times * [self lotteryprice:pricetype] *count;
        }
        
        
    }
    //17：红波、蓝波、绿波-----302
    else if (selectModel.ID == 302) {
        
        NSArray *titeleArray = @[@[@"红单",@"红双"],@[@"红大",@"红小"],@[@"红合单",@"红合双"]];
        
        int j = 0;
        for (int i = 0; i<dataSource.count;) {
            
            NSArray *array = [dataSource subarrayWithRange:NSMakeRange(i, [titeleArray[j]count])];
            
            i+= [titeleArray[j]count];
            
            j++;
            
            CGFloat blockprice = 0;
            CGFloat maxodds = 0.0;
            for (CartSixModel *m in array) {
                
                if (m.select) {
                    
                    count++;
                    
                    maxodds = MAX(m.odds.floatValue, maxodds);
                    
                    blockprice = maxodds * times * [self lotteryprice:pricetype];
                }
            }
            
            price += blockprice;
        }
        
    }
    /*
     18：全尾--------------  303
     19：特尾--------------  341
     26：平特-----------305
     27：特肖-----------306
     */
    else if (selectModel.ID == 303 || selectModel.ID == 341 || selectModel.ID == 305 || selectModel.ID == 306) {
        
        CGFloat maxodds = 0.0;
        for (CartSixModel *model in dataSource) {
            
            if (model.select) {
                
                if (selectModel.ID == 303 || selectModel.ID == 305) {
                    
                    if (count < 7) {
                        
                        price += model.odds.floatValue * times * [self lotteryprice:pricetype];
                    }
                    
                    count++;
                }
                else {
                    if (model.odds.floatValue > maxodds) {
                        
                        price = model.odds.floatValue * times * [self lotteryprice:pricetype];
                        
                        maxodds = price;
                    }
                    count++;
                }
            }
            
        }
        
    }
    /*
     20：五不中 ------342
     21：六不中--------347
     22：七不中--------348
     23：八不中---------349
     24：九不中---------350
     25：十不中---------351
     */
    else if (selectModel.ID == 342 || (selectModel.ID >= 347 && selectModel.ID <= 351)){
        
        NSInteger selectcount = 0;
        CGFloat odds = 0.0;
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                odds = model.odds.floatValue;
                selectcount++;
            }
        }
        count = [self getstep:selectcount With:selectModel.ID == 342 ? 5 : selectModel.ID == 347 ? 6 : selectModel.ID == 348 ? 7 : selectModel.ID == 349 ? 8 : selectModel.ID == 350 ? 9 : 10];
        price = odds * times * count * [self lotteryprice:pricetype];
        
    }
    /*
     28：六肖连中--------352
     29：六肖连不中------353
     */
    else if (selectModel.ID == 352 || selectModel.ID == 353) {
        
        NSInteger selectcount = 0;
        
        CGFloat maxodds = 0.0;
        for (CartSixModel *model in dataSource) {
            
            if (model.select) {
                
                selectcount++;
                
                if (selectcount>6) {
                    
                    [MBProgressHUD showError:@"最多选取六项"];
                    
                    model.select = NO;
                    
                    [tableView reloadData];
                    
                    return;
                }
                
                maxodds = MAX(model.odds.floatValue, maxodds);
            }
        }
        if (selectcount == 6) {
            
            count = 1;
            
            price = maxodds * times * [self lotteryprice:pricetype];
        }
        else if (selectcount < 6) {
            count = 0;
            
            price = 0.0;
        }
        
    }
    /*
     30：二连肖（中）-----360
     31：二连肖（不中）----361
     32：三连肖（中）------362
     33：三连肖（不中）-----363
     34：四连肖（中）------364
     35：四连肖（不中）-----365
     36：二连尾（中）-------366
     37：二连尾（不中）------367
     38：三连尾（中）-------368
     39：三连尾（不中）------369
     40：四连尾（中）-------370
     41：四连尾（不中）------371
     */
    else if (selectModel.ID >= 360 && selectModel.ID <= 371) {
        
        NSInteger selectcount = 0;
        
        CGFloat odds = 0.0;
        
        for (CartSixModel *model in dataSource) {
            
            if (model.select) {
                
                odds = model.odds.floatValue;
                
                selectcount ++;
            }
        }
        NSInteger type = 2;
        if (selectModel.ID == 360 || selectModel.ID == 361 || selectModel.ID == 366 || selectModel.ID == 367) {
            
            type = 2;
        }
        else if (selectModel.ID == 362 || selectModel.ID == 363 || selectModel.ID == 368 || selectModel.ID == 369) {
            
            type = 3;
        }
        else{
            type = 4;
        }
        count = [self getstep:selectcount With:type];
        
        price = count * odds * times * [self lotteryprice:pricetype];
        
    }
    
    //42：1-6龙虎----------- 310
    else if (selectModel.ID == 310) {
        
        CGFloat odds = 0.0;
        NSMutableArray *array1 = [[NSMutableArray alloc]init];
        NSMutableArray *array2 = [[NSMutableArray alloc]init];
        for (NSArray *array in blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    [array1 addObject:model.number];
                    odds = model.odds.floatValue;
                    count ++;
                }
            }
        }
        for (NSArray *array in block2DataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    [array2 addObject:model.number];
                    odds = model.odds.floatValue;
                    count++;
                }
            }
        }
        
        NSMutableSet *set = [[NSMutableSet alloc]init];
        
        [set addObjectsFromArray:array1];
        [set addObjectsFromArray:array2];
        
        NSLog(@"setcount:%ld",set.count);
        
        price = set.count * odds * times * [self lotteryprice:pricetype];
        
        
    }
    // 43：五行-------------311
    else if (selectModel.ID == 311) {
        
        for (CartSixModel *model in dataSource) {
            
            if (model.select) {
                
                count ++;
                
                price = model.odds.floatValue * times * [self lotteryprice:pricetype];
            }
        }
    }
    
    NSString *countstr = INTTOSTRING(count);
    NSString *pricestr =[NSString stringWithFormat:@"%.2f",count * times * [self lotteryprice:pricetype]];
    NSString *maxprice = [NSString stringWithFormat:@"最高可中%.2f元",price];
    success(countstr,pricestr,maxprice);
}

#pragma mark - 获取块的价格，有些选中大、小算两注，价格不增加
-(NSDictionary *)getblockprice:(NSArray *)titeleArray WithblockArr:(NSMutableArray *)blockDataArray With:(NSInteger)pricetype With:(NSInteger)times {
    
    CGFloat price = 0;
    
    NSInteger count = 0;
    
    NSMutableArray *blockDatas = [[NSMutableArray alloc]init];
    
    for (NSArray *array in blockDataArray) {
        
        for (CartSixModel *model in array) {
            
            [blockDatas addObject:model];
        }
        
    }
    int j = 0;
    for (int i = 0; i<blockDatas.count;) {
        
        NSArray *array = [blockDatas subarrayWithRange:NSMakeRange(i, [titeleArray[j]count])];
        
        i+= [titeleArray[j]count];
        
        j++;
        
        CGFloat blockprice = 0;
        
        for (CartSixModel *m in array) {
            
            if (m.select) {
                
                count++;
                
                blockprice = m.odds.floatValue * times * [self lotteryprice:pricetype];
            }
        }
        
        price += blockprice;
    }
    
    return @{@"price":@(price),@"count":@(count)};
}

#pragma mark - 六合彩购买 cart = no:立即购买/cart = yes:加入购彩篮，
-(void)publishsixlotteryData:(BOOL)cart With:(CartTypeModel *)selectModel WithballArr:(NSMutableArray *)ballDataArray WithblockArr:(NSMutableArray *)blockDataArray Withblock2Arr:(NSMutableArray *)block2DataArray WithdatasourceArr:(NSMutableArray *)dataSource Withodds:(NSArray *)oddsArray WithcartArr:(NSMutableArray *)cartArray With:(NSInteger)pricetype With:(NSInteger)times With:(NSInteger)zhengma_type With:(NSInteger)color_type Withcount:(NSInteger)count success:(void (^)(NSArray*dataArray))success{
    
    /*
     1：特码A-------------- 297
     2：特码B-------------- 313
     3：正码A--------------298
     4：正码B--------------321
     6：正特1--------------300
     7：正特2--------------328
     8：正特3--------------330
     9：正特4--------------332
     10：正特5-------------333
     11：正特6-------------334
     */
    if (selectModel.ID == 297 || selectModel.ID == 313 || selectModel.ID == 298 || selectModel.ID == 321 || selectModel.ID == 300 || selectModel.ID == 328 || selectModel.ID == 330 || selectModel.ID == 332 || selectModel.ID == 333 || selectModel.ID == 334) {
        
        NSMutableArray *list = [[NSMutableArray alloc]init];
        
        CartOddsModel *odds1 = oddsArray.firstObject;
        
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                NSDictionary *dic1 = [self getsixlistdicWithsettingid:odds1 Withcount:1 Withnumber:model.number With:pricetype With:times];
                
                [list addObject:dic1];
                
                if (cart) {
                    
                    NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
                    [cartdic1 setValue:model.number forKey:@"number"];
                    [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
                    [cartdic1 setValue:@(times) forKey:@"times"];
                    [cartdic1 setValue:@(1) forKey:@"count"];
                    [cartdic1 setValue:selectModel forKey:@"type"];
                    [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
                    [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
                    [cartArray addObject:cartdic1];
                }
            }
        }
        
        CartOddsModel *odds2 = oddsArray.lastObject;
        
        for (NSArray *array in blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    NSDictionary *dic2 = [self getsixlistdicWithsettingid:odds2 Withcount:1 Withnumber:model.number With:pricetype With:times];
                    
                    [list addObject:dic2];
                    
                    if (cart) {
                        
                        NSMutableDictionary *cartdic2 = [[NSMutableDictionary alloc]init];
                        [cartdic2 setValue:model.number forKey:@"number"];
                        [cartdic2 setValue:@(pricetype) forKey:@"pricetype"];
                        [cartdic2 setValue:@(times) forKey:@"times"];
                        [cartdic2 setValue:@(1) forKey:@"count"];
                        [cartdic2 setValue:@(odds2.ID) forKey:@"playId"];
                        [cartdic2 setValue:selectModel forKey:@"type"];
                        [cartdic2 setValue:@(odds2.oddsList.firstObject.settingId) forKey:@"settingId"];
                        [cartArray addObject:cartdic2];
                        
                    }
                }
            }
        }
        
        success(list);
        
    }
    
    //5：正码1-6------------299
    else if (selectModel.ID == 299) {
        
        //NSArray *array = @[@"正码一",@"正码二",@"正码三",@"正码四",@"正码五",@"正码六"];
        NSMutableArray *list = [[NSMutableArray alloc]init];
        
        NSMutableString *string1 = [NSMutableString string];
        
        NSInteger count1 = 0;
        
        for (NSArray *array in blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    if (string1.length) {
                        
                        [string1 appendString:@","];
                    }
                    [string1 appendString:model.number];
                    
                    count1++;
                }
            }
        }
        
        CartOddsModel *odds1 = oddsArray[zhengma_type - 300];
        
        for (NSString *number in [string1 componentsSeparatedByString:@","]) {
            
            NSDictionary *dic1 = [self getsixlistdicWithsettingid:odds1 Withcount:count1 Withnumber:number With:pricetype With:times];
            
            [list addObject:dic1];
        }
        
        if (cart) {
            
            for (NSString *number in [string1 componentsSeparatedByString:@","]) {
                NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
                [cartdic1 setValue:number forKey:@"number"];
                [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
                [cartdic1 setValue:@(times) forKey:@"times"];
                [cartdic1 setValue:@(1) forKey:@"count"];
                [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
                [cartdic1 setValue:selectModel forKey:@"type"];
                [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
                [cartArray addObject:cartdic1];
            }
            
        }
        success(list);
        
    }
    /*
     12：三全中-------------343
     13：三中二-------------345
     14：二全中-------------372
     15：二中特-------------346
     16：特串---------------301
     20：五不中 ------342
     21：六不中--------347
     22：七不中--------348
     23：八不中---------349
     24：九不中---------350
     25：十不中---------351
     */
    else if (selectModel.ID == 343 || selectModel.ID == 345 || selectModel.ID == 346 || selectModel.ID == 372 || selectModel.ID == 301 || selectModel.ID == 342 || (selectModel.ID >= 347 && selectModel.ID <= 351)) {
        
        NSMutableArray *list = [[NSMutableArray alloc]init];
        
        NSMutableString *string1 = [NSMutableString string];
        
        NSInteger count1 = count;
        
        for (CartSixModel *model in ballDataArray) {
            
            if (model.select) {
                
                if (string1.length) {
                    
                    [string1 appendString:@","];
                }
                [string1 appendString:model.number];
            }
        }
        
        CartOddsModel *odds1 = oddsArray.firstObject;
        
        NSDictionary *dic1 = [self getsixlistdicWithsettingid:odds1 Withcount:count1 Withnumber:string1 With:pricetype With:times];
        
        [list addObject:dic1];
        
        if (cart) {
            
            NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
            [cartdic1 setValue:string1 forKey:@"number"];
            [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
            [cartdic1 setValue:@(times) forKey:@"times"];
            [cartdic1 setValue:@(count1) forKey:@"count"];
            [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
            [cartdic1 setValue:selectModel forKey:@"type"];
            [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
            [cartArray addObject:cartdic1];
            
        }
        success(list);
        
    }
    /**
     
     28：六肖连中--------352 不拆
     29：六肖连不中------353 不拆
     30：二连肖（中）-----360 不拆
     31：二连肖（不中）----361 不拆
     32：三连肖（中）------362 不拆
     33：三连肖（不中）-----363 不拆
     34：四连肖（中）------364 不拆
     35：四连肖（不中）-----365 不拆
     36：二连尾（中）-------366 不拆
     37：二连尾（不中）------367 不拆
     38：三连尾（中）-------368 不拆
     39：三连尾（不中）------369 不拆
     40：四连尾（中）-------370 不拆
     41：四连尾（不中）------371 不拆
     
     */
    else if (selectModel.ID == 352 || selectModel.ID == 353 || (selectModel.ID >= 360 && selectModel.ID <= 371)) {
        
        NSMutableArray *list = [[NSMutableArray alloc]init];
        
        NSMutableString *string1 = [NSMutableString string];
        
        NSInteger count1 = 0;
        
        for (CartSixModel *model in dataSource) {
            
            if (model.select) {
                
                if (string1.length) {
                    
                    [string1 appendString:@","];
                }
                if ([model.title containsString:@"尾"]) {
                    
                    [string1 appendString:[model.title substringToIndex:model.title.length-1]];
                }else {
                    [string1 appendString:model.title];
                }
                
                
                count1++;
            }
        }
        CartOddsModel *odds1 = oddsArray.firstObject;
        
        NSDictionary *dic1 = [self getsixlistdicWithsettingid:odds1 Withcount:count Withnumber:string1 With:pricetype With:times];
        
        [list addObject:dic1];
        
        if (cart) {
            
            NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
            [cartdic1 setValue:string1 forKey:@"number"];
            [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
            [cartdic1 setValue:@(times) forKey:@"times"];
            [cartdic1 setValue:@(count) forKey:@"count"];
            [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
            [cartdic1 setValue:selectModel forKey:@"type"];
            [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
            [cartArray addObject:cartdic1];
            
        }
        success(list);
    }
    /**
     17：红波、蓝波、绿波-----302
     18：全尾--------------  303
     19：特尾--------------  341
     26：平特-----------305
     27：特肖-----------306
     43：五行-------------311
     */
    else if (selectModel.ID == 302 || selectModel.ID == 303 || selectModel.ID == 341 || selectModel.ID == 305 || selectModel.ID == 306 || selectModel.ID == 311) {
        
        NSMutableArray *list = [[NSMutableArray alloc]init];
        
        CartOddsModel *odds1 = nil;
        if (selectModel.ID == 302) {
            odds1 = oddsArray[color_type-200];
        }
        else {
            odds1 = oddsArray.firstObject;
        }
        
        for (CartSixModel *model in dataSource) {
            
            if (model.select) {
                
                NSString *string = nil ;
                
                if ([model.title containsString:@"尾"]) {
                    
                    string = [model.title substringToIndex:model.title.length-1];
                }else {
                    string = model.title;
                }
                NSDictionary *dic1 = [self getsixlistdicWithsettingid:odds1 Withcount:1 Withnumber:string With:pricetype With:times];
                
                [list addObject:dic1];
                
                if (cart) {
                    
                    NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
                    [cartdic1 setValue:string forKey:@"number"];
                    [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
                    [cartdic1 setValue:@(times) forKey:@"times"];
                    [cartdic1 setValue:@(1) forKey:@"count"];
                    [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
                    [cartdic1 setValue:selectModel forKey:@"type"];
                    [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
                    [cartArray addObject:cartdic1];
                    
                }
            }
        }
        
        success(list);
        
    }
    
    //42：1-6龙虎----------- 310
    else if (selectModel.ID == 310) {
        
        NSMutableArray *list = [[NSMutableArray alloc]init];
        
        //        NSMutableString *string1 = [NSMutableString string];
        
        //        NSInteger count1 = 0;
        CartOddsModel *odds1 = oddsArray.firstObject;
        
        for (NSArray *array in blockDataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    NSDictionary *dic1 = [self getsixlistdicWithsettingid:odds1 Withcount:1 Withnumber:[NSString stringWithFormat:@"龙:%@", model.number] With:pricetype With:times];
                    
                    [list addObject:dic1];
                    
                    if (cart) {
                        
                        NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
                        [cartdic1 setValue:[NSString stringWithFormat:@"龙:%@", model.number] forKey:@"number"];
                        [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
                        [cartdic1 setValue:@(times) forKey:@"times"];
                        [cartdic1 setValue:@(1) forKey:@"count"];
                        [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
                        [cartdic1 setValue:selectModel forKey:@"type"];
                        [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
                        [cartArray addObject:cartdic1];
                    }
                }
            }
        }
        //
        //        NSMutableString *string2 = [NSMutableString string];
        //
        //        NSInteger count2 = 0;
        
        for (NSArray *array in block2DataArray) {
            
            for (CartSixModel *model in array) {
                
                if (model.select) {
                    
                    NSDictionary *dic2 = [self getsixlistdicWithsettingid:odds1 Withcount:1 Withnumber:[NSString stringWithFormat:@"虎:%@", model.number] With:pricetype With:times];
                    
                    [list addObject:dic2];
                    
                    if (cart) {
                        
                        NSMutableDictionary *cartdic1 = [[NSMutableDictionary alloc]init];
                        [cartdic1 setValue:[NSString stringWithFormat:@"虎:%@", model.number] forKey:@"number"];
                        [cartdic1 setValue:@(pricetype) forKey:@"pricetype"];
                        [cartdic1 setValue:@(times) forKey:@"times"];
                        [cartdic1 setValue:@(1) forKey:@"count"];
                        [cartdic1 setValue:@(odds1.ID) forKey:@"playId"];
                        [cartdic1 setValue:selectModel forKey:@"type"];
                        [cartdic1 setValue:@(odds1.oddsList.firstObject.settingId) forKey:@"settingId"];
                        [cartArray addObject:cartdic1];
                    }
                }
            }
        }
        success(list);
    }
    
}















-(NSDictionary *)getlistdicWithcount:(NSInteger)count Withnumber:(NSString *)str With:(CartTypeModel *)selectModel With:(NSInteger)pricetype With:(NSInteger)times With:(CartChongqinMissModel *)missmodel{
    
    NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
    [listdic setValue:@(selectModel.ID) forKey:@"playId"];
    [listdic setValue:missmodel.play[@"settingId"] forKey:@"settingId"];
    [listdic setValue:@(count) forKey:@"betCount"];
    [listdic setValue:str forKey:@"betNumber"];
    CGFloat amount = times * [self lotteryprice:pricetype] * count;
    [listdic setValue:[NSNumber numberWithFloat:amount] forKey:@"betAmount"];
    
    return listdic;
}

-(NSDictionary *)getsixlistdicWithsettingid:(CartOddsModel *)oddmodel Withcount:(NSInteger)count Withnumber:(NSString *)str With:(NSInteger)pricetype With:(NSInteger)times {
    
    NSMutableDictionary *listdic = [[NSMutableDictionary alloc]init];
    [listdic setValue:@(oddmodel.ID) forKey:@"playId"];
    [listdic setValue:@(oddmodel.oddsList.firstObject.settingId) forKey:@"settingId"];
    [listdic setValue:@(count) forKey:@"betCount"];
    [listdic setValue:str forKey:@"betNumber"];
    CGFloat amount = times * [self lotteryprice:pricetype] * count;
    [listdic setValue:[NSNumber numberWithFloat:amount] forKey:@"betAmount"];
    
    return listdic;
}

#pragma mark - C(m,n)
-(NSInteger)getstep:(NSInteger)m With:(NSInteger)n {
    
    NSInteger x = [self getstep1With:m With:n];
    NSInteger y = [self getstep2With:n];
    
    return x/y;
}

-(NSInteger)getstep1With:(NSInteger)m With:(NSInteger)n {
    
    NSInteger result = m;
    
    for (int i = 1 ;i<n ;i++) {
        
        result *= --m;
    }
    
    return result;
}

-(NSInteger)getstep2With:(NSInteger)n {
    
    NSInteger result = n;
    
    for (NSInteger i = n ; i>2; ) {
        
        result *= --n;
        
        i = n;
    }
    
    return result;
}

#pragma mark - 将文本多个空格转为一个空格
-(NSString *)getmoreblanktoone:(NSString *)text {
    
    //正则表达式替换两个以上的空格为一个空格
    
    NSError *error = nil;
    
    NSString *newtext = text;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s{2,}" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arr = [regex matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    
    arr = [[arr reverseObjectEnumerator] allObjects];
    
    for (NSTextCheckingResult *str in arr) {
        
        newtext = [newtext stringByReplacingCharactersInRange:[str range] withString:@" "];
        
    }
    
    
    NSLog(@"%@", newtext);
    return newtext;
    
}

#pragma mark--纯数字
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**
 pricetype:0 = 100
 1 = 50
 2 = 10
 3 = 2
 4 = 1
 5 = 0.5
 */
-(CGFloat)lotteryprice:(NSInteger)pricetype {
    
    switch (pricetype) {
        case 0:
            return 100;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 10;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0.5;
            break;
    }
}

#pragma mark -判断字符串是否为空
-(BOOL)isEmptyOrNull:(NSString *)str{
    
    if (!str || [str isKindOfClass:[NSNull class]])
    {
        // null object
        return true;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            
            // empty string
            return true;
        }
        else{
            // is neither empty nor null
            return false;
        }
        
    }
}

#pragma mark - 获取投注彩票集合
-(NSMutableArray *)publishlottery:(NSArray *)array {
    
    double time = [[NSDate date] timeIntervalSince1970];
    NSLog(@"开始计算玩法");
    
    if (array.count<2) {
        
        return [NSMutableArray array];
    }
    NSMutableArray * temps = [self getPlayerFirsts:array[0] Twos:array[1]];
    for (int i=2; i<array.count; i++) {
        temps = [self getPlayerFirsts:temps Twos:array[i]];
    }
    
    NSInteger count = temps.count;
    
    double now = [[NSDate date] timeIntervalSince1970];
    NSLog(@"一共有 %ld玩法 耗时:%f",count,now-time);
    NSLog(@"简单计算有 %ld 玩法",(long)[self getCount:array]);
    //    for (NSString *str in temps) {
    //
    //        NSLog(@"投注号码：%@",str);
    //    }
    return temps;
}

//第一种计算
-(NSMutableArray *)getPlayerFirsts:(NSArray *)firsts Twos:(NSArray *)twos{
    NSMutableArray * temps = [[NSMutableArray alloc] init];
    for (NSString * one in firsts) {
        for (NSString * two in twos) {
            
            NSString *centemp = [one stringByAppendingString:two];
            
            [temps addObject:centemp];
        }
    }
    return temps;
}

//第二种计算
-(NSInteger )getCount:(NSArray *)temp{
    NSInteger count = 1;
    for (NSArray * t in temp) {
        count = count*t.count;
    }
    return count;
}
@end
