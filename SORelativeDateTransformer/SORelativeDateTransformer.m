/*
 Created by William Garrison on 12/6/10.
 Copyright 2010-2012 Standard Orbit Software, LLC. All rights reserved.
 Derived in part from digdog's MIT-licensed NSDate-RelativeDate category method <https://github.com/digdog/NSDate-RelativeDate>
 
 This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License <http://creativecommons.org/licenses/by-sa/3.0/">
 Use it, hack it, but give me some love.
 */

#import "SORelativeDateTransformer.h"

#ifndef __has_feature
#define __has_feature(x) 0
#endif

@implementation SORelativeDateTransformer

+ (NSBundle *)bundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"SORelativeDateTransformer" withExtension:@"bundle"];
        bundle = [[NSBundle alloc] initWithURL:url];
    });
    return bundle;
}

static inline NSString *SORelativeDateLocalizedString(NSString *key, NSString *comment) {
    return [[SORelativeDateTransformer bundle] localizedStringForKey:key value:nil table:@"SORelativeDateTransformer"];
}

- (id) init
{
	self = [super init];
	if (!self) return nil;
    
    __calendar = [NSCalendar autoupdatingCurrentCalendar];

#if !__has_feature(objc_arc)
    [__calendar retain];
#endif
    
    __unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    __dateComponentSelectorNames =  [[NSArray alloc] initWithObjects:@"year", @"month", @"week", @"day", @"hour", @"minute", @"second", nil];
	
    __partialDateStrings = [[NSMutableArray alloc] init];
    _relativeTransformDepth = FirstMatchOnly;
    
	return self;
}

#if !__has_feature(objc_arc)
- (void) dealloc
{
	[__calendar release];
	[__dateComponentSelectorNames release];
    [__partialDateStrings release];
	[super dealloc];
}
#endif

#pragma mark -
#pragma mark NSValueTransformer Overrides

+ (Class) transformedValueClass
{
	return [NSString class];
}

+ (BOOL) allowsReverseTransformation
{
	// This is one-way transformer from NSDate -> NSString
	return NO;
}

- (id) transformedValue:(id)value
{
	// Return early if input is whacked
	if ([value isKindOfClass:[NSDate class]] == NO) {
		return SORelativeDateLocalizedString(@"now", @"label for current date-time");
	}
	
    // Clear any stored values
    [__partialDateStrings removeAllObjects];
    
	// Default return value is "now".
	
	id transformedValue = SORelativeDateLocalizedString(@"now", @"label for current date-time");
	
	// Obtain the date components for the relative difference between the input date and now.
	
	NSDateComponents *relativeDifferenceComponents = [__calendar components:__unitFlags fromDate:value toDate:[NSDate date] options:0];
	
	// Iterate the array of NSDateComponent selectors, which are sorted in decreasing order of time span: year, month, day, etc.
	// For the first NSDateComponent time span method that returns a reasonable non-zero value, use that value to compute the relative-to-now date phrase string.
	
	// Keep track of relative transform depth, compare against desired.
    RelativeTransformDepth currentDepth = FirstMatchOnly;
    BOOL isRelativePastDate;
    
	for (NSString *selectorName in __dateComponentSelectorNames)
	{
		// Invoke the NSDateComponent selector matching the current iteration, and obtain the component's value.
		NSInteger relativeDifference = 0;
		{
			SEL currentSelector = NSSelectorFromString(selectorName);
			NSInvocation *invoker = [NSInvocation invocationWithMethodSignature:[NSDateComponents instanceMethodSignatureForSelector:currentSelector]];
			[invoker setTarget:relativeDifferenceComponents];
			[invoker setSelector:currentSelector];
			[invoker invoke];
			
			// Get the value from the NSDateComponent invocation for the given calendar unit.
			
			[invoker getReturnValue:&relativeDifference];
		}
		
		// If the relative difference between the input date and now is 0 for the date component named in this iteration, press on.
		// e.g. no difference between the month component of input date and now, continue iterating with the hour component next to be evaluated.
		if (relativeDifference == 0) continue;
        
		// Lookup the localized name to use for the data component in our class' strings file.
		NSString *localizedDateComponentName = nil;
		{
			// Map the NSDateComponent method into a localization lookup key corresponding to a suitable calendar unit name, pluralizing the key as appropriate.
			// E.g. @selector(year) ==> "year", @selector(month) ==> "month"
			
			NSString *localizedDateComponentKey = selectorName;
			if (labs (relativeDifference) > 1) {
				localizedDateComponentKey = [NSString stringWithFormat:@"%@s", selectorName];
			}
			localizedDateComponentName = SORelativeDateLocalizedString(localizedDateComponentKey, nil);
		}
        
		// Generate the langugage-friendly phrase representing the relative difference between the input date and now.
        
		isRelativePastDate = (relativeDifference > 0); // positive values indicate a relative past date; negative values indicate a future date.
        
        // if current depth is not further than expected, collect value pair
        if (self.relativeTransformDepth >= currentDepth) {
            // collect the target phrase for later use
            NSString *template = SORelativeDateLocalizedString(@"formatTemplateSingleValuePair", nil);
            NSString *existing = [NSString stringWithFormat:template, labs (relativeDifference), localizedDateComponentName];
            [__partialDateStrings addObject:existing];
            currentDepth++;
        }
	} // for loop
	
    NSUInteger available = [__partialDateStrings count];
    if (available > 0) {
        transformedValue = [self transformForDepth:available-1
                                            isPast:isRelativePastDate];
    }
        
	return transformedValue;
}

- (NSString *)transformForDepth:(RelativeTransformDepth)currentDepth
                         isPast:(BOOL)isRelativePastDate {
    
    // Use the appropriate string formatting template depending on whether the given date is a relative past or a relative future date.
    NSMutableString *transformedValue = [NSMutableString string];
    NSString *templateForDepth;
    if (isRelativePastDate) {
        // Fetch the string format template for relative past dates from the localization file and crunch out a formatted string.
        templateForDepth = [NSString stringWithFormat:@"formatTemplateForRelativePastDatePhrase_Depth%i",currentDepth];
    } else {
        // Fetch the string format template for relative future dates from the localization file and crunch out a formatted string.
        templateForDepth = [NSString stringWithFormat:@"formatTemplateForRelativeFutureDatePhrase_Depth%i",currentDepth];
    }
    NSString *datePhraseTemplate = SORelativeDateLocalizedString(templateForDepth, nil);
    NSScanner *scanner = [NSScanner scannerWithString:datePhraseTemplate];
    scanner.charactersToBeSkipped = nil;
    NSString *target = nil;

    // Scan up to the %@, append the partial, move the scanner, repeat
    for (NSString *partialString in __partialDateStrings) {
        [scanner scanUpToString:@"%@" intoString:&target];
        if (!target) { // check to protect against %@ at the beginning of template
            target = @"";
        }
        target = [target stringByAppendingString:partialString];
        [scanner setScanLocation:scanner.scanLocation+2];
        [transformedValue appendString:target];
    }
    if (!scanner.isAtEnd) {
        [scanner scanUpToString:@"________fin__" intoString:&target];
        if (target) {
            [transformedValue appendString:target];
        }
    }
    return transformedValue;
}


@end
