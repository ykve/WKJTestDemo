//
//  PK10HotCoolSubView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10HotCoolSubView.h"

@implementation PK10HotCoolSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
}

-(void)drawRect:(CGRect)rect {
    
    for (int i = 0; i<self.dataArray.count; i++) {
        
        NSDictionary *dic = [self.dataArray objectAtIndex:i];
        
        NSString *text = dic[@"type"];
        
        NSString *count = [NSString stringWithFormat:@"%@",dic[@"num"]];
        
        NSInteger col = i % 4;
        NSInteger row = i / 4;
        CGFloat textw = rect.size.width/5 - 2;
        CGFloat texth = rect.size.width/5 - 2;
        CGFloat textx = col * (textw + 5) + 5;
        CGFloat texty = row * (texth + 15) + 5;
        
        UILabel *lab = [self viewWithTag:100+i];
        
        if (lab == nil) {
         
            lab = [Tools createLableWithFrame:CGRectMake(textx, texty, textw, texth) andTitle:text andfont:FONT(12) andTitleColor:WHITE andBackgroundColor:self.bgColor andTextAlignment:1];
            lab.tag = 100 + i;
            lab.layer.cornerRadius = textw/2;
            lab.layer.masksToBounds = YES;
            [self addSubview:lab];
        }
        
        lab.text = text;
        
//        CGRect textrect = CGRectMake(textx, texty, textw, texth);
//
//        // 创建画布
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        // 设置填充色
//        CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
//        // 圆形直径
//        CGFloat w = MIN(textrect.size.width, textrect.size.height);
//        // 园点坐标
//        CGPoint center = CGPointMake(textrect.origin.x + textrect.size.width / 2.0,
//                                     textrect.origin.y + textrect.size.height / 2.0);
//
//        CGContextAddArc(context, center.x, center.y, w / 2.0, 0 , 2 * M_PI, 0);
//        CGContextDrawPath(context, kCGPathFill);
//        [text drawInRect:CGRectMake(textx + (text.integerValue == 10 ? textw/4 : textw/4 + 1), texty + texth/4 - 2, textw, texth) withAttributes:@{NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:WHITE}];
        
        [count drawInRect:CGRectMake(textx + textw/4, texty + texth, textw, 10) withAttributes:@{NSFontAttributeName:FONT(9),NSForegroundColorAttributeName:self.showcount==YES ? [UIColor lightGrayColor] : CLEAR}];
    }
    
}



@end
