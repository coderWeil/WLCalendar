//
//  NSDate+WLCalendar.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (WLCalendar)
/*获取给定日期的天*/
- (NSInteger) wl_day;
/*获取给定日期的月份*/
- (NSInteger) wl_month;
/*获取给定日期的年份*/
- (NSInteger) wl_year;
/*获取给定日期的上个月的日期*/
- (instancetype) wl_previousMonthDate;
/*获取给定日期的下个月的日期*/
- (instancetype) wl_nextMonthDate;
/*获取给定日期的总天数*/
- (NSInteger) wl_daysOfMonth;
/*获取给定日期当月的周一是哪一天*/
- (NSInteger) wl_firstWeekDay;
@end

NS_ASSUME_NONNULL_END
