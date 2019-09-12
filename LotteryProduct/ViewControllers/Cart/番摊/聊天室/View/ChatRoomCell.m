//
//  ChatRoomCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/5/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ChatRoomCell.h"

@implementation ChatRoomCell
{
    ChatMessageModel *_model;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *img = [UIImage imageNamed:@"chatMessage_left"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    self.contentBgImgView.image = img;
}
- (void)setDataWithModel:(ChatMessageModel *)model{
    _model = model;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    self.nameLabel.text = model.nickname;
    NSString *imgName = [NSString stringWithFormat:@"vip_chat_v%@",model.level.length?model.level:@"0"];
    if(model.userType.integerValue == 1){//管理员
        self.glyWidth.constant = 25;
        self.levelWidth.constant = 0;
        self.nameLabel.textColor = [UIColor colorWithHex:@"A07B50"];
    }else if (model.userType.integerValue == 0){//普通用户
        self.glyWidth.constant = 0;
        self.levelWidth.constant = 25;
        self.nameLabel.textColor = [UIColor colorWithHex:@"999999"];
    }
    self.levelImgView.image = IMAGE(imgName);
    
    if(model.type == 0){
        self.focusBtn.hidden = YES;
    }else{
        self.focusBtn.hidden = NO;
        self.focusBtn.selected = model.isFollow.integerValue == 1?YES:NO;
    }
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:kChatFont]};
    CGSize size = [model.content sizeWithAttributes:attributes ];
//    MBLog(@"===%f",SCREEN_WIDTH);
    if(size.width>SCREEN_WIDTH-80){
        size.width = SCREEN_WIDTH-80;
    }
    if (size.width<kChatMiniHeight){
        size.width = kChatMiniHeight;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    _contentLabel.font = [UIFont systemFontOfSize:kChatFont];
    CGSize baseSize = CGSizeMake(size.width, 100);
    CGSize labelsize  = [model.content
                         boundingRectWithSize:baseSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kChatFont]}
                         context:nil].size;
    if(labelsize.height<kChatMiniHeight){
        labelsize.height = kChatMiniHeight;
    }
    self.contentBgImgView.frame = CGRectMake(54, 27, baseSize.width+8, labelsize.height+10);
    self.contentLabel.frame = CGRectMake(59, 31, baseSize.width, labelsize.height);

    self.contentLabel.text = model.content;
    
}
- (IBAction)focusClick:(UIButton *)sender {
//    MBLog(@"=====");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
