//
//  DPViewController.h
//  DropDownPicker
//
//  Created by Deekshith NM on 10/06/13.
//  Copyright (c) 2013 com.deekshibel. All rights reserved.
//


//#import "DPConstants.h"
@protocol DPDropDownPickerDelegte;

@interface DPDropDownPicker : UIControl <UITableViewDataSource, UITableViewDelegate>
{
    id <DPDropDownPickerDelegte> __weak _delegate;
    UIView * __weak _shownFromView;
    
    NSArray * _dataSourceArray;
}

@property (nonatomic, weak) id <DPDropDownPickerDelegte> delegate;
@property (nonatomic, weak) UIView * shownFromView;
@property (nonatomic, strong  ) NSArray * dataSourceArray;

- (id)initWithDelegate:(id)delegate dataSourceArray:(NSArray *)dataSourceArray;
- (void)showFromView:(UIView *)view;

@end

@protocol DPDropDownPickerDelegte <NSObject>

- (void)dropDownPicker:(DPDropDownPicker *)dropDownPicker didPickObject:(id)pickedObject;

@end