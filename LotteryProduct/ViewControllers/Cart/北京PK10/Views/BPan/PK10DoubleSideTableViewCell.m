//
//  PK10DoubleSideTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/31.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "PK10DoubleSideTableViewCell.h"
#import "BpanButton.h"

@implementation PK10DoubleSideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        BpanButton *btn = [[BpanButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        
        [self.contentView addSubview:btn];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        BpanButton *btn = [[BpanButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        
        [self.contentView addSubview:btn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
