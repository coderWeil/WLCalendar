//
//  WLCalendarExampleCell.m
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLCalendarExampleCell.h"

@interface WLCalendarExampleCell ()
@property (nonatomic,strong) id<WLCalendarModelProtocol> model;
@property (nonatomic, strong) UIView *dotView;
@end

@implementation WLCalendarExampleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubviews];
    }
    return self;
}
- (void) _setupSubviews
{
    self.dotView = [UIView new];
    [self.contentView addSubview:self.dotView];
    
    self.dayLabel = [UILabel new];
    self.dayLabel.font = [UIFont systemFontOfSize:13.0];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dayLabel];
}
- (void)wl_setupCalendarData:(id<WLCalendarModelProtocol>)model
{
    [super wl_setupCalendarData:model];
    self.model = model;
    self.dayLabel.text = model.wl_itemText;
    switch (self.model.wl_calendarItemType) {
        case WLCalendarItemNormal:
            self.dayLabel.textColor = [UIColor darkGrayColor];
            self.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
            break;
        case WLCalendarItemDisabled:
            self.dayLabel.textColor = [UIColor lightGrayColor];
            self.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
            break;
        case WLCalendarItemSelected:
            self.dayLabel.textColor = [UIColor whiteColor];
            self.dotView.layer.backgroundColor = [UIColor redColor].CGColor;
            break;
    }
}
- (void)setCalendarItemType:(WLCalendarItem)calendarItemType
{
    self.model.wl_calendarItemType = calendarItemType;
    switch (calendarItemType) {
        case WLCalendarItemNormal:
            self.dayLabel.textColor = [UIColor darkGrayColor];
            self.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
            break;
        case WLCalendarItemDisabled:
            self.dayLabel.textColor = [UIColor lightGrayColor];
            self.dotView.layer.backgroundColor = [UIColor clearColor].CGColor;
            break;
        case WLCalendarItemSelected:
            self.dayLabel.textColor = [UIColor whiteColor];
            self.dotView.layer.backgroundColor = [UIColor redColor].CGColor;
            break;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dayLabel.frame = self.contentView.bounds;
    self.dotView.bounds = CGRectMake(0, 0, self.contentView.bounds.size.height * 0.8, self.contentView.bounds.size.height * 0.8);
    self.dotView.center = CGPointMake(self.contentView.bounds.size.width * 0.5, self.contentView.bounds.size.height * 0.5);
    self.dotView.layer.cornerRadius = self.dotView.bounds.size.width * 0.5;
}

@end
