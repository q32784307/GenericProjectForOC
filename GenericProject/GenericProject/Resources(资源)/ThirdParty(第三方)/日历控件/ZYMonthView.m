//
//  ZYMonthView.m
//  Example
//
//  Created by Daniel on 16/10/28.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYMonthView.h"
#import "JTDateHelper.h"
#import "ZYWeekView.h"

@interface ZYMonthView ()
@property (nonatomic, strong)UILabel *titleLab;
@end

@implementation ZYMonthView {
    NSInteger weekNumber;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    [self reload];
}

- (void)reload {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 某月
    NSString *dateStr = [_manager.titleDateFormatter stringFromDate:_date];
    self.titleLab.text = dateStr;
    [self addSubview:_titleLab];
    
    UIView *weekTitlesView = [[UIView alloc] init];
    [self addSubview:weekTitlesView];
    [weekTitlesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(SYRealValue(80 / 2));
    }];
    CGFloat weekW = self.frame.size.width/7;
    NSArray *titles = @[@"日", @"一", @"二", @"三",
                        @"四", @"五", @"六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(i*weekW, 0, weekW, SYRealValue(80 / 2))];
        week.textAlignment = NSTextAlignmentCenter;
        week.font = SystemFont(SYRealValue(28 / 2));
        [weekTitlesView addSubview:week];
        week.text = titles[i];
    }
    
    weekNumber = [_manager.helper numberOfWeeks:_date];
    // 有几周
    NSDate *firstDay = [_manager.helper firstDayOfMonth:_date];
    
    for (int i = 0; i < weekNumber; i++) {
        ZYWeekView *weekView = [_manager dequeueReusableWeekViewWithIdentifier:Identifier];
        if (!weekView) {
            weekView = [ZYWeekView new];
            weekView.manager = self.manager;
        }
        weekView.frame = CGRectMake(0, _manager.dayViewHeight+_manager.dayViewGap*2 + (_manager.dayViewHeight+_manager.dayViewGap)*i + SYRealValue(80 / 2), self.frame.size.width, _manager.dayViewHeight);
        
        weekView.theMonthFirstDay = firstDay;
        weekView.date = [_manager.helper addToDate:firstDay weeks:i];
        [self addSubview:weekView];
    }
    
    CGRect frame = self.frame;
    frame.size.height = weekNumber * (_manager.dayViewHeight+_manager.dayViewGap) + _manager.dayViewHeight + 2*_manager.dayViewGap + SYRealValue(80 / 2);
    self.frame = frame;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _manager.dayViewGap+10, self.frame.size.width, _manager.dayViewHeight-10)];
        _titleLab.font = [UIFont systemFontOfSize:SYRealValue(28 / 2)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

@end
