//
//  WLCalendarView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarView.h"

@interface WLCalendarView ()
@property (nonatomic, strong, readwrite) UIView *topView;
@end

@implementation WLCalendarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setupTopView:(UIView *)topView
{
    self.topView = topView;
    [self addSubview:self.topView];
}
- (void) wl_setupCalendarModel:(id<WLCalendarModelProtocol>)calendarModel date:(NSDate *)date{}
- (void) wl_setCalendarDelegate:(id<WLCalendarProtocol> _Nullable)calendarDelegate{}
- (void)wl_setCalendarItemClass:(Class)itemClass {}
@end
