//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation NIDropDown
@synthesize table;
@synthesize btnSender;
@synthesize list;


- (id)initWithshowDropDown:(UIButton *)button Withheigh:(CGFloat )height Withlist:(NSArray *)arr {
    
    btnSender = button;
    
    self = [super init];
    if (self) {
        // Initialization code
        CGRect btn = button.frame;
        
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
        self.list = [NSArray arrayWithArray:arr];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, height)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.backgroundColor = [UIColor whiteColor];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
        
        [self addSubview:table];
        
        _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = [UIColor clearColor];
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
        CGRect rect = [button convertRect:button.bounds toView:keywindw];
        self.frame = CGRectMake(btn.origin.x, rect.origin.y + rect.size.height, btn.size.width, height);
        [keywindw addSubview:_overlayView];
        [keywindw addSubview:self];
        
        
    }
    return self;
}

-(void)dismiss {
    
    [self hideDropDown:btnSender];
}

-(void)hideDropDown:(UIButton *)b {
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    CGRect rect = [b convertRect:b.bounds toView:keywindw];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height, rect.size.width, 0);
        
        table.frame = CGRectMake(0, 0, rect.size.width, 0);
        
    } completion:^(BOOL finished) {
        
        btnSender.selected = NO;
        
        [self removeFromSuperview];
        
        [self.overlayView removeFromSuperview];
        
        [table removeFromSuperview];
        
    }];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.list count];
}   


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
       
    }
    
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"help_unselect"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"help_select"] forState:UIControlStateSelected];
//    btn.frame = CGRectMake(0, 0, 15, 15);
//    cell.accessoryView = btn;
//    if([cell.textLabel.text isEqualToString:btnSender.titleLabel.text]){
//        
//        btn.selected = YES;
//    }
//    else{
//        btn.selected = NO;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [btnSender setTitle:[list objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    if(self.selectBlock){
        
        self.selectBlock([list objectAtIndex:indexPath.row],indexPath.row+1);
    }
    [self hideDropDown:btnSender];
}


@end
