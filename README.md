# WLCalendar
日历

![动图](https://github.com/weilLove/WLCalendar/blob/master/111.mov)

![图片](https://github.com/weilLove/WLCalendar/blob/master/动态计算高度的单个日历.png)

#### 引入方式
1. ```cocopods``` 引入 ```pod WLCalendar```
2. 下载源码，将```WLCalendar```拖入工程中


#### 使用方法


##### 1. 常用日历(多个日历界面的样式)
```
// 日历创建
    self.calendarView = [[WLCalendarMultiView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.singleCalendarView.frame) + 50, self.view.frame.size.width - 2 * 20, 250)];
    //头部信息设置
    self.topView = [[WLCalendarTopView alloc] initWithFrame:CGRectMake(0, 0, self.calendarView.frame.size.width, 50)];
    NSArray *week = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    [self.topView wl_setupData:week];
    [self.calendarView setupTopView:self.topView];
    //注册日历item，这里可以自己定义，继承自提供的WLCalendarCell，其余可自定义
    [self.calendarView wl_setCalendarItemClass:[WLCalendarExampleCell class]];
    //设置代理
    [self.calendarView wl_setCalendarDelegate:self];
    //设置日历数据
    NSMutableArray<id<WLCalendarModelProtocol>> *models = @[].mutableCopy;
   //需要设置三个，因日历表实现由三个视图复用所致，需提供三个数据源
    id<WLCalendarModelProtocol> model1 = [[WLCalendarModel alloc] initWithDate:[[NSDate date] wl_previousMonthDate] calendarItemType:WLCalendarItemNormal];
    id<WLCalendarModelProtocol> model2 = [[WLCalendarModel alloc] initWithDate:[NSDate date] calendarItemType:WLCalendarItemNormal];
    id<WLCalendarModelProtocol> model3 = [[WLCalendarModel alloc] initWithDate:[[NSDate date] wl_nextMonthDate] calendarItemType:WLCalendarItemNormal];
    [models addObject:model1];
    [models addObject:model2];
    [models addObject:model3];
    [self.calendarView wl_setupCalendarModels:models.copy date:[NSDate date]];
    [self.view addSubview:self.calendarView];
```

##### 2. 单个日历

```
   //头部数据
   NSArray *week = @[@"MON",@"TUE",@"WEN",@"THU",@"FRI",@"SAT",@"SUN"];
   //日历数据源，只需要一个
    id<WLCalendarModelProtocol> model = [[WLCalendarModel alloc] initWithDate:[NSDate date] calendarItemType:WLCalendarItemNormal];
    //每一个Item的高度
    model.wl_itemH = 30;
    //以下为动态计算日历表高度，也可不用，而直接设置高度
    NSInteger totalDays = model.wl_daysOfMonth;
    NSInteger firstWeekday = model.wl_firstWeekday;
    NSInteger row = 1 + (totalDays - firstWeekday) / 7;
   CGFloat height = 50 + model.wl_itemH * row;
    self.singleCalendarView = [[WLCalendarSingleView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 2 * 20, height)];
    self.singleTopView = [[WLCalendarTopView alloc] initWithFrame:CGRectMake(0, 0, self.singleCalendarView.frame.size.width, 50)];
    [self.singleTopView wl_setupData:week];
    [self.singleCalendarView setupTopView:self.singleTopView];
    //注册cell
    [self.singleCalendarView wl_setCalendarItemClass:[WLCalendarExampleCell class]];
    //数据准备,此数据为需要特别处理显示的数据，类似打卡中已打卡的数据部分，如果只需要显示今日的item高亮，可不用设置
    NSMutableArray<NSString *> *_arr = @[].mutableCopy;
    for (int i = 0; i < 5; ++i) {
        NSString *str = [NSString stringWithFormat:@"%02d-%02d-%02d",(int)arc4random()%3 + 2018,(int)arc4random()%3 + 7,(int)arc4random()%3+5];
        [_arr addObject:str];
    }
    [_arr addObject:@"2019-08-02"];
    [_arr addObject:@"2019-08-28"];
    [_arr addObject:@"2019-08-05"];
    model.wl_recordArr = _arr.copy;
    //这个属性为是否开启类似打卡功能中已打卡天数的高亮显示功能，和wl_recordArr同时设置
    model.enabledRecordMode = YES;
    //设置代理
    [self.singleCalendarView wl_setCalendarDelegate:self];
    [self.singleCalendarView wl_setupCalendarModel:model date:[NSDate date]];
    [self.view addSubview:self.singleCalendarView];
```

#### 注意部分
```
//在调用 [self showMultiCalendar];将此值返回NO，否则崩溃,此为是否开启动态计算日历表高度，仅针对单个表需要设置
- (BOOL)enableDynamicHeight
{
    return YES;
}
```

