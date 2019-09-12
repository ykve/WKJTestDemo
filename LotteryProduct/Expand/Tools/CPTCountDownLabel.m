
//
//  CPTCountDownLabel.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/4/19.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTCountDownLabel.h"

@implementation CPTCountDownLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setText:(NSString *)text{//00:00:00
    NSString * tmpS = text;
    if(text.length==8){
        NSString * bStr = [tmpS substringWithRange: NSMakeRange(0, 3)];
        if([bStr isEqualToString:@"00:"]){
            self.font = BOLDFONT(25);
            tmpS = [tmpS substringWithRange: NSMakeRange(3, 5)];
        }else{
            self.font = BOLDFONT(20);
        }
    }
    [super setText:tmpS];
}

@end
