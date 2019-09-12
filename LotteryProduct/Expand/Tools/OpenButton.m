//
//  OpenButton.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/5/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "OpenButton.h"
#import "UIImage+GIF.h"

@interface OpenButton(){
    UIImageView *_openGif;
}
@end

@implementation OpenButton


- (void)showOpenGif{
    if(!_openGif){
        _openGif = [[UIImageView alloc] initWithFrame:self.bounds];
        NSString *gifName = @"sscOpen";
        switch (self.type) {
            case CPTOpenButtonType_LHCBall:
                gifName = @"openLHC";
                break;
            case CPTOpenButtonType_RedBall:
                gifName = @"sscOpen";
                break;
            case CPTOpenButtonType_BludBall:
                gifName = @"openBlue";
                break;

                
            default:
                break;
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
        NSData * imageData = [NSData dataWithContentsOfFile:path];
        UIImage  *image=[UIImage sd_animatedGIFWithData:imageData];
        _openGif.image = image;
        [self addSubview:_openGif];
    }
}

- (void)dismissOpenGif{
    if(_openGif){
        @weakify(self)
        [UIView animateWithDuration:0.5 animations:^{
            @strongify(self)
            self->_openGif.alpha = 0.0;
        }completion:^(BOOL finished) {
            @strongify(self)
            [self->_openGif removeFromSuperview];
            _openGif = nil;
        }];
       
    }
}

@end
