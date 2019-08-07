//
//  NSDate+Calendar.h
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Calendar)
/*获取给定日期的天*/
- (NSInteger) dayOfDate;
/*获取给定日期的月份*/
- (NSInteger) monthOfDate;
/*获取给定日期的年份*/
- (NSInteger) yearOfDate;
/*获取给定日期的上个月的日期*/
- (instancetype) previousMonthDate;
/*获取给定日期的下个月的日期*/
- (instancetype) nextMonthDate;
/*获取给定日期的总天数*/
- (NSInteger) totalDaysInMonth;
/*获取给定日期当月的周一是哪一天*/
- (NSInteger) firstWeekDayInMonth;
@end

NS_ASSUME_NONNULL_END
