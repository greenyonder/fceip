//
//  FfPVViewController.h
//  FCE
//
//  Created by ultravox on 12.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "FfPV.h"

@interface FfPVViewController : UIViewController {

IBOutlet UILabel *lblpv;
IBOutlet UILabel *lblmeaning;
IBOutlet UILabel *lblexample;
    
IBOutlet UIButton * btn;
    
    Data * data;
    
    FfPV * pv;
    
}

-(IBAction)confirm:(id)sender;


@end
