//
//  FfMultipleViewController.m
//  FCE
//
//  Created by ultravox on 08.08.12.
//  Copyright (c) 2012 ultravox. All rights reserved.
//

#import "FfMultipleViewController.h"



@implementation FfMultipleViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return arrayChoices.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //NSLog(@"riga pickerView");
          
    return [arrayChoices objectAtIndex:row];
}

-(void) loadQuestion {
    
    FfBookmark * bookmark = [data bookmark];
    
    multiple = [[data lista] objectAtIndex:bookmark.position];

    NSArray * choices = [multiple.choices componentsSeparatedByString:@";"];
    
    arrayChoices = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSString * c in choices) {
        [arrayChoices addObject:c];
    }
    
    
    [pickerView reloadAllComponents];
   

       self->lblsentence.text=multiple.sentence;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    data = [[Data alloc] init];
    
    FfBookmark * book = [[FfBookmark alloc] init];
    book.position=0;
    book.tipo=0;
    
    //[data saveBookmark:book];
    //[data saveBookmark:book];
    [data loadBookmark:@"fcemultiple"];
    //[data saveBookmark:book];
    [data loadLista:@"sqlmultiple"];
    // [data saveBookmark:book];
    [self loadQuestion];
 //[data saveBookmark:book];
    
    self.navigationItem.title=@"FCE Multiple";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"actionbar_background.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, nil]];
    

    //NSLog(@"did load");
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)confirm:(id)sender {
    
    NSInteger tag = [sender tag];
    
    if (tag==1) {
            NSInteger row = [pickerView selectedRowInComponent:0];
            
            NSArray * arrchoices  = [multiple.choices componentsSeparatedByString:@";"];
            
            if (multiple.key==(row+1)) {
              // correct
                keylbl.text=@"Right:)";
            } else {
                NSString * msg = [NSString stringWithFormat:@"Wrong:)\nCorrect:%@", [arrchoices objectAtIndex:multiple.key-1] ];
                keylbl.text=msg;
                
                

                
            [data insertError:multiple.sentence yourAnswer: [arrayChoices objectAtIndex:(row)]
            rightAnswer:[arrayChoices objectAtIndex:(multiple.key-1)] type:@"multiple"];
                
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

-(void)back:(id)sender{
	[self.navigationController setNavigationBarHidden:YES
											 animated:YES];
	[self.navigationController popToRootViewControllerAnimated:YES];
    
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
