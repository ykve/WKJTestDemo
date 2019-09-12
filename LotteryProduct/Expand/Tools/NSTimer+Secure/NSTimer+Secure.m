//
//  NSTimer+Secure.m
//  demo
//
//  Created by winter on 2015/3/23.
//  Copyright © 2015年 wd. All rights reserved.
//

#import "NSTimer+Secure.h"

@interface SeTimerTarget: NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, copy) void(^block)(void);
@end

@implementation SeTimerTarget
- (void)seTimerTargetAction:(NSTimer *)timer {
    if (self.target) {
        IMP imp = [self.target methodForSelector:self.selector];
        void (*func)(id, SEL, NSTimer*) = (void *)imp;
        func(self.target, self.selector, timer);
    }
    else {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)seTimerBlockAction:(NSTimer *)timer {
    if (self.target && self.block) {
        self.block();
    }
    else {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    NSLog(@"==== timer dealloc ====");
}
@end

@implementation NSTimer (Secure)

+ (instancetype)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector {
    return [self seScheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector repeats:YES];
}

+ (instancetype)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo {
    SeTimerTarget *timerTarget = [[SeTimerTarget alloc] init];
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:timerTarget selector:@selector(seTimerTargetAction:) userInfo:nil repeats:yesOrNo];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:timerTarget.timer forMode:NSDefaultRunLoopMode];
    return timerTarget.timer;
}

+ (instancetype)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget block:(void (^)(void))block {
    return [self seScheduledTimerWithTimeInterval:ti target:aTarget repeats:YES block:block];
}

+ (instancetype)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget repeats:(BOOL)yesOrNo block:(void (^)(void))block {
    SeTimerTarget *timerTarget = [[SeTimerTarget alloc] init];
    timerTarget.block = block;
    timerTarget.target = aTarget;
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:timerTarget selector:@selector(seTimerBlockAction:) userInfo:nil repeats:yesOrNo];
    timerTarget.timer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:timerTarget.timer forMode:NSRunLoopCommonModes];
    return timerTarget.timer;
}
@end
