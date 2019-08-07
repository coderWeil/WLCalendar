//
//  CalendarCell.h
//  CalendarDemo
//
//  Created by weil on 2019/8/5.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const CalendarCellID = @"CalendarCell";
@interface CalendarCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UIView *dotView;
@end

NS_ASSUME_NONNULL_END
