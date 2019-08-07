//
//  CanlendarView.h
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCalendarDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CanlendarView : UIView
- (void) reload:(NSDate *)date;
- (void) setCalendarDelegate:(id<WLCalendarDelegate> _Nullable)calendarDelegate;
@end

NS_ASSUME_NONNULL_END
