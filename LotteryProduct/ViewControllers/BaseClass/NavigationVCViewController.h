//
//  NavigationVCViewController.h
//  searchbar
//
//  Created by Mory on 2017/6/3.
//  Copyright © 2017年 Mory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ATKeyWindow     [[UIApplication sharedApplication] keyWindow]
#define ATNavViewW      [UIScreen mainScreen].bounds.size.width

#define ATAnimationDuration     0.5f
#define ATMinX                  (0.3f * ATNavViewW)

@interface NavigationVCViewController : UINavigationController

/**
 *  If yes, disable the drag back, default no.
 */
@property (nonatomic, assign) BOOL disableDragBack;

-(void)addpang;

-(void)removepang;
@end
