//
//  WB_Stopwatch.h
//  Stopwatch
//
//  Created by Transuner on 16/4/28.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WB_StopwatchLabelType){
    WBTypeStopWatch,
    WBTypeTimer
};
@class WB_Stopwatch;
@protocol WB_StopWatchDelegate <NSObject>

@optional

-(void)timerLabel:(WB_Stopwatch*)timerLabel
finshedCountDownTimerWithTime:(NSTimeInterval)countTime;

-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType;

@end

@interface WB_Stopwatch : UILabel

@property (assign,readonly) BOOL counting;
@property (nonatomic, assign) BOOL resetTimerAfterFinish;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) NSString * timeFormat;

//@property (nonatomic, strong) NSDate * timeToShow;

@property (nonatomic, assign) NSTimeInterval startTimeInterval;

//@property (nonatomic, strong) NSDate * startCountDate;

@property (nonatomic, assign) WB_StopwatchLabelType stopwatchLabelType;

@property (nonatomic, strong) id<WB_StopWatchDelegate>delegate;

- (instancetype) initWithLabel:(UILabel *)anLabel
                  andTimerType:(WB_StopwatchLabelType)anType;

-(void)start;
#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))end;
#endif

//-(void)pause;
-(void)reset;

-(void)setCountDownTime:(NSTimeInterval)time;
-(void)setStartime:(NSTimeInterval)star StopWatchTime:(NSTimeInterval)time;

@end
