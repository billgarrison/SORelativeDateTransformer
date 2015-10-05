#import <UIKit/UIKit.h>

@interface TesterViewController : UIViewController
{
	IBOutlet UILabel *relativeDateLabel;
	IBOutlet UIDatePicker *datePicker;
}

- (IBAction) datePickerChangedValue:(id)sender;

@end

