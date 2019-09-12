//
//  LiuHeTuKuRemarkTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuRemarkTableViewCell.h"

@interface LiuHeTuKuRemarkTableViewCell ()

@property (strong, nonatomic)  UIImageView *icon;
@property (strong, nonatomic)  UILabel *nicknameLbl;
@property (strong, nonatomic)  UILabel *timeLbl;
@property (strong, nonatomic)  UILabel *commentLbl;

@property (strong, nonatomic)  UIView *toplineView;
@property (strong, nonatomic)  UIView *line1View;
@property (strong, nonatomic)  UILabel *headTitleLabel;
@property (strong, nonatomic)  UIView *line2View;

@end

@implementation LiuHeTuKuRemarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    LiuHeTuKuRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LiuHeTuKuRemarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    UIView *toplineView = [[UIView alloc] init];
    toplineView.backgroundColor = [UIColor colorWithHex:@"#f0f2f5"];
    toplineView.hidden = YES;
    [self addSubview:toplineView];
    _toplineView = toplineView;
    
    [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(8);
    }];
    
    
    UILabel *headTitleLabel = [[UILabel alloc] init];
    headTitleLabel.text = @"评论区";
    headTitleLabel.font = [UIFont systemFontOfSize:15];
    headTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    headTitleLabel.textAlignment = NSTextAlignmentCenter;
    headTitleLabel.hidden = YES;
    [self addSubview:headTitleLabel];
    _headTitleLabel = headTitleLabel;
    
    [headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(20);
    }];
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    line1View.hidden = YES;
    [self addSubview:line1View];
    _line1View = line1View;
    
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headTitleLabel.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(headTitleLabel.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    line2View.hidden = YES;
    [self addSubview:line2View];
    _line2View = line2View;
    
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headTitleLabel.mas_centerY);
        make.left.mas_equalTo(headTitleLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"QQ"];
    [self addSubview:icon];
    _icon = icon;
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *nicknameLbl = [[UILabel alloc] init];
    nicknameLbl.text = @"-";
    nicknameLbl.font = [UIFont systemFontOfSize:13];
    nicknameLbl.textColor = [UIColor colorWithHex:@"#333333"];
    nicknameLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nicknameLbl];
    _nicknameLbl = nicknameLbl;
    
    [nicknameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(icon.mas_top).offset(3);
        make.left.mas_equalTo(icon.mas_right).offset(10);
    }];
    
    UILabel *timeLbl = [[UILabel alloc] init];
    timeLbl.text = @"-";
    timeLbl.font = [UIFont systemFontOfSize:10];
    timeLbl.textColor = [UIColor colorWithHex:@"#999999"];
    timeLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:timeLbl];
    _timeLbl = timeLbl;
    
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.centerY.mas_equalTo(nicknameLbl.mas_centerY);
    }];
    
    UILabel *commentLbl = [[UILabel alloc] init];
    commentLbl.text = @"-";
    commentLbl.font = [UIFont systemFontOfSize:13];
    commentLbl.textColor = [UIColor colorWithHex:@"#666666"];
    commentLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:commentLbl];
    _commentLbl = commentLbl;
    
    [commentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nicknameLbl.mas_bottom).offset(5);
        make.left.mas_equalTo(nicknameLbl.mas_left);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];

}

- (void)setIsFirst:(BOOL)isFirst {
    _isFirst = isFirst;
    
    if (self.isFirst) {
        self.toplineView.hidden = NO;
        self.line1View.hidden = NO;
        self.headTitleLabel.hidden = NO;
        self.line2View.hidden = NO;
        
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(45);
        }];
    } else {
        self.toplineView.hidden = YES;
        self.line1View.hidden = YES;
        self.headTitleLabel.hidden = YES;
        self.line2View.hidden = YES;
        
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(15);
        }];
    }
}

- (void)setModel:(LiuHeTKRemarkModel *)model{
    _model = model;

    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:IMAGE(@"头像")];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.width/2;
    self.nicknameLbl.text = model.name;
    self.timeLbl.text = model.time;
    self.commentLbl.text = model.content;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
