//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSString *methodName;

@property (nonatomic, copy)void (^selectBlock) (NSString *selectString,NSInteger index);

-(void)hideDropDown:(UIButton *)b;

- (id)initWithshowDropDown:(UIButton *)button Withheigh:(CGFloat )height Withlist:(NSArray *)arr;

@end
