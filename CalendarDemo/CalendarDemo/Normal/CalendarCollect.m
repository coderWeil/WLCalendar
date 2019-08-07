//
//  CalendarCollect.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "CalendarCollect.h"
#import "CalendarModel.h"
#import "NSDate+Calendar.h"
#import "CalendarCell.h"

@interface CalendarCollect ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) CalendarModel *calendarModel;
@property (nonatomic, assign) NSInteger monthDays;
@property (nonatomic, strong) CalendarCell *currentCell;
@end

@implementation CalendarCollect
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[CalendarCell class] forCellWithReuseIdentifier:CalendarCellID];
    }
    return self;
}
- (void) setupCalendarData:(CalendarModel *)calendarModel monthDays:(NSInteger)monthDays
{
    self.calendarModel = calendarModel;
    self.monthDays = monthDays;
    if (self.currentCell) {
        self.currentCell.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;;
        self.currentCell.dayLabel.textColor = [UIColor darkGrayColor];
        self.currentCell = nil;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarCellID forIndexPath:indexPath];
    CalendarModel *calendarModel = self.calendarModel;
    NSInteger firstWeekday = calendarModel.firstWeekday;
    NSInteger totalDays = calendarModel.totalDaysInMonth;
    cell.userInteractionEnabled = YES;
    if (indexPath.item >= firstWeekday && indexPath.item < firstWeekday + totalDays) {
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item - firstWeekday + 1];
        cell.dayLabel.textColor = [UIColor darkGrayColor];
        if (calendarModel.month == [[NSDate date] monthOfDate] && calendarModel.year == [[NSDate date] yearOfDate]) {
            if (indexPath.item == [[NSDate date] dayOfDate] + firstWeekday - 1) {
                cell.dayLabel.textColor = [UIColor whiteColor];
                cell.dotView.layer.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
                if (!self.currentCell) {
                    self.currentCell = cell;
                }
            }else {
                cell.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
            }
        }else {
            cell.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
        }
    }else if (indexPath.item < firstWeekday) {
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld",self.monthDays - (firstWeekday - indexPath.item) + 1];
        cell.dayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        cell.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
        cell.userInteractionEnabled = NO;
    }else if (indexPath.row >= firstWeekday + totalDays) {
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row - firstWeekday - totalDays + 1];
        cell.dayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
        cell.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

#pragma mark - UICollectionViewDeleagate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = (CalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.currentCell == cell) {
        return;
    }
    self.currentCell.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;;
    self.currentCell.dayLabel.textColor = [UIColor darkGrayColor];
    self.currentCell = cell;
    self.currentCell.dotView.layer.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    self.currentCell.dayLabel.textColor = [UIColor whiteColor];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self.calendarModel.currentDate];
    NSDate *currentDate = [calendar dateFromComponents:components];
    NSInteger year = [currentDate yearOfDate];
    NSInteger month = [currentDate monthOfDate];
    NSInteger selectDay = 0;
    if (self.currentCell) {
        selectDay = [self.currentCell.dayLabel.text integerValue];
    }
    NSInteger day = [currentDate monthOfDate];
    if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(currentYear:month:day:selectedDay:)]) {
        [self.calendarDelegate currentYear:year month:month day:day selectedDay:selectDay];
    }
    if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(currentDate:selectedDay:)]) {
        [self.calendarDelegate currentDate:currentDate selectedDay:selectDay];
    }
}

@end
