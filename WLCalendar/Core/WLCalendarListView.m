//
//  WLCalendarListView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarListView.h"
#import "NSDate+WLCalendar.h"
#import "WLCalendarCell.h"
#import "WLCalendarModel.h"

@interface WLCalendarListView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) id<WLCalendarModelProtocol> calendarModel;
@property (nonatomic, assign) NSInteger monthDays;
@property (nonatomic, strong) WLCalendarCell *currentCell;
@end

@implementation WLCalendarListView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)wl_setupCalendarModel:(id<WLCalendarModelProtocol>)calendarModel previousDaysOfMonth:(NSInteger)previousDaysOfMonth
{
    self.calendarModel = calendarModel;
    self.monthDays = previousDaysOfMonth;
    if (self.currentCell) {
        self.currentCell.calendarItemType = WLCalendarItemNormal;
        self.currentCell = nil;
    }
    [self reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WL_CALENDARITEM_CELL forIndexPath:indexPath];
    id<WLCalendarModelProtocol> calendarModel = self.calendarModel;
    NSInteger firstWeekday = calendarModel.wl_firstWeekday;
    NSInteger totalDays = calendarModel.wl_daysOfMonth;
    if (indexPath.item >= firstWeekday && indexPath.item < firstWeekday + totalDays) {
        calendarModel.wl_itemText = [NSString stringWithFormat:@"%ld",indexPath.item - firstWeekday + 1];
        if ([calendarModel wl_month] == [[NSDate date] wl_month] && [calendarModel wl_year] == [[NSDate date] wl_year]) {
            if (indexPath.item == [[NSDate date] wl_day] + firstWeekday - 1) {
                calendarModel.wl_calendarItemType = WLCalendarItemSelected;
                if (!self.currentCell) {
                    self.currentCell = cell;
                }
            }else {
                calendarModel.wl_calendarItemType = WLCalendarItemNormal;
            }
        }else {
            calendarModel.wl_calendarItemType = WLCalendarItemNormal;
        }
    }else if (indexPath.item < firstWeekday) {
        calendarModel.wl_itemText = [NSString stringWithFormat:@"%ld",self.monthDays - (firstWeekday - indexPath.item) + 1];
        calendarModel.wl_calendarItemType = WLCalendarItemDisabled;
    }else if (indexPath.row >= firstWeekday + totalDays) {
        calendarModel.wl_itemText = [NSString stringWithFormat:@"%ld",indexPath.row - firstWeekday - totalDays + 1];
        calendarModel.wl_calendarItemType = WLCalendarItemDisabled;
    }
    [cell wl_setupCalendarData:calendarModel];
    return cell;
}

#pragma mark - UICollectionViewDeleagate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WLCalendarCell *cell = (WLCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.currentCell == cell) {
        return;
    }
    self.currentCell.calendarItemType = WLCalendarItemNormal;
    self.currentCell = cell;
    self.currentCell.calendarItemType = WLCalendarItemSelected;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self.calendarModel.wl_date];
    NSDate *currentDate = [calendar dateFromComponents:components];
    NSInteger year = [currentDate wl_year];
    NSInteger month = [currentDate wl_month];
    NSInteger day = [currentDate wl_day];
    if (self.currentCell) {
        day = [self.currentCell.dayLabel.text intValue];
    }
    if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(year:month:day:)]) {
        [self.calendarDelegate year:year month:month day:day];
    }
    if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(currentDate:day:)]) {
        [self.calendarDelegate currentDate:currentDate day:day];
    }
}

@end
