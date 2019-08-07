//
//  WLCalendarModel.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarModel.h"
#import "NSDate+WLCalendar.h"

@implementation WLCalendarModel
@synthesize wl_date = _date;
@synthesize wl_year = _year;
@synthesize wl_month = _month;
@synthesize wl_day = _day;
@synthesize wl_daysOfMonth = _daysOfMonth;
@synthesize wl_firstWeekday = _firstWeekday;
@synthesize wl_calendarItemType = _type;
@synthesize wl_itemText = _text;
@synthesize wl_recordArr = _recordArr;
@synthesize enabledRecordMode = _enabledRecordMode;

- (id<WLCalendarModelProtocol>)initWithDate:(NSDate *)date calendarItemType:(WLCalendarItem)type
{
    self = [super init];
    if (self) {
        self->_date = date;
        self-> _type = type;
        self->_year = [date wl_year];
        self->_month = [date wl_month];
        self->_day = [date wl_day];
        self->_daysOfMonth = [date wl_daysOfMonth];
        self->_firstWeekday = [date wl_firstWeekDay];
    }
    return self;
}
- (void)setCurrentDate:(NSDate *)currentDate
{
    self->_date = currentDate;
    self->_year = [currentDate wl_year];
    self->_month = [currentDate wl_month];
    self->_day = [currentDate wl_day];
    self->_daysOfMonth = [currentDate wl_daysOfMonth];
    self->_firstWeekday = [currentDate wl_firstWeekDay];
}
- (void)setCalendarType:(WLCalendarItem)calendarType
{
    self->_type = calendarType;
}
- (void)setItemText:(NSString *)itemText
{
    self->_text = itemText;
}
@end

