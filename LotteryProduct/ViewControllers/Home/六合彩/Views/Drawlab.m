//
//  Drawlab.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "Drawlab.h"

@implementation Drawlab

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{

    // 创建画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置填充色
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    // 圆形直径
    CGFloat w = MIN(self.frame.size.width, self.frame.size.height)-2;
    // 园点坐标
    CGPoint center = CGPointMake(self.bounds.origin.x + self.frame.size.width / 2.0,
                                 self.bounds.origin.y + self.frame.size.height / 2.0);
    
    if (self.showbg) {
        
        CGContextAddArc(context, center.x, center.y, w / 2.0, 0 , 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathFill);
        [self drawShowTextWithcolor:self.textColor];
    }
    else {
        [self drawShowTextWithcolor:self.textColor];
    }
    
}

// 绘制文字
- (void)drawShowTextWithcolor:(UIColor *)color{
    
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGRect textRect = CGRectMake((self.frame.size.width - textSize.width) / 2.0, (self.frame.size.height - textSize.height) / 2.0, self.frame.size.width, self.frame.size.height);
    [self.text drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
}

@end
