//
//  ExpertListCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ExpertListCell.h"

@interface ExpertListCell ()

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UILabel *moneyLabel;

@property (strong, nonatomic) UILabel *ranknumlab;
@property (strong, nonatomic) UILabel *oddslab;

@end

@implementation ExpertListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    ExpertListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ExpertListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"头像"];
    headImageView.layer.cornerRadius = 45/2;
    headImageView.layer.masksToBounds = YES;
    [self addSubview:headImageView];
    _headImageView = headImageView;
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(45);
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"-";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor colorWithHex:@"#333333"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_top).offset(2);
        make.left.mas_equalTo(headImageView.mas_right).offset(10);
    }];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"-";
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.textColor = [UIColor colorWithHex:@"#888888"];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:typeLabel];
    _typeLabel = typeLabel;
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_left);
        make.bottom.mas_equalTo(headImageView.mas_bottom).offset(-2);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"-";
    moneyLabel.font = [UIFont systemFontOfSize:12];
    moneyLabel.textColor = [UIColor colorWithHex:@"#BB2A2A"];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:moneyLabel];
    _moneyLabel = moneyLabel;

    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(typeLabel.mas_centerY);
        make.left.mas_equalTo(typeLabel.mas_right).offset(2);
    }];
    
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"-" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHex:@"#FF840C"] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 2;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = [UIColor colorWithHex:@"#FF840C"].CGColor;
    
    [cancelBtn setTitle:@"关注" forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消关注" forState:UIControlStateSelected];
    
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    [self addSubview:lineView];
//    _lineView = lineView;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(0.8);
    }];
    
    
}

- (void)setModel:(id)model {
    _model = model;

    if ([model isKindOfClass:[ExpertModel class]]) {
       ExpertModel *exModel = (ExpertModel *)model;
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:exModel.heads] placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
        self.nameLabel.text = exModel.nickname;

        //        cell.oddslab.text = model.showRate;
        
//        self.typeLabel.text = @"累计中奖：";
//        self.moneyLabel.text = [NSString stringWithFormat:@"%@元", exModel.totalMoney];
        self.cancelBtn.selected = exModel.isFocus;
        
        
        switch (self.nameType) {
            case 1://盈利率
            {
                self.typeLabel.text = @"盈利率:";
                self.moneyLabel.text = exModel.showRate;
            }break;
            case 2://胜率
            {
                self.typeLabel.text = @"胜率:";
                self.moneyLabel.text = exModel.showRate;
            }break;
            case 3://连中
            {
                self.typeLabel.text = @"连中:";
                self.moneyLabel.text = exModel.showRate;
            }break;
            case 4://我的关注
            {
                self.typeLabel.text = @"累计中奖:";
                self.moneyLabel.text = [NSString stringWithFormat:@"%@元", exModel.totalMoney];
            }break;
                
            default:
                break;
        }
    }

}



- (void)cancelBtnAction:(UIButton *)sender {
    if (self.attentionBlock) {
        self.attentionBlock(sender);
    }
}

-(void)setDataWithModel:(ExpertModel *)model{
    switch (self.nameType) {
        case 1://盈利率
        {
            self.typeLabel.text = @"盈利率:";
            self.moneyLabel.text = [NSString stringWithFormat:@"%@%@",model.totalMoney,@"%"];
        }break;
        case 2://胜率
        {
            self.typeLabel.text = @"胜率:";
            self.moneyLabel.text = [NSString stringWithFormat:@"%@%@",model.totalMoney,@"%"];
        }break;
        case 3://连中
        {
            self.typeLabel.text = @"连中:";
            self.moneyLabel.text = model.showRate;
        }break;
        case 4://我的关注
        {
            self.typeLabel.text = @"累计中奖:";
            self.moneyLabel.text = model.totalMoney;
        }break;
            
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
