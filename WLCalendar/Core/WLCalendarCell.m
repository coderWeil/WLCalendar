//
//  WLCalendarCell.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarCell.h"

@implementation WLCalendarCell
- (void) wl_setupCalendarData:(id<WLCalendarModelProtocol>)model
{
    self.userInteractionEnabled = !model.isEnabledRecordMode && !(model.wl_calendarItemType == WLCalendarItemDisabled);
}
@end
