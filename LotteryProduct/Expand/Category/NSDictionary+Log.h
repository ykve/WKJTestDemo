//
//  NSDictionary+Log.h
//  Cree
//
//  Created by apple_Q on 2017/8/22.
//  Copyright © 2017年 RuanJie. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif

@interface NSDictionary (Log)

@end
