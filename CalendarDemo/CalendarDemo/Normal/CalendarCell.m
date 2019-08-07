//
//  CalendarCell.m
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell
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
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dayLabel.frame = self.contentView.bounds;
    self.dotView.bounds = CGRectMake(0, 0, self.contentView.bounds.size.height * 0.8, self.contentView.bounds.size.height * 0.8);
    self.dotView.center = CGPointMake(self.contentView.bounds.size.width * 0.5, self.contentView.bounds.size.height * 0.5);
    self.dotView.layer.cornerRadius = self.dotView.bounds.size.width * 0.5;
}
@end
