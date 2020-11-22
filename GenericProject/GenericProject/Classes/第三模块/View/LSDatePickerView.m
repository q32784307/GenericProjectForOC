//
//  LSDatePickerView.m
//  GenericProject
//
//  Created by 李帅 on 2020/11/20.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSDatePickerView.h"

@interface LSDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)NSMutableArray *yearArray;
@property(nonatomic,strong)NSMutableArray *monthArray;
@property(nonatomic,strong)NSMutableArray *dayArray;
@property(nonatomic,assign)NSInteger currentYear;
@property(nonatomic,assign)NSInteger currentMonth;
@property(nonatomic,assign)NSInteger currentDay;
@property(nonatomic,copy)NSString *selectedYear;
@property(nonatomic,copy)NSString *selectecMonth;
@property(nonatomic,copy)NSString *selectecDay;

@end

@implementation LSDatePickerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self getCurrentDate];
        [self setYearArray];
        [self setMonthArray];
        [self setDayArray];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.2;
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - SYRealValue(500 / 2) - HOME_INDICATOR_HEIGHT, ScreenWidth, SYRealValue(500 / 2) + HOME_INDICATOR_HEIGHT)];
    self.bgView.backgroundColor = [UIColor colorWithRed:240.0/255 green:243.0/255 blue:250.0/255 alpha:1];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SYRealValue(80 / 2))];
    whiteView.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    [self.bgView addSubview:whiteView];
    
    UIButton *closeButton = [[UIButton alloc]init];
    [closeButton setTitle:@"取消" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor colorWithRed:97.0 / 255.0 green:97.0 / 255.0 blue:97.0 / 255.0 alpha:1] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whiteView.mas_centerY);
        make.left.equalTo(whiteView).with.offset(SYRealValue(30 / 2));
    }];
    
    UIButton *determineButton = [[UIButton alloc]init];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton setTitleColor:RedColor forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineAction) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:determineButton];
    [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whiteView.mas_centerY);
        make.right.equalTo(whiteView.mas_right).with.offset(SYRealValue(-30 / 2));
    }];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor colorWithRed:240.0/255 green:243.0/255 blue:250.0/255 alpha:1];
    [pickerView selectRow:[self.selectedYear integerValue] - 1970 inComponent:0 animated:YES];
    [pickerView selectRow:[self.selectecMonth integerValue] - 1 inComponent:1 animated:YES];
    [pickerView selectRow:[self.selectecDay integerValue] - 1 inComponent:2 animated:YES];
    [self.bgView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_bottom).with.offset(SYRealValue(30 / 2));
        make.left.equalTo(whiteView).with.offset(0);
        make.right.equalTo(whiteView.mas_right).with.offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom).with.offset(SYRealValue(-30 / 2) - HOME_INDICATOR_HEIGHT);
    }];
}

#pragma mark - pickerView显示
- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlert)]];
    //遮罩
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5;
    }];
    [window addSubview:self.bgView];
    
    self.bgView.transform = CGAffineTransformMakeTranslation(0.01, ScreenWidth);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
}

#pragma mark - pickerView消失
- (void)dismissAlert {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.transform = CGAffineTransformMakeTranslation(0.01, ScreenWidth);
        self.bgView.alpha = 0.2;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
    }];
}

- (void)closeAction {
    [self dismissAlert];
}

- (void)determineAction {
    [self dismissAlert];
}

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
    } else if (component == 1) {
        return self.monthArray.count;
    } else {
        return self.dayArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray[row];
    } else if (component == 1) {
        return self.monthArray[row];
    } else {
        return self.dayArray[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedYear = self.yearArray[row];
        [self setMonthArray];
        [self setDayArray];
        self.selectecMonth = [NSString stringWithFormat:@"%ld",(long)self.currentMonth];
        self.selectecDay = [NSString stringWithFormat:@"%ld",(long)self.currentDay];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    } else if (component == 1) {
        self.selectecMonth = self.monthArray[row];
        [self setDayArray];
        self.selectecDay = [NSString stringWithFormat:@"%ld",(long)self.currentDay];
        [pickerView reloadComponent:2];
    } else {
        self.selectecDay = self.dayArray[row];
    }
}

- (void)getCurrentDate {
    //获取当前时间 （时间格式支持自定义）
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    
    self.currentYear = [[dateArray firstObject]integerValue];
    self.currentMonth =  [dateArray[1] integerValue];
    self.currentDay = [dateArray[2] integerValue];
    
    self.selectedYear = [NSString stringWithFormat:@"%ld",(long)self.currentYear];
    self.selectecMonth = [NSString stringWithFormat:@"%ld",(long)self.currentMonth];
    self.selectecDay = [NSString stringWithFormat:@"%ld",(long)self.currentDay];
}

- (void)setYearArray {
    //初始化年数据源数组
    self.yearArray = [NSMutableArray array];
    
    for (NSInteger i = self.currentYear; i <= 2050 ; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%ld年",(long)i];
        [self.yearArray addObject:yearStr];
    }
}

- (void)setMonthArray {
    //初始化月数据源数组
    self.monthArray = [NSMutableArray array];
    
    if ([[self.selectedYear substringWithRange:NSMakeRange(0, 4)] isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.currentYear]]) {
        for (NSInteger i = self.currentMonth ; i <= 12; i++) {
            NSString *monthStr = [NSString stringWithFormat:@"%ld月",(long)i];
            [self.monthArray addObject:monthStr];
        }
    } else {
        for (NSInteger i = 1 ; i <= 12; i++) {
            NSString *monthStr = [NSString stringWithFormat:@"%ld月",(long)i];
            [self.monthArray addObject:monthStr];
        }
    }
}

- (void)setDayArray {
    self.dayArray = [NSMutableArray array];

    if ([[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.currentMonth]]) {
        if ([[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"1"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"3"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"5"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"7"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"8"] || [self.selectecMonth isEqualToString:@"10"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"12"]) {
            for (NSInteger i = self.currentDay; i <= 31; i++) {
                NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                [self.dayArray addObject:dayStr];
            }
        }else if ([[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"4"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"6"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"9"] || [[self.selectecMonth substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"11"]) {
            for (NSInteger i = self.currentDay; i <= 30; i++) {
                NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                [self.dayArray addObject:dayStr];
            }
        }else{
            if ([[self.selectedYear substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"00"]) {
                if ([[self.selectedYear substringWithRange:NSMakeRange(0, 4)] integerValue] % 400 == 0) {
                    for (NSInteger i = self.currentDay; i <= 29; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }else{
                    for (NSInteger i = self.currentDay; i <= 28; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }
            }else{
                if ([[self.selectedYear substringWithRange:NSMakeRange(0, 4)] integerValue] % 4 == 0) {
                    for (NSInteger i = self.currentDay; i <= 29; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }else{
                    for (NSInteger i = self.currentDay; i <= 28; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }
            }
        }
    }else{
        if ([self.selectecMonth isEqualToString:@"1月"] || [self.selectecMonth isEqualToString:@"3月"] || [self.selectecMonth isEqualToString:@"5月"] || [self.selectecMonth isEqualToString:@"7月"] || [self.selectecMonth isEqualToString:@"8月"] || [self.selectecMonth isEqualToString:@"10月"] || [self.selectecMonth isEqualToString:@"12月"]) {
            for (NSInteger i = 1; i <= 31; i++) {
                NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                [self.dayArray addObject:dayStr];
            }
        }else if ([self.selectecMonth isEqualToString:@"4月"] || [self.selectecMonth isEqualToString:@"6月"] || [self.selectecMonth isEqualToString:@"9月"] || [self.selectecMonth isEqualToString:@"11月"]) {
            for (NSInteger i = 1; i <= 30; i++) {
                NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                [self.dayArray addObject:dayStr];
            }
        }else{
            NSLog(@"截取的是--%@",[self.selectedYear substringWithRange:NSMakeRange(2, 2)]);
            if ([[self.selectedYear substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"00"]) {
                if ([[self.selectedYear substringWithRange:NSMakeRange(0, 4)] integerValue] % 400 == 0) {
                    for (NSInteger i = 1; i <= 29; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }else{
                    for (NSInteger i = 1; i <= 28; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }
            }else{
                if ([[self.selectedYear substringWithRange:NSMakeRange(0, 4)] integerValue] % 4 == 0) {
                    for (NSInteger i = 1; i <= 29; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }else{
                    for (NSInteger i = 1; i <= 28; i++) {
                        NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
                        [self.dayArray addObject:dayStr];
                    }
                }
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
