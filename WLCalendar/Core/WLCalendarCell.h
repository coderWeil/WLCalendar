//
//  WLCalendarCell.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCalendarModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLCalendarCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, assign) WLCalendarItem calendarItemType;
- (void) wl_setupCalendarData:(id<WLCalendarModelProtocol>)model;
@end

NS_ASSUME_NONNULL_END
