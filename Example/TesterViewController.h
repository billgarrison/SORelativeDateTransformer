//
//  SORelativeDateTransformerTester
//
//  Created by StdOrbit on 12/6/10.
//  Copyright 2010 Standard Orbit Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SORelativeDateTransformer;

@interface TesterViewController : UIViewController
{
	IBOutlet UILabel *relativeDateLabel;
	IBOutlet UIDatePicker *datePicker;
	
	SORelativeDateTransformer *relativeDateTransformer;
}

- (IBAction) datePickerChangedValue:(id)sender;
- (IBAction) relativeDepthChangeValue:(UISegmentedControl *)sender;

@end

