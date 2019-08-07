//
//  CalendarScrollView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "CalendarScrollView.h"
#import "CalendarModel.h"
#import "NSDate+Calendar.h"
#import "CalendarCollect.h"

@interface CalendarScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) CalendarCollect *leftCollect;
@property (nonatomic, strong) CalendarCollect *middleCollect;
@property (nonatomic, strong) CalendarCollect *rightCollect;
@property (nonatomic, strong) NSDate *currentDateMonth;
@property (nonatomic, strong) NSMutableArray<CalendarModel *> *monthArr;
@end

@implementation CalendarScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        [self _setupCollectionViews];
    }
    return self;
}

- (void) _setupMonthArr
{
    self.monthArr = @[].mutableCopy;
    [self.monthArr addObject:[[CalendarModel alloc] initWithDate:[self.currentDateMonth previousMonthDate]]];
    [self.monthArr addObject:[[CalendarModel alloc] initWithDate:self.currentDateMonth]];
    [self.monthArr addObject:[[CalendarModel alloc] initWithDate:[self.currentDateMonth nextMonthDate]]];
}

- (void) _setupCollectionViews
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width/7.0, height/7.0 * 0.85);
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    
    self.leftCollect = [[CalendarCollect alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.leftCollect];
    
    self.middleCollect = [[CalendarCollect alloc] initWithFrame:CGRectMake(width, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.middleCollect];
    
    self.rightCollect = [[CalendarCollect alloc] initWithFrame:CGRectMake(width * 2, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.rightCollect];
    
    self.contentSize = CGSizeMake(3 * self.frame.size.width, 0);
}
- (void)reload:(NSDate *)date
{
    self.currentDateMonth = date;
    [self _setupMonthArr];
    [self _reloadCollect];
}
- (void)setCalendarDelegate:(id<WLCalendarDelegate>)calendarDelegate
{
    self.leftCollect.calendarDelegate = calendarDelegate;
    self.middleCollect.calendarDelegate = calendarDelegate;
    self.rightCollect.calendarDelegate = calendarDelegate;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self) {
        return;
    }
    // 向右滑动
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        self.currentDateMonth = [self.currentDateMonth previousMonthDate];
        NSDate *previousDate = [self.currentDateMonth previousMonthDate];
        // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
        CalendarModel *currentMothInfo = self.monthArr[0];
        CalendarModel *nextMonthInfo = self.monthArr[1];
        CalendarModel *olderNextMonthInfo = self.monthArr[2];
        // 复用 CalendarModel 对象,也可重新构造新的
        olderNextMonthInfo.totalDaysInMonth = [previousDate totalDaysInMonth];
        olderNextMonthInfo.firstWeekday = [previousDate firstWeekDayInMonth];
        olderNextMonthInfo.year = [previousDate yearOfDate];
        olderNextMonthInfo.month = [previousDate monthOfDate];
        olderNextMonthInfo.currentDate = previousDate;
        CalendarModel *previousMonthInfo = olderNextMonthInfo;
        [self.monthArr removeAllObjects];
        [self.monthArr addObject:previousMonthInfo];
        [self.monthArr addObject:currentMothInfo];
        [self.monthArr addObject:nextMonthInfo];
    }
    // 向左滑动
    else if (scrollView.contentOffset.x > self.bounds.size.width) {
        
        self.currentDateMonth = [self.currentDateMonth nextMonthDate];
        NSDate *nextDate = [self.currentDateMonth nextMonthDate];
        // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
        CalendarModel *previousMonthInfo = self.monthArr[1];
        CalendarModel *currentMothInfo = self.monthArr[2];
        CalendarModel *olderPreviousMonthInfo = self.monthArr[0];
        // 复用 CalendarModel 对象，也可重新构造新的
        olderPreviousMonthInfo.totalDaysInMonth = [nextDate totalDaysInMonth];
        olderPreviousMonthInfo.firstWeekday = [nextDate firstWeekDayInMonth];
        olderPreviousMonthInfo.year = [nextDate yearOfDate];
        olderPreviousMonthInfo.month = [nextDate monthOfDate];
        olderPreviousMonthInfo.currentDate = nextDate;
        CalendarModel *nextMonthInfo = olderPreviousMonthInfo;
        [self.monthArr removeAllObjects];
        [self.monthArr addObject:previousMonthInfo];
        [self.monthArr addObject:currentMothInfo];
        [self.monthArr addObject:nextMonthInfo];
    }
    [self _reloadCollect];
}

- (void) _reloadCollect
{
    [self.leftCollect setupCalendarData:self.monthArr[0] monthDays:[[self.currentDateMonth previousMonthDate] totalDaysInMonth]];
    [self.middleCollect setupCalendarData:self.monthArr[1] monthDays:[[self.currentDateMonth previousMonthDate] totalDaysInMonth]];
    [self.rightCollect setupCalendarData:self.monthArr[2] monthDays:[[self.currentDateMonth previousMonthDate] totalDaysInMonth]];
    [self.leftCollect reloadData];
    [self.middleCollect reloadData];
    [self.rightCollect reloadData];
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}
@end
