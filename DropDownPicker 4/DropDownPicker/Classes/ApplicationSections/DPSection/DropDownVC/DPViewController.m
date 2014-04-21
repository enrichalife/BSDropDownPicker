//
//  DPViewController.m
//  DropDownPicker
//
//  Created by Deekshith NM on 10/06/13.
//  Copyright (c) 2013 com.deekshibel. All rights reserved.
//

#import "DPViewController.h"

@interface DPViewController ()

@end

@implementation DPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods -

- (IBAction)didChooseFriendsButtonTapped:(UIButton*)sender
{
    DPDropDownPicker * picker = [[DPDropDownPicker alloc] initWithDelegate:self dataSourceArray:[self friendPickerDataSourceArray]];
    [picker showFromView:sender];
}

#pragma mark - other utilitiy methods
- (NSArray *)friendPickerDataSourceArray
{
    static dispatch_once_t pred;
    static NSArray * dataSourceArray = nil;
    
    dispatch_once(&pred, ^{
        dataSourceArray = @[@"Deekshith",@"Nachi",@"Ajith",@"Pradi",@"Ashwi",@"rathan",];
    });
    return dataSourceArray;
}

   
#pragma mark - DPDropDownDelegate

- (void)dropDownPicker:(DPDropDownPicker *)dropDownPicker didPickObject:(NSString*)pickedObject
{
    NSString *outputStatus= @"You Have Selected-";
    outputStatus= [outputStatus stringByAppendingString:pickedObject];
    if([pickedObject isEqualToString:@"Deekshith"])
        _friendStatusLabel.text = [outputStatus stringByAppendingString:@"..Gr8 Choice!!"];
    else
        _friendStatusLabel.text = [outputStatus stringByAppendingString:@"..Wrong Choice!!"];
        
}

@end
