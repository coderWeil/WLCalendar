//
//  WLCalendarMultiView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarMultiView.h"
#import "WLCalendarContainerView.h"

@interface WLCalendarMultiView ()
@property (nonatomic, strong) WLCalendarContainerView *scrollView;
@end

@implementation WLCalendarMultiView
- (void)setupTopView:(UIView *)topView
{
    [super setupTopView:topView];
    [self _setupContainerView];
}
- (void) _setupContainerView
{
    self.scrollView = [[WLCalendarContainerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.topView.frame))];
    [self addSubview:self.scrollView];
}
- (void) wl_setupCalendarModels:(NSArray<id<WLCalendarModelProtocol>> *)calendarModels date:(NSDate *)date
{
    [self.scrollView wl_setupCalendarModels:calendarModels date:date];
}
- (void) wl_setCalendarDelegate:(id<WLCalendarProtocol> _Nullable)calendarDelegate
{
    [self.scrollView wl_setCalendarDelegate:calendarDelegate];
}
- (void)wl_setCalendarItemClass:(Class)itemClass
{
    [self.scrollView wl_setCalendarItemClass:itemClass];
}
@end
