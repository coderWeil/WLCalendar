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
    self.singleCalendarView = [[WLCalendarSingleView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 2 * 20, 250)];
    self.singleTopView = [[WLCalendarTopView alloc] initWithFrame:CGRectMake(0, 0, self.singleCalendarView.frame.size.width, 50)];
    NSArray *week = @[@"Sun",@"Mon",@"Tue",@"Wen",@"Thr",@"Fri",@"Sat"];
    [self.singleTopView wl_setupData:week];
    [self.singleCalendarView setupTopView:self.singleTopView];
    [self.singleCalendarView wl_setCalendarItemClass:[WLCalendarExampleCell class]];
    id<WLCalendarModelProtocol> model = [[WLCalendarModel alloc] initWithDate:[NSDate date] calendarItemType:WLCalendarItemNormal];
    [self.singleCalendarView wl_setupCalendarModel:model date:[NSDate date]];
    [self.singleCalendarView wl_setCalendarDelegate:self];
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
    NSLog(@"%ld年---%ld月---%ld日",year,month,day);
}
- (void)currentDate:(NSDate *)currentDate day:(NSInteger)day
{
    
}
@end
