//
//  ChatRoomCell_right.m
//  LotteryProduct
//
//  Created by pt c on 2019/5/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ChatRoomCell_right.h"

@implementation ChatRoomCell_right

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDataWithModel:(ChatMessageModel *)model{
    UIImage *img = [UIImage imageNamed:@"chatMessage_right"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    self.contentBgImgView.image = img;
    _nameLabel.text = model.nickname;
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:kChatFont] };
    CGSize size = [model.content sizeWithAttributes:attributes ];
//    MBLog(@"===%f",SCREEN_WIDTH);
    if(size.width>SCREEN_WIDTH-80){
        size.width = SCREEN_WIDTH-80;
    }
    if (size.width<30){
        size.width = 30;
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
    self.contentBgImgView.frame = CGRectMake(SCREEN_WIDTH-60-(baseSize.width+4), 26, baseSize.width+8, labelsize.height+10);
    self.contentLabel.frame = CGRectMake(SCREEN_WIDTH-60-baseSize.width, 30, baseSize.width, labelsize.height);
    _contentLabel.text = model.content;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"mrtx"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
