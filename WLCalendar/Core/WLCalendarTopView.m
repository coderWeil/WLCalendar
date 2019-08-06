//
//  WLCalendarTopView.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarTopView.h"

@implementation WLCalendarTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    }
    return self;
}
- (void)wl_setupData:(NSArray<NSString *> *)data
{
    CGFloat width = self.bounds.size.width;
    NSArray *week = data;
    CGFloat itemW = width / week.count;
    CGFloat itemH = self.bounds.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < week.count; ++i) {
        UILabel *item = [UILabel new];
        item.textColor = [UIColor whiteColor];
        item.font = [UIFont systemFontOfSize:17];
        item.text = week[i];
        item.textAlignment = NSTextAlignmentCenter;
        item.frame = CGRectMake(x, y, itemW, itemH);
        [self addSubview:item];
        x = CGRectGetMaxX(item.frame);
    }
}
@end
