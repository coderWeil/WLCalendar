//
//  WLCalendarMultiView.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLCalendarMultiView : WLCalendarView
/* 根据传入的date数据刷新日历 */
- (void) wl_setupCalendarModels:(NSArray<id<WLCalendarModelProtocol>> *)calendarModels date:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
