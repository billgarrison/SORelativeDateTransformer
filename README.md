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
	
	NSString *relativeDate = [[SORelativeDateTransformer registeredTransformer] transformedValue:dateModified];
	
	NSLog (@"This file was modified %@.", relativeDate); // ==> "This file was modified 3 weeks ago."
	
## Localization ##

The accompanying bundle, `SORelativeDateTransformer.bundle`, provides localizations for the date component names and their plural forms. 

Included localizations:

* Catalan
* Dutch
* English
* French
* German
* Italian
* Japanese
* Norwegian
* Portuguese
* Spanish
* Simplified Chinese
* Traditional Chinese

The localization also includes NSString-compatible format templates for phrases expressing relative past and future dates.  

* For past dates, the format template for the English phrase is `"%d %@ ago"`. E.g. 20 minutes ago
* For future dates, the format template is `"in %d %@"`. E.g. in 20 minutes

To add your own localizations, copy the English localization within `SORelativeDateTransformer.bundle` directory to an appropriately named `.lproj` subdirectory, then edit the `.strings` file within that new localization subdirectory.

For example, to add a Korean localization:

	# Change working directory to the SORelativeDateTransformer.bundle
	
	cd ${PROJECT_DIR}/SORelativeDateTransformer.bundle
	
	# Copy the English localization subdirectory
	# to an appropriately named lproj directory for a Korean localization
	
	cp -R en.lproj ko.lproj
	
	# Edit the .strings file within the Italian lproj directory
	# to replace the English localization values with Korean equivalents.
	# Use your favorite UTF-16-capable text editor.
	
	mate ko.lproj/SORelativeDateTransformer.strings

## Tester App ##

Included is an iOS interactive testing application. You can a date from the date picker and see the generated relative date string below.

## Compatibility ##

SORelativeDateTransformer is compatible with iOS 4.3 and later, and Mac OS X 10.4 and later. Supports use in ARC and non-ARC projects.

## License ##

MIT License. Use it, hack it, but give me some love.

## Credits

Bill Garrison, for the initial implementation. [@github](https://github.com/billgarrison), [@bitbucket](https://bitbucket.org/billgarrison)

Ching-Lan 'digdog' Huang, for his NSDate category [NSDate-RelativeDate](https://github.com/digdog/NSDate-RelativeDate) upon which I based the value transformer.
 [@github](https://github.com/digdog).

Adam Ernst, for reorganizing into a cleaner layout for easier project integration. [@github](https://github.com/adamjernst).

Markus Gasser, for correcting the German localization. [@github](https://github.com/frenetisch-applaudierend).

Martin Destagnol, for correcting the French localization and pushing for ARC compatibility. [@github](https://github.com/mdestagnol).

Hendrik Bruinsma, for contributing the Dutch localization. [@github](https://github.com/hbruinsma).

Vince Yuan, for contributing the Simplified & Traditional Chinese localizations. [@github](https://github.com/vinceyuan).

Brian Gesiak, for contributing the Japanese localization. [@github](https://github.com/modocache).

Paulo André G Rodrigues, for contributing the Portuguese localization. [@github](https://github.com/pauloandreget).

Ragnar Henriksen, for contributing the Norwegian localization. [@github](https://github.com/ragnar).

Hjalti Jakobsson, for contributing the Italian localization. [@github](https://github.com/hjaltij).

Michael Petrov, for a performance boost under frequent invocations. [@github](https://github.com/michaelpetrov).

David Cortés & [Lafosca](http://lafosca.cat), for contributing the Catalan localization. [@github](https://github.com/davebcn87)
