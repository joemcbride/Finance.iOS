//
//  AccountViewController.m
//  Finance.iOS
//
//  Created by Joseph McBride on 2/26/14.
//  Copyright (c) 2014 Joe McBride. All rights reserved.
//

#import "AccountViewController.h"
#import "DataContext.h"
#import "Account.h"
#import "TransactionsViewController.h"

@interface AccountViewController () {
    DataContext *_dataContext;
    NSArray *_accounts;
}
@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!_dataContext)
        _dataContext = [[DataContext alloc]init];
    
    _accounts = [_dataContext accounts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Account *account = _accounts[indexPath.row];
    cell.textLabel.text = account.name;
    
    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"accountDetails"]){
        UITableViewCell *cell = sender;
        NSInteger index = [[self.tableView indexPathForCell:cell] row];
        TransactionsViewController *ctrl = segue.destinationViewController;
        ctrl.account = _accounts[index];
    }
}

@end
