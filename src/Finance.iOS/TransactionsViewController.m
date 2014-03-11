//
//  TransactionsViewController.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "TransactionsViewController.h"
#import "DataContext.h"
#import "Transaction.h"
#import "TransactionDetailsViewController.h"

@interface TransactionsViewController (){
    NSArray *_transactions;
    DataContext *_dataContext;
}
@end

@implementation TransactionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!_dataContext)
        _dataContext = [[DataContext alloc] init];
    
    _transactions = [_dataContext transactionsFor:self.account];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Transaction *trans = _transactions[indexPath.row];
    cell.textLabel.text = trans.memo;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"transDetails"]){
        UITableViewCell *cell = sender;
        NSInteger index = [[self.tableView indexPathForCell:cell] row];
        TransactionDetailsViewController *ctrl = segue.destinationViewController;
        ctrl.transaction = _transactions[index];
    }
}

@end
