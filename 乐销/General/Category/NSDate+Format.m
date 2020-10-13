//
//  NSDate+Format.m
//  NSDate
//
//  Created by C.Maverick on 15/6/7.
//  Copyright (c) 2015年 C.Maverick. All rights reserved.
//

#import "NSDate+Format.h"
#import "NSDate+YYAdd.h"

@implementation NSDate (Format)

@dynamic year;
@dynamic month;
@dynamic day;
@dynamic hour;
@dynamic minute;
@dynamic second;
@dynamic weekday;

- (NSInteger)year {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self].year;
}
- (NSInteger)month {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self].month;
}
- (NSInteger)day {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self].day;
}
- (NSInteger)hour {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self].hour;
}
- (NSInteger)minute {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self].minute;
}
- (NSInteger)second {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self].second;
}
- (NSInteger)weekday {
    //这里会差一天 我也是醉了
    NSInteger week = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self].weekday;
    week = week - 1;
    return week ?: 7;
}
- (NSString*)weekdayStr {
    NSString *weekday = nil;
    NSInteger week = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self].weekday;
    week = week - 1;
    switch (week ?: 7) {
        case 1:weekday = @"周一";break;
        case 2:weekday = @"周二";break;
        case 3:weekday = @"周三";break;
        case 4:weekday = @"周四";break;
        case 5:weekday = @"周五";break;
        case 6:weekday = @"周六";break;
        default:weekday = @"周日"; break;
    }
    return weekday;
}

- (NSString *)stringWithDateFormat:(NSString *)format {
#if 0
    
    NSTimeInterval time = [self timeIntervalSince1970];
    NSUInteger timeUint = (NSUInteger)time;
    return [[NSNumber numberWithUnsignedInteger:timeUint] stringWithDateFormat:format];
    
#else
    
    // thansk @lancy, changed: "NSDate depend on NSNumber" to "NSNumber depend on NSDate"
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
    
#endif
}

- (NSString *)timeAgo {
    NSTimeInterval perDayInter=24*HOUR;
    NSDate *today=[NSDate date];//今天
    NSDate *yesterday=[today dateByAddingTimeInterval:-perDayInter];//昨天
    
    //前10个字节 就是当天的日期  做日期之间的比对
    NSString *todayStr=[[today description] substringToIndex:10];
    NSString *yesterdayStr=[[yesterday description] substringToIndex:10];
    NSString *currentDayStr=[[self description] substringToIndex:10];
    
    NSString *result=[self stringWithDateFormat:@"yy/MM/dd HH:mm"];
    if ([currentDayStr isEqualToString:todayStr]) {
        //当前日期是今天
        result=[self stringWithDateFormat:@"HH:mm"];
    }
    else if ([currentDayStr isEqualToString:yesterdayStr]) {
        result=[NSString stringWithFormat:@"昨天 %@",[self stringWithDateFormat:@"HH:mm"]];
    }
    return result;
}

- (NSString *)timeAgo4Dialog {
    NSDate *date1 = [NSDate date];//今天
    NSDate *date2 = [date1 dateByAddingTimeInterval:-DAY];//昨天
    NSDate *date3 = [date2 dateByAddingTimeInterval:-DAY];//前天
    NSDate *date4 = [date3 dateByAddingTimeInterval:-DAY];//上上前天
    NSDate *date5 = [date4 dateByAddingTimeInterval:-DAY];//上上上前天
    NSDate *date6 = [date5 dateByAddingTimeInterval:-DAY];//上上上上前天
    NSDate *date7 = [date6 dateByAddingTimeInterval:-DAY];//上上上上上前天
    
    //前10个字节 就是当天的日期  做日期之间的比对
    NSString *todayStr1 = [[date1 description] substringToIndex:10];
    NSString *todayStr2 = [[date2 description] substringToIndex:10];
    NSString *todayStr3 = [[date3 description] substringToIndex:10];
    NSString *todayStr4 = [[date4 description] substringToIndex:10];
    NSString *todayStr5 = [[date5 description] substringToIndex:10];
    NSString *todayStr6 = [[date6 description] substringToIndex:10];
    NSString *todayStr7 = [[date7 description] substringToIndex:10];
    
    
    NSString *nowStr = [[self description] substringToIndex:10];
    
    NSString *weekday = @"";
    switch ([self weekday]) {
        case 1: weekday = @"星期日"; break;
        case 2: weekday = @"星期一"; break;
        case 3: weekday = @"星期二"; break;
        case 4: weekday = @"星期三"; break;
        case 5: weekday = @"星期四"; break;
        case 6: weekday = @"星期五"; break;
        case 7: weekday = @"星期六"; break;
        default:
            break;
    }
    
    NSString *result = [self stringWithDateFormat:@"yy/MM/dd"];
    if ([nowStr isEqualToString:todayStr1]) {
        result = [self stringWithDateFormat:@"HH:mm"];
    }
    else if ([nowStr isEqualToString:todayStr2]) {
        result = [NSString stringWithFormat:@"昨天 %@",[self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr3]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr4]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr5]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr6]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr7]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else {
        result = [self stringWithDateFormat:@"yy/MM/dd"];
    }
    return result;
}

- (NSString *)timeAgo4Chat {
    NSDate *date1 = [NSDate date];//今天
    NSDate *date2 = [date1 dateByAddingTimeInterval:-DAY];//昨天
    NSDate *date3 = [date2 dateByAddingTimeInterval:-DAY];//前天
    NSDate *date4 = [date3 dateByAddingTimeInterval:-DAY];//上上前天
    NSDate *date5 = [date4 dateByAddingTimeInterval:-DAY];//上上上前天
    NSDate *date6 = [date5 dateByAddingTimeInterval:-DAY];//上上上上前天
    NSDate *date7 = [date6 dateByAddingTimeInterval:-DAY];//上上上上上前天
    
    //前10个字节 就是当天的日期  做日期之间的比对
    NSString *todayStr1 = [[date1 description] substringToIndex:10];
    NSString *todayStr2 = [[date2 description] substringToIndex:10];
    NSString *todayStr3 = [[date3 description] substringToIndex:10];
    NSString *todayStr4 = [[date4 description] substringToIndex:10];
    NSString *todayStr5 = [[date5 description] substringToIndex:10];
    NSString *todayStr6 = [[date6 description] substringToIndex:10];
    NSString *todayStr7 = [[date7 description] substringToIndex:10];
    
    
    NSString *nowStr = [[self description] substringToIndex:10];
    
    NSString *weekday = @"";
    switch ([self weekday]) {
        case 1: weekday = @"星期日"; break;
        case 2: weekday = @"星期一"; break;
        case 3: weekday = @"星期二"; break;
        case 4: weekday = @"星期三"; break;
        case 5: weekday = @"星期四"; break;
        case 6: weekday = @"星期五"; break;
        case 7: weekday = @"星期六"; break;
        default:
            break;
    }
    
    NSString *result = [self stringWithDateFormat:@"yy/MM/dd"];
    if ([nowStr isEqualToString:todayStr1]) {
        result = [self stringWithDateFormat:@"HH:mm"];
    }
    else if ([nowStr isEqualToString:todayStr2]) {
        result = [NSString stringWithFormat:@"昨天 %@",[self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr3]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr4]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr5]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr6]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else if ([nowStr isEqualToString:todayStr7]) {
        result = [NSString stringWithFormat:@"%@ %@", weekday, [self stringWithDateFormat:@"HH:mm"]];
    }
    else {
        result = [self stringWithDateFormat:TIME_MIN_SHOW];
    }
    return result;
}


//- (NSString *)timeAgo
//{
//	NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:self];
//
//	if (delta < 1 * MINUTE)
//	{
//		return @"刚刚";
//	}
//	else if (delta < 2 * MINUTE)
//	{
//		return @"1分钟前";
//	}
//	else if (delta < 45 * MINUTE)
//	{
//		int minutes = floor((double)delta/MINUTE);
//		return [NSString stringWithFormat:@"%d分钟前", minutes];
//	}
//	else if (delta < 90 * MINUTE)
//	{
//		return @"1小时前";
//	}
//	else if (delta < 24 * HOUR)
//	{
//		int hours = floor((double)delta/HOUR);
//		return [NSString stringWithFormat:@"%d小时前", hours];
//	}
//	else if (delta < 48 * HOUR)
//	{
//		return @"昨天";
//	}
//	else if (delta < 30 * DAY)
//	{
//		int days = floor((double)delta/DAY);
//		return [NSString stringWithFormat:@"%d天前", days];
//	}
//	else if (delta < 12 * MONTH)
//	{
//		int months = floor((double)delta/MONTH);
//		return months <= 1 ? @"1个月前" : [NSString stringWithFormat:@"%d个月前", months];
//	}
//
//	int years = floor((double)delta/MONTH/12.0);
//	return years <= 1 ? @"1年前" : [NSString stringWithFormat:@"%d年前", years];
//}

- (NSString *)resultWithFormat:(NSString *)format {
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone localTimeZone]];
    [formatter1 setDateFormat:format];
    NSString * result = [formatter1 stringFromDate:self];
    return result;
}

- (NSString *)timeLeft {
    long int delta = lround( [self timeIntervalSinceDate:[NSDate date]] );
    
    NSMutableString * result = [NSMutableString string];
    
    if ( delta >= YEAR ) {
        NSInteger years = ( delta / YEAR );
        [result appendFormat:@"%ld年", (long)years];
        delta -= years * YEAR ;
    }
    
    if ( delta >= MONTH ) {
        NSInteger months = ( delta / MONTH );
        [result appendFormat:@"%ld月", (long)months];
        delta -= months * MONTH ;
    }
    
    if ( delta >= DAY ) {
        NSInteger days = ( delta / DAY );
        [result appendFormat:@"%ld天", (long)days];
        delta -= days * DAY ;
    }
    
    if ( delta >= HOUR ) {
        NSInteger hours = ( delta / HOUR );
        [result appendFormat:@"%ld小时", (long)hours];
        delta -= hours * HOUR ;
    }
    
    if ( delta >= MINUTE ) {
        NSInteger minutes = ( delta / MINUTE );
        [result appendFormat:@"%ld分钟", (long)minutes];
        delta -= minutes * MINUTE ;
    }
    
    NSInteger seconds = ( delta / SECOND );
    [result appendFormat:@"%ld秒", (long)seconds];
    
    return result;
}
- (NSDate*)firstTime {
    int64_t currSecond = self.timeIntervalSince1970;
    currSecond = currSecond - self.hour * 60 * 60;//算出今天凌晨时间
    NSDate * currDate = [NSDate dateWithTimeIntervalSince1970:currSecond];
    return currDate;
}
- (NSDate*)lastTime {
    int64_t currSecond = self.timeIntervalSince1970;
    currSecond = currSecond - self.hour * 60 * 60;//算出今天凌晨时间
    currSecond = currSecond + (24 * 60 * 60);
    currSecond = currSecond - 1;//算出明天天凌晨时间 -1是为了不要和明天的时间冲突
    NSDate * currDate = [NSDate dateWithTimeIntervalSince1970:currSecond];
    return currDate;
    
}
+ (NSDate*)dateWithFormat:(NSString *)format
{
    NSDateFormatter * df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date =[df2 dateFromString:format];
    return date;
}

+ (long long)timeStamp {
    return (long long)[[NSDate date] timeIntervalSince1970];
}

+ (NSDate *)now {
    return [NSDate date];
}
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}
@end
