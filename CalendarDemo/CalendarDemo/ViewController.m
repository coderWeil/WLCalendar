//
//  ViewController.m
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "ViewController.h"
#import "WLCalendarSingleView.h"
#import "WLCalendarModel.h"
#import "WLCalendarTopView.h"
#import "WLCalendarExampleCell.h"
#import "WLCalendarMultiView.h"
#import "NSDate+WLCalendar.h"

@interface ViewController ()<WLCalendarProtocol>
@property (nonatomic, strong) WLCalendarSingleView *singleCalendarView;
@property (nonatomic, strong) WLCalendarTopView *singleTopView;
@property (nonatomic, strong) WLCalendarMultiView *calendarView;
@property (nonatomic, strong) WLCalendarTopView *topView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSingleCalendar];
    [self showMultiCalendar];
}
- (void) showSingleCalendar
{
    NSArray *week = @[@"MON",@"TUE",@"WEN",@"THU",@"FRI",@"SAT",@"SUN"];
    id<WLCalendarModelProtocol> model = [[WLCalendarModel alloc] initWithDate:[NSDate date] calendarItemType:WLCalendarItemNormal];
    model.wl_itemH = 30;
//    NSInteger totalDays = model.wl_daysOfMonth;
//    NSInteger firstWeekday = model.wl_firstWeekday;
//    NSInteger row = 1 + (totalDays - firstWeekday) / 7;
//   CGFloat height = 50 + model.wl_itemH * row;
    CGFloat height = 250;
    self.singleCalendarView = [[WLCalendarSingleView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 2 * 20, height)];
    self.singleTopView = [[WLCalendarTopView alloc] initWithFrame:CGRectMake(0, 0, self.singleCalendarView.frame.size.width, 50)];
    [self.singleTopView wl_setupData:week];
    [self.singleCalendarView setupTopView:self.singleTopView];
    [self.singleCalendarView wl_setCalendarItemClass:[WLCalendarExampleCell class]];
    NSMutableArray<NSString *> *_arr = @[].mutableCopy;
    for (int i = 0; i < 5; ++i) {
        NSString *str = [NSString stringWithFormat:@"%02d-%02d-%02d",(int)arc4random()%3 + 2018,(int)arc4random()%3 + 7,(int)arc4random()%3+5];
        [_arr addObject:str];
    }
    [_arr addObject:@"2019-08-02"];
    [_arr addObject:@"2019-08-28"];
    [_arr addObject:@"2019-08-05"];
    model.wl_recordArr = _arr.copy;
    model.enabledRecordMode = NO;
    [self.singleCalendarView wl_setCalendarDelegate:self];
    [self.singleCalendarView wl_setupCalendarModel:model date:[NSDate date]];
    [self.view addSubview:self.singleCalendarView];
}
- (void) showMultiCalendar
{
    self.calendarView = [[WLCalendarMultiView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.singleCalendarView.frame) + 50, self.view.frame.size.width - 2 * 20, 250)];
    self.topView = [[WLCalendarTopView alloc] initWithFrame:CGRectMake(0, 0, self.calendarView.frame.size.width, 50)];
    NSArray *week = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    [self.topView wl_setupData:week];
    [self.calendarView setupTopView:self.topView];
    [self.calendarView wl_setCalendarItemClass:[WLCalendarExampleCell class]];
    NSMutableArray<id<WLCalendarModelProtocol>> *models = @[].mutableCopy;
    
    id<WLCalendarModelProtocol> model1 = [[WLCalendarModel alloc] initWithDate:[[NSDate date] wl_previousMonthDate] calendarItemType:WLCalendarItemNormal];
    id<WLCalendarModelProtocol> model2 = [[WLCalendarModel alloc] initWithDate:[NSDate date] calendarItemType:WLCalendarItemNormal];
    id<WLCalendarModelProtocol> model3 = [[WLCalendarModel alloc] initWithDate:[[NSDate date] wl_nextMonthDate] calendarItemType:WLCalendarItemNormal];
    [models addObject:model1];
    [models addObject:model2];
    [models addObject:model3];
    [self.calendarView wl_setupCalendarModels:models.copy date:[NSDate date]];
    [self.calendarView wl_setCalendarDelegate:self];
    [self.view addSubview:self.calendarView];
}


- (void)year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSLog(@"%zd年---%zd月---%zd日",year,month,day);
}
- (void)currentDate:(NSDate *)currentDate day:(NSInteger)day
{
    
}
//在调用 [self showMultiCalendar];将此值返回NO，否则崩溃
- (BOOL)enableDynamicHeight
{
    return NO;
}
@end
