//
//  GetLocation.h
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/12.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationPlacemark)(CLPlacemark *placemark);
typedef void(^LocationFailed)(NSError *error);
typedef void(^LocationStatus)(CLAuthorizationStatus status);

@interface GetLocation : NSObject

+ (instancetype)sharedInstance;

- (void)getLocationPlacemark:(LocationPlacemark)placemark status:(LocationStatus)status didFailWithError:(LocationFailed)error;

@end
