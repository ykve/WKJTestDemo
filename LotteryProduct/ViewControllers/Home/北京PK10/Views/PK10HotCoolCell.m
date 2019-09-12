//
//  PK10HotCoolCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10HotCoolCell.h"

@interface PK10HotCoolCell()

@property (nonatomic, strong)UILabel *titlelab;

@property (nonatomic, strong)PK10HotCoolSubView *hotview;

@property (nonatomic, strong)PK10HotCoolSubView *warmthview;

@property (nonatomic, strong)PK10HotCoolSubView *coolview;

@end

@implementation PK10HotCoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UILabel *)titlelab {
    
    if (!_titlelab) {
        
        _titlelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:WHITE andTextAlignment:1];
        [self.contentView addSubview:_titlelab];
    }
    return _titlelab;
}

-(PK10HotCoolSubView *)hotview {
    
    if (!_hotview) {
        
        _hotview = [[PK10HotCoolSubView alloc]init];
        _hotview.backgroundColor = WHITE;
        [self.contentView addSubview:_hotview];
    }
    return _hotview;
}

-(PK10HotCoolSubView *)warmthview {
    
    if (!_warmthview) {
        
        _warmthview = [[PK10HotCoolSubView alloc]init];
        _warmthview.backgroundColor = WHITE;
        [self.contentView addSubview:_warmthview];
    }
    return _warmthview;
}

-(PK10HotCoolSubView *)coolview {
    
    if (!_coolview) {
        
        _coolview = [[PK10HotCoolSubView alloc]init];
        _coolview.backgroundColor = WHITE;
        [self.contentView addSubview:_coolview];
    }
    return _coolview;
}

-(void)setHotArray:(NSArray *)hotArray {
    
    _hotArray = hotArray;
    
    self.hotview.bgColor = kColor(206, 33, 39);
    
    self.hotview.showcount = self.showcount;
    
    self.hotview.dataArray = hotArray;
    
    [self.hotview setNeedsDisplay];
}

-(void)setWarmthArray:(NSArray *)warmthArray {
    
    _warmthArray = warmthArray;
    
    self.warmthview.bgColor = kColor(250, 103, 10);
    
    self.warmthview.showcount = self.showcount;
    
    self.warmthview.dataArray = warmthArray;
    
    [self.warmthview setNeedsDisplay];
}

-(void)setCoolArray:(NSArray *)coolArray {
    
    _coolArray = coolArray;
    
    self.coolview.bgColor = kColor(49, 131, 228);
    
    self.coolview.showcount = self.showcount;
    
    self.coolview.dataArray = coolArray;
    
    [self.coolview setNeedsDisplay];
}

-(void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titlelab.text = title;
}

-(void)layoutSubviews {
    
    [self.titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-1);
        make.width.equalTo(@(SCREEN_WIDTH * 0.16));
    }];
    
    [self.hotview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.titlelab.mas_right).offset(1);
        make.bottom.equalTo(self.contentView).offset(-1);
        make.width.equalTo(@(SCREEN_WIDTH * 0.28));
    }];
    
    [self.warmthview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.hotview.mas_right).offset(1);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
    [self.coolview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self.contentView);
        make.left.equalTo(self.warmthview.mas_right).offset(1);
        make.bottom.equalTo(self.contentView).offset(-1);
        make.width.equalTo(@(SCREEN_WIDTH * 0.28));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
