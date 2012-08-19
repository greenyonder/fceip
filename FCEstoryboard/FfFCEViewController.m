//
//  FfFCEViewController.m
//  FCE
//
//  Created by ultravox on 08.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import "FfFCEViewController.h"


@implementation FfFCEViewController

//@synthesize btn1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // [btn1 setImage:[UIImage imageNamed:@"fceicona1p"] forState:UIControlStateHighlighted];
    self.title = NSLocalizedStringFromTable(@"title", @"InfoPlist", @"");
    UIBarButtonItem * rightbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fceabout"]  style:UIBarButtonItemStylePlain target:self action:@selector(about:) ];
	self.navigationItem.rightBarButtonItem=rightbtn;

    
   
    
    //self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_background.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, nil]];
	//self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//self.title = @"dsddsdsds";
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Errors" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Multiple choice",@"Word Formation", @"Reset errors",  nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleAutomatic;
    [popupQuery showInView:self.view];
    
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //NSLog(@"button %d" , buttonIndex);
    if (buttonIndex==0) {
        // multiple cho        
       
        
       
    }
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)exit:(id)sender {
    
    exit(0);
    
}

-(void) about:(id)sender {
    
}


@end
