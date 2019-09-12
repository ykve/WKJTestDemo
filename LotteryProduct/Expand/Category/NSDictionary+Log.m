//
//  NSDictionary+Log.m
//  Cree
//
//  Created by apple_Q on 2017/8/22.
//  Copyright © 2017年 RuanJie. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
#if DEBUG
- (NSString *)descriptionWithLocale:(nullable id)locale{
    
    NSString *logString = @" ";
//    @try {
//        id i = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
//        if (i){
//            logString=[[NSString alloc] initWithData:i encoding:NSUTF8StringEncoding];
//        }
//    } @catch (NSException *exception) {
//
//        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
//        logString = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
//
//    } @finally {
//
//    }
    return logString;
}
#endif

@end
