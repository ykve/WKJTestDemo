//
//  SQMenuShowCell.h
//  JHTDoctor
//
//  Created by yangsq on 16/9/22.
//  Copyright © 2016年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol showmissDelegate;
@interface SQMenuShowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textTitle;
@property (weak, nonatomic) IBOutlet UISwitch *missswitch;
@property (assign, nonatomic) id<showmissDelegate>delegate;
@end

@protocol showmissDelegate

-(void)showmiss:(BOOL)show;

@end
