//
//  FfWordFormationViewController.h
//  FCE
//
//  Created by ultravox on 09.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface FfWordFormationViewController : UIViewController <UITextFieldDelegate> {


Data * data;
IBOutlet UILabel *lblsentence;
IBOutlet UILabel *keylbl;

IBOutlet UIButton * btn;
IBOutlet UITextField * txtword;
    
    FfWF * wf;
}

@property(nonatomic,retain) UITextField * txtword;
-(IBAction)confirm:(id)sender;

@end
