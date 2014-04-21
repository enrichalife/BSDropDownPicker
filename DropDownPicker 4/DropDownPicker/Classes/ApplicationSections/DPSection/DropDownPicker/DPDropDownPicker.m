//
//  DPViewController.h
//  DropDownPicker
//
//  Created by Deekshith NM on 10/06/13.
//  Copyright (c) 2013 com.deekshibel. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "DPDropDownPicker.h"

#define kDefaultHeightRow 24
#define kDefaultWeightRow 20
#define kTransitionDuration 0.1
#define backColor [UIColor colorWithRed:180.0/255.0 green:29.0/255.0 blue:30.0/255.0 alpha:1]
@interface DPDropDownPickerCell : UITableViewCell
@end

@implementation DPDropDownPickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            UIView * background = [[UIView alloc] init];
            background.backgroundColor =backColor;
            self.selectedBackgroundView = background;
            self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect titleFrame = CGRectInset(self.bounds, 5, 0);
    self.textLabel.frame = titleFrame;
}
@end



@interface DPDropDownPicker ()
{
    UITableView * pickerTableView;
}

@end

@implementation DPDropDownPicker

@synthesize shownFromView = _shownFromView;
@synthesize delegate = _delegate;
@synthesize dataSourceArray = _dataSourceArray;

#define kRowHeight 22
#define kMaxVisibleRows 5

- (id)initWithDelegate:(id)delegate dataSourceArray:(NSArray *)dataSourceArray
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        pickerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        pickerTableView.rowHeight  = kRowHeight;
        pickerTableView.dataSource = self;
        pickerTableView.delegate   = self;
        pickerTableView.layer.borderColor = [UIColor redColor].CGColor;
        pickerTableView.layer.borderWidth = 1.0;
        
        pickerTableView.backgroundColor = [UIColor whiteColor];
        pickerTableView.separatorColor  = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
               
        [self addSubview:pickerTableView];
        [self addTarget:self action:@selector(didTappedOnBackground) forControlEvents:UIControlEventTouchUpInside];
        
        self.dataSourceArray = dataSourceArray;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark- Show/Hide -

- (void)showFromView:(UIView *)view
{
    if (!view.superview) {
        return;
    }
    
    self.shownFromView = view;
    
    NSUInteger rowCount = [_dataSourceArray count];
    pickerTableView.scrollEnabled = (rowCount > kMaxVisibleRows);
    
    CGRect frame = view.superview.bounds;
    
    __block CGRect tableViewFrame = view.frame;
    tableViewFrame.origin.y = (tableViewFrame.origin.y + tableViewFrame.size.height) - 1;
    tableViewFrame.size.height = 0.0;
    pickerTableView.frame = tableViewFrame;
    self.frame = frame;
    
    [view.superview addSubview:self];
        //[self customisePresentaionForView:view];
    tableViewFrame.size.height += kRowHeight;
        //tableViewFrame.size.height = MIN((rowCount * kRowHeight), (kMaxVisibleRows * kRowHeight));
    NSTimeInterval duration = ((MIN(rowCount, kMaxVisibleRows))/(float)kMaxVisibleRows)*kTransitionDuration;
//    [UIView animateWithDuration:duration*2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        pickerTableView.frame=tableViewFrame;
//            //tableViewFrame.size.height += kRowHeight;
//    } completion:^(BOOL finished)
//    {   
//        [UIView animateWithDuration:duration*2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            pickerTableView.frame=tableViewFrame;} completion:^(BOOL finished)
//        {
//                [UIView animateWithDuration:duration*2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                    pickerTableView.frame=tableViewFrame;} completion:^(BOOL finished)
//                 {
//                     
//                 }];
//        }];
//        
//        }];
//        [UIView animateWithDuration:duration animations:^{pickerTableView.frame = tableViewFrame;}];
//    
//     [UIView animateWithDuration:duration animations:^{pickerTableView.frame = tableViewFrame;}];
//    tableViewFrame.size.height += kRowHeight;
//    [UIView animateWithDuration:duration animations:^{pickerTableView.frame = tableViewFrame;}];
//    tableViewFrame.size.height += kRowHeight;
//    [UIView animateWithDuration:duration animations:^{pickerTableView.frame = tableViewFrame;}];
//    tableViewFrame.size.height += kRowHeight;
//    [UIView animateWithDuration:duration animations:^{pickerTableView.frame = tableViewFrame;}];
//    tableViewFrame.size.height += kRowHeight;
//    [UIView animateWithDuration:duration animations:^{pickerTableView.frame = tableViewFrame;}];
    [UIView animateWithDuration:duration delay:0.03 options:UIViewAnimationOptionCurveLinear animations:^{
        pickerTableView.frame = tableViewFrame;
    } completion:^(BOOL finished) {
        tableViewFrame.size.height += kRowHeight;
        [UIView animateWithDuration:duration delay:0.03 options:UIViewAnimationOptionCurveLinear animations:^{
            pickerTableView.frame = tableViewFrame;
        } completion:^(BOOL finished) {
            tableViewFrame.size.height += kRowHeight;
            [UIView animateWithDuration:duration delay:0.03 options:UIViewAnimationOptionCurveLinear animations:^{
                pickerTableView.frame = tableViewFrame;
            } completion:^(BOOL finished) {
                tableViewFrame.size.height += kRowHeight;
                [UIView animateWithDuration:duration delay:0.03 options:UIViewAnimationOptionCurveLinear animations:^{
                    pickerTableView.frame = tableViewFrame;
                } completion:^(BOOL finished) {
                    
                }];

                
            }];
            
        }];
    }];
    
    
    

    
}

- (void)hidePicker
{
    CGRect tableViewFrame = pickerTableView.frame;
    tableViewFrame.size.height = 0.0;
    
    NSTimeInterval duration = ((MIN([_dataSourceArray count], kMaxVisibleRows))/(float)kMaxVisibleRows)*kTransitionDuration;
    
    [UIView animateWithDuration:duration
                     animations:^{
                         pickerTableView.frame = tableViewFrame;
                     }
                     completion:^(BOOL isFinish){
                         if (isFinish) {
                             [self removeFromSuperview];
                         }
                     }];
    
}

- (void)didTappedOnBackground
{
    [self hidePicker];
}

#pragma mark- TableView DataSource and Delegate -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DPDropDownPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
	
    cell.textLabel.text = [_dataSourceArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(dropDownPicker:didPickObject:)])
    {
        [_delegate dropDownPicker:self didPickObject:[_dataSourceArray objectAtIndex:indexPath.row]];
    }
    [self hidePicker];
}

@end
