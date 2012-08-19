//
//  FfWordFormationViewController.m
//  FCE
//
//  Created by ultravox on 09.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import "FfWordFormationViewController.h"

@interface FfWordFormationViewController ()

@end



@implementation FfWordFormationViewController

@synthesize txtword;

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

    data = [[Data alloc] init];
    
    [data loadBookmark:@"fcewf"];
    
    [data loadLista:@"sqlwf"];
    
    [self loadQuestion];
    
    [txtword becomeFirstResponder];
    
    self.navigationItem.title=@"FCE Word Formation";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_background.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, nil]];
    

}

-(void) loadQuestion {
    
    FfBookmark * bookmark = [data bookmark];
    
    wf = [[data lista] objectAtIndex:bookmark.position];

    
    self->txtword.text=wf.word;
    self->lblsentence.text=wf.sentence;
    
    
}


-(IBAction)confirm:(id)sender {
    
    NSInteger tag = [sender tag];
    
    if (tag==1) {
        FfBookmark * bookmark = [data bookmark];
        
        wf = [[data lista] objectAtIndex:bookmark.position];

        
        if ([txtword.text isEqualToString:wf.key]) {
            keylbl.text=@"Right:)";
        } else {
            NSString *msg = [NSString stringWithFormat:@"Wrong:)\nCorrect%@", wf.key ];
            keylbl.text=msg;
        }
        btn.tag=2;
        [btn setTitle:@"Next" forState:UIControlStateNormal];
    } else {
        
        FfBookmark * bookmark = [data bookmark];
        bookmark.position++;
        
        if ([[data lista] count] == bookmark.position ) {
            bookmark.position=0;
        }
        
        [data saveBookmark:bookmark];
        
        [self loadQuestion];
              
        
        btn.tag=1;
        [btn setTitle:@"Ok" forState:UIControlStateNormal];
        
    }
    
    
    
    //NSLog(@"risultato %d riga seleyionata %d" , multiple.key, row);
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [txtword resignFirstResponder];
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
