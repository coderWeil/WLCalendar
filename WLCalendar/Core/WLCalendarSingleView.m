//
//  WLCalendarSingleView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarSingleView.h"
#import "NSDate+WLCalendar.h"
#import "WLCalendarModelProtocol.h"
#import "WLCalendarListView.h"

@interface WLCalendarSingleView ()
@property (nonatomic, strong) WLCalendarListView *collect;
@end

@implementation WLCalendarSingleView
- (void)setupTopView:(UIView *)topView
{
    [super setupTopView:topView];
    [self _setupCollect];
}
- (void) _setupCollect
{
    if (self.collect) {
        [self.collect removeFromSuperview];
        self.collect = nil;
    }
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width/7.0, (height - CGRectGetMaxY(self.topView.frame))/7.0 * 0.85);
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    self.collect = [[WLCalendarListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), width, height - CGRectGetMaxY(self.topView.frame)) collectionViewLayout:layout];
    [self addSubview:self.collect];
}
- (void) wl_setCalendarDelegate:(id<WLCalendarProtocol>)calendarDelegate
{
    self.collect.calendarDelegate = calendarDelegate;
}
- (void)wl_setupCalendarModel:(id<WLCalendarModelProtocol>)calendarModel date:(nonnull NSDate *)date
{
    NSInteger previousMonthDays = [[date wl_previousMonthDate] wl_daysOfMonth];
    [self.collect wl_setupCalendarModel:calendarModel previousDaysOfMonth:previousMonthDays];
}
- (void)wl_setCalendarItemClass:(Class)itemClass
{
    [self.collect registerClass:itemClass forCellWithReuseIdentifier:WL_CALENDARITEM_CELL];
}
@end
