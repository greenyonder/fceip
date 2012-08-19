//
//  FfMultipleViewController.h
//  FCE
//
//  Created by ultravox on 08.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "FfMultiple.h"
#import "FfBookmark.h"

@interface FfMultipleViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    IBOutlet UIPickerView *pickerView;
    NSMutableArray *arrayChoices;
    Data * data;
    IBOutlet UILabel *lblsentence;
    IBOutlet UILabel *keylbl;
    FfMultiple * multiple;
    IBOutlet UIButton * btn;
}


-(IBAction)confirm:(id)sender;


@end
