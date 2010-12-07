# SORelativeDateTransformer #

SORelativeDateTransformer is a value transformer that generates a human-readable phrase expressing the relative difference between a given date and the current date.


For example, when the current date-time is 2010-12-05 11:30, then

... 2010-12-04 11:00 is transformed to "30 minutes ago"

... 2010-12-01 11:00 is transformed to "5 days ago"

... 2010-12-25 08:00 is transformed to "in 2 weeks"

The transformer does not provide reverse transformations; you can only transform from an NSDate to an NSString.

## How To Use ##

Add the header and implementation files to your project.

	SORelativeDateTransformer.h
	SORelativeDateTransformer.m
	
If you want a localization other than English, also add the .strings file.

	SORelativeDataTransformer.strings
	

Instantiate an instance of SORelativeDateTransformer wherever you need to generate relative date phrases.

	// Display a file's creation date relative to today's date
	NSURL *someFilePath = ...;
	NSDictionary *fileAttribs = [[NSFileManager defaultManager] attributesOfItemAtPath:someFilePath error:NULL];
	
	NSDate *dateModified = [fileAttribs fileModificationDate];
	
	// Date modified is 2010-10-01 12:00:00TZ; current date is 2010-10-30 12:00:00TZ
	
	SORelativeDateTransformer *relativeDateTransformer = [[SORelativeDateTransformer alloc] init];
	NSString *relativeDate = [relativeDateTransformer transformedValue: dateModified];
	
	NSLog (@"This file was modified %@.", relativeDate); // ==> "This file was modified 3 weeks ago."
	
## Localization ##


The accompanying `SORelativeDateTransformer.strings` file provides localizations for the date component names and their plural forms. Included are localization files for English, French, German, and Spanish.

The strings file also contains a localized string format template to use for relative past and future dates.  
For past dates, the template for the English phrase is "%d %@ ago". For future dates, the template is "in %d %@".

Copy and modify the `SORelativeDateTransformer.strings` file with your own localizations.

## Tester App ##

Included is an iOS 4 interactive testing application. You can a date from the date picker and see the generated relative date string below.

## Compatibility ##

SORelativeDateTransformer should be usable on iOS 3 and later, and Mac OS X 10.3 and later.

## License ##

Use it, hack it, but give me some love.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">SORelativeDateFormatter</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://github.com/billgarrison" property="cc:attributionName" rel="cc:attributionURL">William Garrison</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/digdog/NSDate-RelativeDate" rel="dct:source">github.com</a>.<br />Permissions beyond the scope of this license may be available at <a xmlns:cc="http://creativecommons.org/ns#" href="http://standardorbit.net" rel="cc:morePermissions">http://standardorbit.net</a>.

