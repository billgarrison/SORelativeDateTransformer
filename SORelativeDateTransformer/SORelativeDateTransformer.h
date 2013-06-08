/*
 Created by William Garrison on 12/6/10.
 Copyright 2010-2012 Standard Orbit Software, LLC. All rights reserved.
 Derived in part from digdog's MIT-licensed NSDate-RelativeDate category method <https://github.com/digdog/NSDate-RelativeDate>
 
 This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License <http://creativecommons.org/licenses/by-sa/3.0/">
 Use it, hack it, but give me some love.
 */


/**
SORelativeDateTransformer is a value transformer that generates a human-readable phrase expressing the relative difference between a given date and the current date.
 
 For example, when the current date-time is 2010-12-05 11:30, then
 ...the date 2010-12-04 11:00 is transformed to "30 minutes ago"
 ...the date 2010-12-01 11:00 is transformed to "5 days ago"
 ...the date 2010-12-25 8:00 is transformed to "in 2 weeks"
 
 The transformer does not provide reverse transformations; you can only transform from an NSDate to an NSString.
 
 Localization:
 The accompanying SORelativeDateTransformer.strings file provides English localizations for the date component names and their plural forms.
 The strings file also contains a localized string format template to use for relative past and future dates.  
 For past dates, the template for the English phrase is "%d %@ ago". For future dates, the template is "in %d %@".
 
 Copy and modify the SORelativeDateTransformer.strings file with your own localizations.
 */

#import <Foundation/Foundation.h>

@interface SORelativeDateTransformer : NSValueTransformer
{
	NSCalendar *__calendar;
	NSUInteger __unitFlags;
	NSArray *__dateComponentSelectorNames;
}

/**
\brief Transform an NSDate into a phrase expressing the relative difference between that date and now.
\param value An NSDate to be compared to the current date.
\return An NSString with the generated and localized phrase.
*/
- (id) transformedValue:(id)value;
+ (id) transformedValue:(id)value;

@end
