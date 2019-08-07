//
//  WLCalendarDelegate.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WLCalendarDelegate <NSObject>
@optional
- (void) currentYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day selectedDay:(NSInteger)selectedDay;
- (void) currentDate:(NSDate *)currentDate selectedDay:(NSInteger)selectedDay;
@end

NS_ASSUME_NONNULL_END
