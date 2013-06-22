/*
 Created by William Garrison on 12/6/10.
 Copyright Standard Orbit Software, LLC. All rights reserved.
 Derived in part from digdog's MIT-licensed NSDate-RelativeDate category method <https://github.com/digdog/NSDate-RelativeDate>
 
 This code is MIT-licensed. Use it, hack it, but give me some love.
 */

#import "SORelativeDateTransformer.h"

@implementation SORelativeDateTransformer

+ (NSValueTransformer *) registeredTransformer
{
    return [NSValueTransformer valueTransformerForName:NSStringFromClass(self)];
}

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
	
	return self;
}

#if !__has_feature(objc_arc)
- (void) dealloc
{
	[__calendar release];
	[__dateComponentSelectorNames release];
	[super dealloc];
}
#endif

#pragma mark - NSValueTransformer Overrides

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
	
	id transformedValue = nil;
	
	// Obtain the date components for the relative difference between the input date and now.
	
	NSDateComponents *relativeDifferenceComponents = [__calendar components:__unitFlags fromDate:value toDate:[NSDate date] options:0];
	
	// Iterate the array of NSDateComponent selectors, which are sorted in decreasing order of time span: year, month, day, etc.
	// For the first NSDateComponent time span method that returns a reasonable non-zero value, use that value to compute the relative-to-now date phrase string.
	
	
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
		// e.g. no difference between the month component of input date and now, continue iterating with the week component next to be evaluated.
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
        
		BOOL isRelativePastDate = (relativeDifference > 0); // positive values indicate a relative past date; negative values indicate a future date.
		
		// Use the appropriate string formatting template depending on whether the given date is a relative past or a relative future date.
        
		if (isRelativePastDate) {
			// Fetch the string format template for relative past dates from the localization file and crunch out a formatted string.
			NSString *pastDatePhraseTemplate = SORelativeDateLocalizedString(@"formatTemplateForRelativePastDatePhrase", nil);
			transformedValue = [NSString stringWithFormat:pastDatePhraseTemplate, relativeDifference, localizedDateComponentName];
		} else {
			// Fetch the string format template for relative future dates from the localization file and crunch out a formatted string.
			NSString *futureDatePhraseTemplate = SORelativeDateLocalizedString(@"formatTemplateForRelativeFutureDatePhrase", nil);
			transformedValue = [NSString stringWithFormat:futureDatePhraseTemplate, labs (relativeDifference), localizedDateComponentName];
		}
		
		// Break from the date components iteration loop after finding the first one with a non-zero relative difference value.
		break;
		
	} // for loop
	
	// Default return value is "now".
	if (!transformedValue) {
		transformedValue = SORelativeDateLocalizedString(@"now", @"label for current date-time");
	}
	
	return transformedValue;
}


@end
