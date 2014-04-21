//
//  DPViewController.h
//  DropDownPicker
//
//  Created by Deekshith NM on 10/06/13.
//  Copyright (c) 2013 com.deekshibel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPDropDownPicker.h"
@interface DPViewController : UIViewController <DPDropDownPickerDelegte>

- (IBAction)didChooseFriendsButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *friendStatusLabel;

@end
