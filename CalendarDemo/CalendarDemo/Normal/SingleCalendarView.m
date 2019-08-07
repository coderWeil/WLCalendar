//
//  SingleCalendarView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "SingleCalendarView.h"
#import "NSDate+Calendar.h"
#import "CalendarModel.h"
#import "CalendarCollect.h"

@interface SingleCalendarView ()
@property (nonatomic, strong) CalendarCollect *collect;
@property (nonatomic, strong) UIView *topView;
@end

@implementation SingleCalendarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _setupTopView];
        [self _setupCollect];
    }
    return self;
}

- (void) _setupTopView
{
    CGFloat width = self.bounds.size.width;
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    self.topView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.topView];
    NSArray *week = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat itemW = width / week.count;
    CGFloat itemH = 40;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < week.count; ++i) {
        UILabel *item = [UILabel new];
        item.textColor = [UIColor whiteColor];
        item.font = [UIFont systemFontOfSize:17];
        item.text = week[i];
        item.textAlignment = NSTextAlignmentCenter;
        item.frame = CGRectMake(x, y, itemW, itemH);
        [self.topView addSubview:item];
        x = CGRectGetMaxX(item.frame);
    }
}

- (void) _setupCollect
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width/7.0, (height - CGRectGetMaxY(self.topView.frame))/7.0 * 0.85);
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    self.collect = [[CalendarCollect alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), width, height - CGRectGetMaxY(self.topView.frame)) collectionViewLayout:layout];
    [self addSubview:self.collect];
}
- (void)setCalendarDelegate:(id<WLCalendarDelegate>)calendarDelegate
{
    self.collect.calendarDelegate = calendarDelegate;
}
- (void)reload:(NSDate *)date
{
    NSInteger previousMonthDays = [[date previousMonthDate] totalDaysInMonth];
    CalendarModel *calendarModel = [[CalendarModel alloc] initWithDate:date];
    [self.collect setupCalendarData:calendarModel monthDays:previousMonthDays];
    [self.collect reloadData];
}
@end
