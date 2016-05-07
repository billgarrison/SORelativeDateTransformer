#import "TesterViewController.h"
#import "SORelativeDateTransformer.h"

@implementation TesterViewController

- (void) viewDidLoad 
{
    [super viewDidLoad];
    
	[datePicker setDate:[NSDate date]];
	
	[relativeDateLabel setText: [[SORelativeDateTransformer registeredTransformer] transformedValue:[datePicker date]]];
}

- (IBAction) datePickerChangedValue:(id)sender
{
	[relativeDateLabel setText: [[SORelativeDateTransformer registeredTransformer] transformedValue:[datePicker date]]];
}

@end
