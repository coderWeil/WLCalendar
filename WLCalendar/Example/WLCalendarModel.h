//
//  WLCalendarModel.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLCalendarModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLCalendarModel : NSObject<WLCalendarModelProtocol>
/* 通过此属性改变type从而控制每一个item对应的状态 */
@property (nonatomic, assign) WLCalendarItem calendarItemType;
/* 如果只改变model的某个属性，可以通过改变此date的方式 */
@property (nonatomic, strong) NSDate *currentDate;
/* 设置item的文本 */
@property (nonatomic, copy) NSString *itemText;
- (id<WLCalendarModelProtocol>) initWithDate:(NSDate *)date calendarItemType:(WLCalendarItem)type;
@end

NS_ASSUME_NONNULL_END
