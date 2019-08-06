//
//  WLCalendarContainerView.h
//  CalendarDemo
//
//  Created by weil on 2019/8/6.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCalendarProtocol.h"
#import "WLCalendarModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLCalendarContainerView : UIScrollView
/* 根据传入的date数据刷新日历 */
- (void) wl_setupCalendarModels:(NSArray<id<WLCalendarModelProtocol>> *)calendarModels date:(NSDate *)date;
/* 设置日历回调代理 */
- (void) wl_setCalendarDelegate:(id<WLCalendarProtocol> _Nullable)calendarDelegate;
/* 设置item的类型 */
- (void) wl_setCalendarItemClass:(Class)itemClass;
@end

NS_ASSUME_NONNULL_END
