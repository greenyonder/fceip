//
//  FfWFListViewController.h
//  FCEstoryboard
//
//  Created by ultravox on 16.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "FfWFList.h"

@interface FfWFListViewController : UIViewController {
    
    IBOutlet UILabel *lblword;
    IBOutlet UILabel *lbllist;
 
    
    IBOutlet UIButton * btn;
    
    Data * data;
    
    FfWFList * wflist;
    
}

-(IBAction)confirm:(id)sender;



@end
