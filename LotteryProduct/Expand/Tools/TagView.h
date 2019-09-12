//
//  TagView.h
//  CustomTag
//
//  Created by za4tech on 2017/12/15.
//  Copyright © 2017年 Junior. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTypeModel.h"
@protocol TagViewDelegate;
@interface TagView : UIView

@property (nonatomic ,weak)id <TagViewDelegate>delegate;

@property (nonatomic ,strong)NSArray<CartTypeModel *> * arr;

-(void)clickTo:(UIButton *)sender;

@end
@protocol TagViewDelegate <NSObject>

@optional

-(void)handleSelectWith:(CartTypeModel *)typemodel WithView:(TagView *)view;

@end
