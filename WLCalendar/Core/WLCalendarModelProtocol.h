//
//  WLCalendarModelProtocol.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, WLCalendarItem) {
    WLCalendarItemDisabled = 0,
    WLCalendarItemNormal = 1,
    WLCalendarItemSelected = 2
};

@protocol WLCalendarModelProtocol <NSObject>
@property (nonatomic, strong) NSDate *wl_date;
@property (nonatomic, assign) NSInteger wl_year;
@property (nonatomic, assign) NSInteger wl_month;
@property (nonatomic, assign) NSInteger wl_day;
@property (nonatomic, assign) NSInteger wl_daysOfMonth;
@property (nonatomic, assign) NSInteger wl_firstWeekday;
@property (nonatomic, assign) WLCalendarItem wl_calendarItemType;
@property (nonatomic, copy) NSString *wl_itemText;
@end

NS_ASSUME_NONNULL_END
