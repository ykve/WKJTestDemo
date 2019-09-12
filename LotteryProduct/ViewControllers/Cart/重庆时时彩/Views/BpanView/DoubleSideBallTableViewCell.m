//
//  DoubleSideBallTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "DoubleSideBallTableViewCell.h"
#import "CartCQModel.h"
#import "UIImage+color.h"

@implementation DoubleSideBallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UILabel *lbl in self.peiLvLabels) {
        lbl.font = [UIFont systemFontOfSize:14];
        lbl.textColor = [UIColor lightGrayColor];
    }
    
    for (UILabel *lbl in self.ballLabels) {
        lbl.font = [UIFont systemFontOfSize:16];
        lbl.textColor = [UIColor colorWithHex:@"333333"];
    }
    
    for (UIButton *btn in self.numberBtns) {
        
//        btn.layer.borderColor = [UIColor colorWithHex:@"f1d6a4"].CGColor;
//        btn.layer.borderWidth = 1.0;
//        btn.backgroundColor = [UIColor colorWithHex:@"2C3036"];
        btn.tintColor = [UIColor clearColor];
        
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"2C3036"] size:btn.size] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"9C2D33"] size:btn.size] forState:UIControlStateSelected];;

        
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//
//        for (UILabel *lbl in self.peiLvLabels) {
//            lbl.font = [UIFont systemFontOfSize:14];
//            lbl.textColor = [UIColor lightGrayColor];
//        }
//
//        for (UILabel *lbl in self.ballLabels) {
//            lbl.font = [UIFont systemFontOfSize:16];
//            lbl.textColor = [UIColor colorWithHex:@"333333"];
//        }
//
//        for (UIButton *btn in self.numberBtns) {
//
//            //        btn.layer.borderColor = [UIColor colorWithHex:@"f1d6a4"].CGColor;
//            //        btn.layer.borderWidth = 1.0;
//            //        btn.backgroundColor = [UIColor colorWithHex:@"2C3036"];
//            btn.tintColor = [UIColor clearColor];
//
//            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"2C3036"] size:btn.size] forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"9C2D33"] size:btn.size] forState:UIControlStateSelected];;
//
//
//        }
    }
    return self;
}

- (void)setItemModels:(NSArray *)itemModels{
    
    _itemModels = itemModels;
    
    for (CartCQModel *model in self.itemModels) {
        
        for (UIButton *btn in self.numberBtns) {
            if ([model.ID intValue] == btn.tag) {
                btn.selected = model.selected;
            }
        }
        
    }
}

- (IBAction)selectBalls:(UIButton *)sender {
    sender.selected = sender.selected ? NO : YES;

    if (sender.selected) {
        
        sender.backgroundColor = [UIColor colorWithHex:@"9C2D33"];

        for (UILabel *lbl in self.ballLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectBigSmallLabelArray addObject:lbl];
            }
        }
        
    }else{
        
        for (UILabel *lbl in self.ballLabels) {
            if (lbl.tag == sender.tag) {
                [self.selectBigSmallLabelArray removeObject:lbl];
            }
        }
        
        sender.backgroundColor = [UIColor colorWithHex:@"2C3036"];

    }
    
    for (CartCQModel *model in self.itemModels) {
        
        NSLog(@"%@,======%ld", model.ID, (long)sender.tag);

        if ([model.ID intValue] == sender.tag) {
            model.selected = sender.selected;
        }
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"doubleSideSelectOtherBall" object:self.selectBigSmallLabelArray];

}


- (NSMutableArray *)selectBigSmallLabelArray{
    if (!_selectBigSmallLabelArray) {
        _selectBigSmallLabelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectBigSmallLabelArray;
}

@end
