//
//  WLCalendarProtocol.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLCalendarModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WLCalendarProtocol <NSObject>
@optional
- (void) currentDate:(NSDate *)currentDate day:(NSInteger)day;
- (void) year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end

NS_ASSUME_NONNULL_END
