//
//  CalendarModel.m
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "CalendarModel.h"
#import "NSDate+Calendar.h"

@implementation CalendarModel
- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.currentDate = date;
        self.totalDaysInMonth = [date totalDaysInMonth];
        self.firstWeekday = [date firstWeekDayInMonth];
        self.year = [date yearOfDate];
        self.month = [date monthOfDate];
    }
    return self;
}
@end
