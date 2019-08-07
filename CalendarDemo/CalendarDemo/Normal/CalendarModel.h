//
//  CalendarModel.h
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarModel : NSObject
/*指定的日期*/
@property (nonatomic, strong) NSDate *currentDate;
/*指定日期的总天数*/
@property (nonatomic, assign) NSInteger totalDaysInMonth;
/*指定日期当月的周一是第几天*/
@property (nonatomic, assign) NSInteger firstWeekday;
/*指定日期的年份*/
@property (nonatomic, assign) NSInteger year;
/*指定日期的月份*/
@property (nonatomic, assign) NSInteger month;
- (instancetype) initWithDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
