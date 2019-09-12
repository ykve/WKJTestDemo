//
//  CLGifLoadView.h
//  CLMJRefresh
//
//  Created by Charles on 15/12/18.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CLLoadState){
    CLLoadStateLoading,
    CLLoadStateFinish,
    CLLoadStateFailed
};
typedef void(^RetryBlock)(void);

@interface CLGifLoadView : UIView

@property (assign,nonatomic) CLLoadState state;
@property (copy,nonatomic) RetryBlock retryBlcok;
@property (copy, nonatomic) NSString *loadstring;

-(void)remove;

@end
