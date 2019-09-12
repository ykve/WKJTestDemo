//
//  CQOneToFiveTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CQOneToFiveTableViewCell.h"
#import "UIImage+color.h"


@interface CQOneToFiveTableViewCell()

@property (nonatomic, strong) NSMutableArray *selectedBalls;


@end

@implementation CQOneToFiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatSubViews];
    }
    
    return self;
    
}

- (void)creatSubViews{
    
    int itemNum = 10;
    
    CGFloat margin = 15;
    CGFloat w = (self.width - 7 * margin)/5;
    CGFloat h = 100;
    
    for (int i = 0; i < itemNum; i ++) {
        
        CGFloat x = margin + (w + margin)*(i%5);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, (i/5) * h , w, h)];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.width, view.width)];
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        UIImage *normalImage = [UIImage imageWithColor:[UIColor colorWithHex:@"2C3036"] size:btn.size];
        UIImage *selectImage = [UIImage imageWithColor:[UIColor colorWithHex:@"9C2D33"] size:btn.size];

        
        [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImage forState:UIControlStateSelected];

        
        btn.backgroundColor = [UIColor colorWithHex:@"FDFBF4"];
        btn.layer.cornerRadius = btn.width/2;
        btn.layer.masksToBounds = YES;
//        btn.layer.borderWidth = 1;
//        btn.layer.borderColor = [UIColor colorWithHex:@"f6d79e"].CGColor;
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectBall:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        [self addSubview:view];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame) + 10, btn.width, 20)];
        label.text = @"9.99";
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        [view addSubview:label];
        

    }
}

- (void)selectBall:(UIButton *)sender{
    
    sender.selected = sender.selected ? NO : YES;
    
    if (sender.selected) {
        [self.selectedBalls addObject:sender];
    }else{
        [self.selectedBalls removeObject:sender];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ontToFiveSelectOtherBalls" object:self.selectedBalls];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSMutableArray *)selectedBalls{
    if (!_selectedBalls) {
        _selectedBalls = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectedBalls;
}

@end
