//
//  NSString+RegularExpression.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/18.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "NSString+RegularExpression.h"

@implementation NSString (RegularExpression)


#pragma mark -- 验证身份证号有效性
- (BOOL)validateIDCardNumber:(NSString *)idCardNumber {
    idCardNumber = [idCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!idCardNumber) {
        return NO;
    }else {
        length = idCardNumber.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [idCardNumber substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [idCardNumber substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            }else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, idCardNumber.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [idCardNumber substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, idCardNumber.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [idCardNumber substringWithRange:NSMakeRange(0,1)].intValue*7 + [idCardNumber substringWithRange:NSMakeRange(10,1)].intValue *7 + [idCardNumber substringWithRange:NSMakeRange(1,1)].intValue*9 + [idCardNumber substringWithRange:NSMakeRange(11,1)].intValue *9 + [idCardNumber substringWithRange:NSMakeRange(2,1)].intValue*10 + [idCardNumber substringWithRange:NSMakeRange(12,1)].intValue *10 + [idCardNumber substringWithRange:NSMakeRange(3,1)].intValue*5 + [idCardNumber substringWithRange:NSMakeRange(13,1)].intValue *5 + [idCardNumber substringWithRange:NSMakeRange(4,1)].intValue*8 + [idCardNumber substringWithRange:NSMakeRange(14,1)].intValue *8 + [idCardNumber substringWithRange:NSMakeRange(5,1)].intValue*4 + [idCardNumber substringWithRange:NSMakeRange(15,1)].intValue *4 + [idCardNumber substringWithRange:NSMakeRange(6,1)].intValue*2 + [idCardNumber substringWithRange:NSMakeRange(16,1)].intValue *2 + [idCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                
                NSString *lastStr = [idCardNumber substringWithRange:NSMakeRange(17,1)];
                
                NSLog(@"%@",M);
                NSLog(@"%@",[idCardNumber substringWithRange:NSMakeRange(17,1)]);
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    
                    if ([M isEqualToString:[idCardNumber substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                    
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

- (NSArray *)provinceArr {
    NSArray *pArr = @[
                      @"11",//北京市|110000，
                      @"12",//天津市|120000，
                      @"13",//河北省|130000，
                      @"14",//山西省|140000，
                      @"15",//内蒙古自治区|150000，
                      @"21",//辽宁省|210000，
                      @"22",//吉林省|220000，
                      @"23",//黑龙江省|230000，
                      @"31",//上海市|310000，
                      @"32",//江苏省|320000，
                      @"33",//浙江省|330000，
                      @"34",//安徽省|340000，
                      @"35",//福建省|350000，
                      @"36",//江西省|360000，
                      @"37",//山东省|370000，
                      @"41",//河南省|410000，
                      @"42",//湖北省|420000，
                      @"43",//湖南省|430000，
                      @"44",//广东省|440000，
                      @"45",//广西壮族自治区|450000，
                      @"46",//海南省|460000，
                      @"50",//重庆市|500000，
                      @"51",//四川省|510000，
                      @"52",//贵州省|520000，
                      @"53",//云南省|530000，
                      @"54",//西藏自治区|540000，
                      @"61",//陕西省|610000，
                      @"62",//甘肃省|620000，
                      @"63",//青海省|630000，
                      @"64",//宁夏回族自治区|640000，
                      @"65",//新疆维吾尔自治区|650000，
                      @"71",//台湾省（886)|710000,
                      @"81",//香港特别行政区（852)|810000，
                      @"82",//澳门特别行政区（853)|820000
                      @"91",//国外
                      ];
    return pArr;
}

- (BOOL)isAreaCode:(NSString *)province {
    //在provinceArr中找
    NSArray *arr = [self provinceArr];
    int a = 0;
    for (NSString *pr in arr) {
        if ([pr isEqualToString:province]) {
            a ++;
        }
    }
    if (a == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)getStringWithRange:(NSString *)str Value1:(int)v1 Value2:(int)v2 {
    NSString *sub = [str substringWithRange:NSMakeRange(v1, v2)];
    return sub;
}

#pragma mark -- 根据身份证判断性别
- (NSString *)sexStringIdentifyCard:(NSString *)cardNumber {
    NSString *result = nil;
    if ([cardNumber length] < 17) {
        return result;
    }
    //截取第17位为性别识别符
    NSString *fontNumber = [cardNumber substringWithRange:NSMakeRange(16, 1)];
    //检测是否是数字
    if ([fontNumber integerValue] %2 == 1) {
        result = @"男";
    }else if ([fontNumber integerValue] %2 == 0) {
        result = @"女";
    }
    return result;
}

#pragma mark -- 验证银行卡号有效性
/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)bankCardluhmCheck {
    NSString *lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString *forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardNum.length; i++) {
        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count - 1); i > -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray *arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray *arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray *arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i = 0; i < forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 == 0)?YES:NO;
}

#pragma mark -- 验证邮箱的有效性
- (BOOL)isEmailAddress {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

#pragma mark -- 验证是否有特殊符号
- (BOOL)effectivePassword {
    NSString *regex2 = @"[a-zA-Z0-9]{6,20}";
    return [self isValidateByRegex:regex2];
}

#pragma mark -- 验证密码是否有效
- (BOOL)isValidPassword {
    //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    NSString *regex = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,18}$";
    return [self isValidateByRegex:regex];
}

#pragma mark -- 验证手机号有效性
- (BOOL)isMobileNumberClassification {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700
     */
    
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\\\d|705)\\\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186,1709
     */
    NSString *CU = @"^1((3[0-2]|5[256]|8[56])\\\\d|709)\\\\d{7}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189,1700
     */
    NSString *CT = @"^1((33|53|8[09])\\\\d|349|700)\\\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSString *PHS = @"^0(10|2[0-5789]|\\\\d{3})\\\\d{7,8}$";
    
    if (([self isValidateByRegex:CM]) || ([self isValidateByRegex:CU]) || ([self isValidateByRegex:CT])  || ([self isValidateByRegex:PHS])) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -- 验证是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth maxLenth:(NSInteger)maxLenth containChinese:(BOOL)containChinese firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    NSString *hanzi = containChinese ? @"\\u4e00-\\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";

    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth - 1), (int)(maxLenth - 1)];
    return [self isValidateByRegex:regex];
}

#pragma mark -- 验证是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth maxLenth:(NSInteger)maxLenth containChinese:(BOOL)containChinese containDigtal:(BOOL)containDigtal containLetter:(BOOL)containLetter containOtherCharacter:(NSString *)containOtherCharacter firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    NSString *hanzi = containChinese ? @"\\u4e00-\\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self isValidateByRegex:regex];
}




#pragma mark -- 匹配正则表达式的一些简单封装
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

/**
 是否能够匹配正则表达式
 
 @param regex  正则表达式
 @param options     普配方式.
 @return YES：如果可以匹配正则表达式; 否则,NO.
 */
- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:NULL];
    if (!pattern) return NO;
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

/**
 匹配正则表达式，并使用匹配的每个对象执行给定的块。
 
 @param regex    正则表达式
 @param options  上报的匹配选项.
 @param block    应用于在数组元素中匹配的块.
 该块需要四个参数:
 match: 匹配的子串.
 matchRange: 匹配选项.
 stop: 一个布尔值的引用。块可以设置YES来停止处理阵列。stop参数是一个唯一的输出。你应该给块设置YES。
 */
- (void)enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block {
    if (regex.length == 0 || !block) return;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!regex) return;
    [pattern enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

/**
 返回一个包含匹配正则表达式的新字符串替换为模版字符串。
 
 @param regex       正则表达式
 @param options     上报的匹配选项.
 @param replacement 用来替换匹配到的内容.
 
 @return 返回一个用指定字符串替换匹配字符串后的字符串.
 */
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) return self;
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

#pragma 正则匹配手机号
- (BOOL)validateCellPhoneNumber:(NSString *)cellNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,173,177,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,173,177,180,189
     22         */
    NSString * CT = @"^1((33|53|73|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if(([regextestmobile evaluateWithObject:cellNum] == YES)
       || ([regextestcm evaluateWithObject:cellNum] == YES)
       || ([regextestct evaluateWithObject:cellNum] == YES)
       || ([regextestcu evaluateWithObject:cellNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

// 判断长度大于8位，且必须包含数字、字母和特殊h符号的其中2种
- (BOOL)judgePassWordLegal:(NSString *)pass {
    BOOL result = false;
    if ([pass length] >= 8 && [pass length] <= 20){
        NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

@end
