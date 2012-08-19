//
//  FfWFListViewController.m
//  FCEstoryboard
//
//  Created by ultravox on 16.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import "FfWFListViewController.h"

@interface FfWFListViewController ()

@end

@implementation FfWFListViewController

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
    
    [data loadBookmark:@"fcewflist"];
    
    [data loadLista:@"sqlwflist"];
    
    [self loadQuestion];
    
    
    
    self.navigationItem.title=@"FCE Word Formation List";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_background.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, nil]];


}


-(void) loadQuestion {
    
    FfBookmark * bookmark = [data bookmark];
    
    wflist = [[data lista] objectAtIndex:bookmark.position];
    
    
    self->lblword.text=[NSString stringWithFormat:@"Word: %@" , wflist.word];

   
    lbllist.text=@"";
    
}



-(IBAction)confirm:(id)sender {
    
    NSInteger tag = [sender tag];
    
    if (tag==1) {
        FfBookmark * bookmark = [data bookmark];
        
        wflist = [[data lista] objectAtIndex:bookmark.position];
        
        lbllist.text=[NSString stringWithFormat:@"list: %@" , wflist.list];
        
        
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
