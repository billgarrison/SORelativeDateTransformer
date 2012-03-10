# SORelativeDateTransformer #

SORelativeDateTransformer is a value transformer that generates a human-readable phrase expressing the relative difference between a given date and the current date.

For example, when the current date-time is 2010-12-05 11:30, then

... 2010-12-05 11:00 is transformed to "30 minutes ago"

... 2010-12-01 11:00 is transformed to "5 days ago"

... 2010-12-25 08:00 is transformed to "in 2 weeks"

The transformer does not provide reverse transformations; you can only transform from an NSDate to an NSString.

## How To Use ##

Add the source files and localized strings bundle to your project.

	SORelativeDateTransformer.h
	SORelativeDateTransformer.m
	SORelativeDataTransformer.bundle

Create an instance of SORelativeDateTransformer wherever you need to generate relative date phrases.

	// Display a file's creation date relative to today's date
	NSURL *someFilePath = ...;
	NSDictionary *attribs = [[NSFileManager defaultManager] attributesOfItemAtPath:someFilePath error:NULL];
	
	NSDate *dateModified = [attribs fileModificationDate];
	
	// fileModificationDate is 2010-10-01 12:00:00TZ; 
	// Date now is 2010-10-30 12:00:00TZ
	
	SORelativeDateTransformer *relativeDateTransformer = [[SORelativeDateTransformer alloc] init];
	NSString *relativeDate = [relativeDateTransformer transformedValue: dateModified];
	
	NSLog (@"This file was modified %@.", relativeDate); // ==> "This file was modified 3 weeks ago."
	
## Localization ##

The accompanying bundle, `SORelativeDateTransformer.bundle`, provides localizations for the date component names and their plural forms. Included are localization files for English, French, German, and Spanish.

The localization files also contains an NSString format template for expressing relative past and future dates.  

* For past dates, the format template for the English phrase is `"%d %@ ago"`. 
* For future dates, the format template is `"in %d %@"`.

To add your own localizations, add an appropriate language `.lproj` subdirectory within the `SORelativeDateTransformer.bundle` directory, then add a `.strings` file with the lproj.

For example, to add an Italian localization:

	# Change working directory to the SORelativeDateTransformer.bundle
	
	cd ${PROJECT_DIR}/SORelativeDateTransformer.bundle
	
	# Copy the English localization subdirectory
	# to an appropriately named lproj directory for an Italian localization
	
	cp -R en.lproj it.lproj
	
	# Edit the .strings file within the Italian lproj directory
	# to replace the English localization values with Italian equivalents.
	# Use your favorite UTF-16-capable text editor.
	
	mate it.lproj/SORelativeDateTransformer.strings

## Tester App ##

Included is an iOS 4 interactive testing application. You can a date from the date picker and see the generated relative date string below.

## Compatibility ##

SORelativeDateTransformer is compatible with iOS 4 and later, and Mac OS X 10.4 and later. 

## License ##

Use it, hack it, but give me some love.

![Creative Commons License](http://i.creativecommons.org/l/by-sa/3.0/88x31.png) [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/).

For a non-attribution license, contact [http://standardorbit.net](http://standardorbit.net).

## Credits

Bill Garrison, for the initial implementation. [github](https://github.com/billgarrison), [bitbucket](https://bitbucket.org/billgarrison)

Ching-Lan 'digdog' Huang, for his NSDate category [NSDate-RelativeDate](https://github.com/digdog/NSDate-RelativeDate) upon which I based the value transformer.
 [github](https://github.com/digdog/).

Adam Ernst, for reorganizing into a cleaner layout for easier project integration. [github](https://github.com/adamjernst).
