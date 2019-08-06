//
//  NSDate+WLCalendar.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "NSDate+WLCalendar.h"

@implementation NSDate (WLCalendar)
- (NSInteger)wl_day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:self];
    return comps.day;
}
- (NSInteger)wl_month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:self];
    return comps.month;
}
- (NSInteger)wl_year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    return comps.year;
}
- (instancetype)wl_previousMonthDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
    if (comps.month == 1) {
        comps.month = 12;
        comps.year -= 1;
    }else {
        comps.month -= 1;
    }
    NSDate *previousDate = [calendar dateFromComponents:comps];
    return previousDate;
}
- (instancetype)wl_nextMonthDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
    if (comps.month == 12) {
        comps.month = 1;
        comps.year += 1;
    }else {
        comps.month += 1;
    }
    NSDate *previousDate = [calendar dateFromComponents:comps];
    return previousDate;
}
- (NSInteger)wl_daysOfMonth
{
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}
- (NSInteger)wl_firstWeekDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
    comps.day = 1;
    NSDate *firstDayDate = [calendar dateFromComponents:comps];
    NSInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayDate] - 1;
    return firstWeekDay;
}

@end
