//
//  NSTimer+Secure.h
//  demo
//
//  Created by winter on 2015/3/23.
//  Copyright © 2015年 wd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Secure)
/// 默认 repeats
+ (instancetype _Nullable)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector;
+ (instancetype _Nullable)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget selector:(SEL _Nonnull)aSelector repeats:(BOOL)yesOrNo;

/// 默认 repeats
+ (instancetype _Nullable)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget block:(void (^_Nonnull)(void))block;
+ (instancetype _Nullable)seScheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id _Nonnull)aTarget repeats:(BOOL)yesOrNo block:(void (^_Nonnull)(void))block;
@end
