//
//  FfPVViewController.m
//  FCE
//
//  Created by ultravox on 12.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import "FfPVViewController.h"

@interface FfPVViewController ()

@end

@implementation FfPVViewController

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
	// Do any additional setup after loading the view.
    data = [[Data alloc] init];
    
    [data loadBookmark:@"fcepv"];
    
    [data loadLista:@"sqlpv"];
    
    [self loadQuestion];
    
   
    
    self.navigationItem.title=@"FCE Phrasal Verbs";

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_background.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, nil]];
    
    
}


-(void) loadQuestion {
    
    FfBookmark * bookmark = [data bookmark];
    
    pv = [[data lista] objectAtIndex:bookmark.position];
    
    
    self->lblpv.text=[NSString stringWithFormat:@"P.V.: %@" , pv.pv];
    self->lblmeaning.text=[NSString stringWithFormat:@"meaning: %@" , pv.meaning];
    lblexample.text=@"";
    
    
}


-(IBAction)confirm:(id)sender {
    
    NSInteger tag = [sender tag];
    
    if (tag==1) {
        FfBookmark * bookmark = [data bookmark];
        
        pv = [[data lista] objectAtIndex:bookmark.position];
        
        lblexample.text=[NSString stringWithFormat:@"example: %@" , pv.example];
        
        
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



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
