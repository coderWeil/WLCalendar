//
//  WLCalendarContainerView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarContainerView.h"
#import "WLCalendarListView.h"
#import "NSDate+WLCalendar.h"

@interface WLCalendarContainerView ()<UIScrollViewDelegate>
@property (nonatomic, strong) WLCalendarListView *leftCollect;
@property (nonatomic, strong) WLCalendarListView *middleCollect;
@property (nonatomic, strong) WLCalendarListView *rightCollect;
@property (nonatomic, strong) NSDate *currentDateMonth;
@property (nonatomic, strong) NSMutableArray<id<WLCalendarModelProtocol>> *monthArr;
@end

@implementation WLCalendarContainerView
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
- (void) _setupCollectionViews
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width/7.0, height/7.0 * 0.85);
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    
    self.leftCollect = [[WLCalendarListView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.leftCollect];
    
    self.middleCollect = [[WLCalendarListView alloc] initWithFrame:CGRectMake(width, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.middleCollect];
    
    self.rightCollect = [[WLCalendarListView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.rightCollect];
    
    self.contentSize = CGSizeMake(3 * self.frame.size.width, 0);
}
- (void)wl_setupCalendarModels:(NSArray<id<WLCalendarModelProtocol>> *)calendarModels date:(NSDate *)date
{
    self.monthArr = @[].mutableCopy;
    [self.monthArr addObjectsFromArray:calendarModels];
    self.currentDateMonth = date;
    [self _reloadCollect];
}
- (void)wl_setCalendarDelegate:(id<WLCalendarProtocol>)calendarDelegate
{
    self.leftCollect.calendarDelegate = calendarDelegate;
    self.middleCollect.calendarDelegate = calendarDelegate;
    self.rightCollect.calendarDelegate = calendarDelegate;
}
- (void)wl_setCalendarItemClass:(Class)itemClass
{
    [self.leftCollect registerClass:itemClass forCellWithReuseIdentifier:WL_CALENDARITEM_CELL];
    [self.middleCollect registerClass:itemClass forCellWithReuseIdentifier:WL_CALENDARITEM_CELL];
    [self.rightCollect registerClass:itemClass forCellWithReuseIdentifier:WL_CALENDARITEM_CELL];
}
- (void) _reloadCollect
{
    [self.leftCollect wl_setupCalendarModel:self.monthArr[0] previousDaysOfMonth:[[self.currentDateMonth wl_previousMonthDate] wl_daysOfMonth]];
    [self.middleCollect wl_setupCalendarModel:self.monthArr[1] previousDaysOfMonth:[[self.currentDateMonth wl_previousMonthDate] wl_daysOfMonth]];
     [self.rightCollect wl_setupCalendarModel:self.monthArr[2] previousDaysOfMonth:[[self.currentDateMonth wl_previousMonthDate] wl_daysOfMonth]];
    [self.leftCollect reloadData];
    [self.middleCollect reloadData];
    [self.rightCollect reloadData];
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self) {
        return;
    }
    // 向右滑动
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        self.currentDateMonth = [self.currentDateMonth wl_previousMonthDate];
        NSDate *previousDate = [self.currentDateMonth wl_previousMonthDate];
        // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
        id<WLCalendarModelProtocol> currentMothInfo = self.monthArr[0];
        id<WLCalendarModelProtocol> nextMonthInfo = self.monthArr[1];
        id<WLCalendarModelProtocol> olderNextMonthInfo = self.monthArr[2];
        // 复用 CalendarModel 对象,也可重新构造新的
        olderNextMonthInfo.wl_date = previousDate;
        id<WLCalendarModelProtocol> previousMonthInfo = olderNextMonthInfo;
        [self.monthArr removeAllObjects];
        [self.monthArr addObject:previousMonthInfo];
        [self.monthArr addObject:currentMothInfo];
        [self.monthArr addObject:nextMonthInfo];
    }
    // 向左滑动
    else if (scrollView.contentOffset.x > self.bounds.size.width) {
        
        self.currentDateMonth = [self.currentDateMonth wl_nextMonthDate];
        NSDate *nextDate = [self.currentDateMonth wl_nextMonthDate];
        // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
        id<WLCalendarModelProtocol> previousMonthInfo = self.monthArr[1];
        id<WLCalendarModelProtocol> currentMothInfo = self.monthArr[2];
        id<WLCalendarModelProtocol> olderPreviousMonthInfo = self.monthArr[0];
        // 复用 CalendarModel 对象，也可重新构造新的
        olderPreviousMonthInfo.wl_date = nextDate;
        id<WLCalendarModelProtocol> nextMonthInfo = olderPreviousMonthInfo;
        [self.monthArr removeAllObjects];
        [self.monthArr addObject:previousMonthInfo];
        [self.monthArr addObject:currentMothInfo];
        [self.monthArr addObject:nextMonthInfo];
    }
    [self _reloadCollect];
}

@end
