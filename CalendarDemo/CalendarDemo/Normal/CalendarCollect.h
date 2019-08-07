//
//  CalendarCollect.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCalendarDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class CalendarModel;
@interface CalendarCollect : UICollectionView
@property (nonatomic, weak) id<WLCalendarDelegate> calendarDelegate;
- (void) setupCalendarData:(CalendarModel *)calendarModel monthDays:(NSInteger)monthDays;
@end

NS_ASSUME_NONNULL_END
