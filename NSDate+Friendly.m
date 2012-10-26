//
//  NSDate+Friendly.m
//  UtilKit
//
//  Copyright (c) 2012, Code of Intelligence, LLC
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of Code of Intelligence, LLC.
//

#import "NSDate+Friendly.h"

@implementation NSDate (Friendly)

#pragma mark - Class Methods

// Returns true if interval1 is close enough to interval2 to be considered equal.
+ (bool)timeIntervalIsEqual:(NSTimeInterval)interval1 toInterval:(NSTimeInterval)interval2
{
    return (fabs(interval1 - interval2) < 0.000001);
}

// Returns the number of minutes in interval by dividing the interval by the number of seconds in a minute.
+ (NSInteger)timeIntervalMinutes:(NSTimeInterval)interval
{
    return ((abs(interval) / SECONDS_PER_MINUTE));
}

// Returns the number of hours in interval by dividing the interval by the number of seconds in an hour.
+ (NSInteger)timeIntervalHours:(NSTimeInterval)interval
{
    return ((abs(interval) / SECONDS_PER_HOUR));
}

// Returns the number of days in interval by dividing the interval by the number of seconds in a day.
+ (NSInteger)timeIntervalDays:(NSTimeInterval)interval
{
    return ((abs(interval) / SECONDS_PER_DAY));
}

// Returns an NSDate object representing yesterday's date with the current time
+ (NSDate *)yesterday
{
    return [[NSDate date] dateByAddingDays:-1];
}

// Returns an NSDate object representing tomorrow's date with the current time
+ (NSDate *)tomorrow
{
    return [[NSDate date] dateByAddingDays:1];
}

#pragma mark - Instance Methods

// Returns an NSDate object representing the receiver's date and time plus days
- (NSDate *)dateByAddingDays:(NSInteger)days
{
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setDay:days];
	return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
}

// Returns true if the receiver is the same date as anotherDate using the current calendar
- (bool)isSameDay:(NSDate *)anotherDate
{
    return ([self daysSinceDate:anotherDate] == 0);
}

// Returns true if the receiver is the same calendar date as yesterday
- (bool)isYesterday
{
    return [self isSameDay:[NSDate yesterday]];
}

// Returns true if the receiver is the same calendar date as the current day
- (bool)isToday
{
    return [self isSameDay:[NSDate date]];
}

// Returns true if the receiver is the same calendar date as tomorrow
- (bool)isTomorrow
{
    return [self isSameDay:[NSDate tomorrow]];
}

// Returns the number of months between the receiver and anotherDate using the current calendar. If the receiver is earlier than anotherDate, the return value is negative.
- (NSInteger)monthsSinceDate:(NSDate *)anotherDate
{
    return [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:anotherDate toDate:self options:0] month];
}

// Returns the number of days between the receiver and anotherDate using the current calendar. If the receiver is earlier than anotherDate, the return value is negative.
- (NSInteger)daysSinceDate:(NSDate *)anotherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger startDay = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:anotherDate];
    NSInteger endDay = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSEraCalendarUnit forDate:self];
    return endDay - startDay;
}

// Returns the number of days between the receiver and the current date using the current calendar. If the receiver is earlier than anotherDate, the return value is negative.
- (NSInteger)daysSinceNow
{
    return [self daysSinceDate:[NSDate date]];
}

// Returns the number of hours between the receiver and anotherDate using the current calendar. If the receiver is earlier than anotherDate, the return value is negative.
- (NSInteger)hoursSinceDate:(NSDate *)anotherDate
{
    return [[[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:anotherDate toDate:self options:0] hour];
}

// Returns the number of minutes between the receiver and anotherDate using the current calendar. If the receiver is earlier than anotherDate, the return value is negative.
- (NSInteger)minutesSinceDate:(NSDate *)anotherDate
{
    return [[[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:anotherDate toDate:self options:0] minute];
}

// Returns a string containing the year followed by the first four characters of the month name using the "yMMMM" date format template.
- (NSString *)monthYearString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yMMMM" options:0 locale:[NSLocale currentLocale]];
	return [dateFormatter stringFromDate:self];
}

// Returns a string containing the first four characters of the month name using the "MMMM" date format.
- (NSString *)monthString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM"];
	return [dateFormatter stringFromDate:self];
}

// Returns a string containing the four-digit year using the "yyyy" date format.
- (NSString *)yearString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy"];
	return [dateFormatter stringFromDate:self];
}

// Returns a "human-friendly" string representing the receiver. If the optional dateFormatter is not nil, it will be used to create the date string if the date is on yesterday or tomorrow. Otherwise, return value will be the string "Yesterday" or "Tomorrow" respectively.
- (NSString *)friendlyString:(NSDateFormatter *)dateFormatter
{
    NSDate *now = [NSDate date];
    NSInteger days = [self daysSinceDate:now];
    if (days == -1)    // yesterday
    {
        if (dateFormatter)
            return [dateFormatter stringFromDate:self];
        return NSLocalizedString(@"Yesterday", @"Yesterday");
    }
    else if (days == 1)    // tomorrow
    {
        if (dateFormatter)
            return [dateFormatter stringFromDate:self];
        return NSLocalizedString(@"Tomorrow", @"Tomorrow");
    }
    else if (days == 0)  // today
    {
        NSInteger hours = [self hoursSinceDate:now];
        if (hours < 0)
        {
            if (hours == -1)
                return NSLocalizedString(@"an hour ago", @"an hour ago");
            return [NSString stringWithFormat:@"%d %@", -hours, NSLocalizedString(@"hours ago", @"hours ago")];
        }
        else if (hours == 0)
        {
            NSInteger minutes = [self minutesSinceDate:now];
            if (minutes < 0)
            {
                if (minutes == -1)
                    return NSLocalizedString(@"a minute ago", @"a minute ago");
                return [NSString stringWithFormat:@"%d %@", -minutes, NSLocalizedString(@"minutes ago", @"minutes ago")];
            }
            if (minutes == 0)
            {
                NSInteger seconds = [self timeIntervalSinceDate:now];
                if (seconds < 0)
                {
                    if (seconds == -1)
                        return NSLocalizedString(@"a second ago", @"a second ago");
                    return [NSString stringWithFormat:@"%d %@", -(NSInteger)seconds, NSLocalizedString(@"seconds ago", @"seconds ago")];
                }
                if (seconds == 0)
                    return NSLocalizedString(@"just now", @"just now");
                if (seconds == 1)
                    return NSLocalizedString(@"a second away", @"a second away");
                return [NSString stringWithFormat:@"%d %@", (NSInteger)seconds, NSLocalizedString(@"seconds away", @"seconds away")];
            }
            if (minutes == 1)
                return NSLocalizedString(@"a minute away", @"a minute away");
            return [NSString stringWithFormat:@"%d %@", minutes, NSLocalizedString(@"minutes away", @"minutes away")];
        }
        else if (hours == 1)
        {
            return NSLocalizedString(@"an hour away", @"an hour away");
        }
        else
        {
            return [NSString stringWithFormat:@"%d %@", hours, NSLocalizedString(@"hours away", @"hours away")];
        }
    }
    else if (days < 0)
        return [NSString stringWithFormat:@"%d %@", -days, NSLocalizedString(@"days ago", @"days ago")];
    else
        return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"days away", @"days away")];
}

@end
