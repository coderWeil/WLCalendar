//
//  CanlendarView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "CanlendarView.h"
#import "CalendarScrollView.h"

@interface CanlendarView ()
@property (nonatomic, strong) CalendarScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@end

@implementation CanlendarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _setupTopView];
        [self _setupScroll];
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
- (void) _setupScroll
{
    self.scrollView = [[CalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.topView.frame))];
    [self addSubview:self.scrollView];
}
- (void)setCalendarDelegate:(id<WLCalendarDelegate>)calendarDelegate
{
    self.scrollView.calendarDelegate = calendarDelegate;
}
- (void) reload:(NSDate *)date
{
    [self.scrollView reload:date];
}

@end
