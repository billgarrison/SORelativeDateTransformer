//
//  SORelativeDateTransformerTester
//
//  Created by StdOrbit on 12/6/10.
//  Copyright 2010 Standard Orbit Software, LLC. All rights reserved.
//

#import "TesterViewController.h"
#import "SORelativeDateTransformer.h"

@implementation TesterViewController

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{
    [super viewDidLoad];
	relativeDateTransformer = [[SORelativeDateTransformer alloc] init];
    
	[datePicker setDate:[NSDate date]];
	
	[relativeDateLabel setText: [relativeDateTransformer transformedValue:[datePicker date]]];
}

- (IBAction) datePickerChangedValue:(id)sender
{
	[relativeDateLabel setText: [relativeDateTransformer transformedValue:[datePicker date]]];
}

@end
