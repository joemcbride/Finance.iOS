//
//  TransactionDetailsViewController.m
//  Finance.iOS
//
//  Created by Joseph McBride on 3/3/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "TransactionDetailsViewController.h"
#import "DataContext.h"
#import "TransactionCategory.h"
#import "ReactiveCocoa.h"
#import "AppDelegate.h"

@interface TransactionDetailsViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    DataContext *_context;
    NSArray *_categories;
}

@property (weak, nonatomic) IBOutlet UILabel *memo;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;

@end

@implementation TransactionDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!_context)
        _context = [[DataContext alloc] init];
    
    _categories = [_context categories];
    
    self.memo.text = self.transaction.memo;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    self.amount.text = [formatter stringFromNumber:self.transaction.amount];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    self.date.text = [dateFormatter stringFromDate:self.transaction.datePosted];
    
    TransactionCategory *category = [self categoryWithId:self.transaction.categoryId];
    self.category.text = category.name;
    
    self.category.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTapped)];
    [self.category addGestureRecognizer:tapGesture];
    
    self.categoryPicker.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)categoryTapped {
    self.categoryPicker.hidden = !self.categoryPicker.hidden;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    TransactionCategory *category = _categories[row];
    return category.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    TransactionCategory *category = _categories[row];
    self.transaction.categoryId = [NSNumber numberWithInteger:category.categoryId];
    self.category.text = category.name;
    
    [[AppDelegate instance] save];
}

- (TransactionCategory *)categoryWithId:(NSNumber *)categoryId {
    
    RACSequence *seq = [_categories.rac_sequence filter:^BOOL(TransactionCategory *cat) {
        return cat.categoryId == [categoryId integerValue];
    }];
    
    TransactionCategory *result = [seq head];
    return result == nil
        ? [TransactionCategory categoryWithId:0 andName:@"(None Selected)"]
        : result;
}

@end
