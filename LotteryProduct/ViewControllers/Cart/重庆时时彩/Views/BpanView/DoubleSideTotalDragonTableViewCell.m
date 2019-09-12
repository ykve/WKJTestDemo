//
//  DoubleSideTotalDragonTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "DoubleSideTotalDragonTableViewCell.h"
#import "UIImage+color.h"

@implementation DoubleSideTotalDragonTableViewCell


- (void)setOddModel:(CartOddsModel *)oddModel{
    _oddModel = oddModel;
    for (UILabel *lbl in self.peiLvLabels) {
        
        for (OddsList *listModel in oddModel.oddsList) {
            if ([listModel.name isEqualToString:@""]) {
                lbl.text = [NSString stringWithFormat:@"%@", listModel.odds];
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIButton *btn in self.numberBtns) {
      
//        btn.backgroundColor = [UIColor colorWithHex:@"2C3036"];
        btn.tintColor = [UIColor clearColor];
        
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"2C3036"] size:btn.size] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"9C2D33"] size:btn.size] forState:UIControlStateSelected];

    }
    
    for (UILabel *lbl in self.peiLvLabels) {
        lbl.font = [UIFont systemFontOfSize:14];
        lbl.textColor = [UIColor lightGrayColor];
    }
    
    for (UILabel *lbl in self.ballLabels) {
        lbl.font = [UIFont systemFontOfSize:16];
        lbl.textColor = [UIColor whiteColor];
    }
    
    for (UIView *view in self.numberBackViews) {
        view.backgroundColor = [UIColor colorWithHex:@"2C3036"];
    }

}

- (void)setItemModels:(NSArray *)itemModels{
    
    for (CartCQModel *model in self.itemModels) {
        
        for (UIButton *btn in self.numberBtns) {
            
            NSLog(@"%@,======%ld", model.ID, (long)btn.tag);

            if ([model.ID intValue] == btn.tag) {
                btn.selected = model.selected;
            }
        }
       
    }
}

- (IBAction)selectBalls:(UIButton *)sender {
    
    sender.selected = sender.selected ? NO : YES;
 
    if (sender.selected) {
        
        for (UILabel *lbl in self.ballLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectTotalDragonLabelArray addObject:lbl];
            }
        }

//        for (CartCQModel *model in self.itemModels) {
//            if ([model.ID intValue] == sender.tag) {
//                model.selected = YES;
//            }
//        }
//        sender.backgroundColor = [UIColor colorWithHex:@"9C2D33"];
        
    }else{
        
        for (UILabel *lbl in self.ballLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectTotalDragonLabelArray removeObject:lbl];
            }
        }
//
//        for (CartCQModel *model in self.itemModels) {
//            if ([model.ID intValue] == sender.tag) {
//                model.selected = NO;
//            }
//        }
        
//        sender.backgroundColor = [UIColor colorWithHex:@"2C3036"];

    }
    
    for (CartCQModel *model in self.itemModels) {
        if ([model.ID intValue] == sender.tag) {
            model.selected = sender.selected;
        }
    }

    [[NSNotificationCenter defaultCenter]postNotificationName:@"doubleSideSelectTotalDragnBall" object:self.selectTotalDragonLabelArray];

}

- (NSMutableArray *)selectTotalDragonLabelArray{
    if (!_selectTotalDragonLabelArray) {
        _selectTotalDragonLabelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectTotalDragonLabelArray;
}

@end
