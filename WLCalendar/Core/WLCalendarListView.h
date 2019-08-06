//
//  WLCalendarListView.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCalendarModelProtocol.h"
#import "WLCalendarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const WL_CALENDARITEM_CELL = @"WLCanlendarItemId";
@interface WLCalendarListView : UICollectionView
@property (nonatomic, weak) id<WLCalendarProtocol> calendarDelegate;
- (void) wl_setupCalendarModel:(id<WLCalendarModelProtocol>)calendarModel previousDaysOfMonth:(NSInteger)previousDaysOfMonth;
@end

NS_ASSUME_NONNULL_END
