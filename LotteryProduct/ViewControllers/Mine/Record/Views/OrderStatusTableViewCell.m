//
//  OrderStatusTableViewCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "OrderStatusTableViewCell.h"

@interface OrderStatusTableViewCell ()
///
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titTextLabel;

@end

@implementation OrderStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    OrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OrderStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"-";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor colorWithHex:@"#666666"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    
    UILabel *titTextLabel = [[UILabel alloc] init];
    titTextLabel.text = @"-";
    titTextLabel.font = [UIFont systemFontOfSize:13];
    titTextLabel.textColor = [UIColor colorWithHex:@"#1D1E24"];
    titTextLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:titTextLabel];
    _titTextLabel = titTextLabel;
    
    [titTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-15);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    [self addSubview:lineView];
    _lineView = lineView;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(0.8);
    }];
    
    
}

- (void)setModel:(id)model {
    _model = model;
    if ([model isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)model;
        _titleLabel.text = dict[@"title"];
        NSString *text = dict[@"text"];
        if (text.length == 0) {
            text = @"-";
        }
        _titTextLabel.text = text;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
