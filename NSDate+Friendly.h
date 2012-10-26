//
//  NSDate+Friendly.h
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

#import <Foundation/Foundation.h>

// Time Constants
#define SECONDS_PER_MINUTE 60.0
#define MINUTES_PER_HOUR 60.0
#define SECONDS_PER_HOUR (SECONDS_PER_MINUTE * MINUTES_PER_HOUR)
#define HOURS_PER_DAY 24.0
#define SECONDS_PER_DAY (SECONDS_PER_HOUR * HOURS_PER_DAY)

@interface NSDate (Friendly)

// Time interval calculations
+ (bool)timeIntervalIsEqual:(NSTimeInterval)interval1 toInterval:(NSTimeInterval)interval2;
+ (NSInteger)timeIntervalMinutes:(NSTimeInterval)interval;
+ (NSInteger)timeIntervalHours:(NSTimeInterval)interval;
+ (NSInteger)timeIntervalDays:(NSTimeInterval)interval;

// Relative dates
+ (NSDate *)yesterday;
+ (NSDate *)tomorrow;

- (NSDate *)dateByAddingDays:(NSInteger)days;

// Relative date comparisons
- (bool)isSameDay:(NSDate *)anotherDate;
- (bool)isYesterday;
- (bool)isToday;
- (bool)isTomorrow;
- (NSInteger)monthsSinceDate:(NSDate *)anotherDate;
- (NSInteger)daysSinceDate:(NSDate *)anotherDate;
- (NSInteger)daysSinceNow;
- (NSInteger)hoursSinceDate:(NSDate *)anotherDate;
- (NSInteger)minutesSinceDate:(NSDate *)anotherDate;

// Strings
- (NSString *)monthYearString;
- (NSString *)monthString;
- (NSString *)yearString;
- (NSString *)friendlyString:(NSDateFormatter *)dateFormatter;

@end
