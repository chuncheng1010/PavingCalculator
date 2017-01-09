//
//  CalculationListTableViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "CalculationListTableViewController.h"
#import "AppDelegate.h"
#import <sqlite3.h>
#import "CalculationData.h"
#import "DataTableViewCell.h"
#import "CalculationViewController.h"

@interface CalculationListTableViewController ()

@end

@implementation CalculationListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        //return YES; /* Device is iPad */
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"headerimage.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        
    }
    else{
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    listdata = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getDataList];
}

-(void)getDataList
{
    [listdata removeAllObjects];
    
    sqlite3_stmt *selectStatement;
    char *selectSql = "SELECT * FROM jobstable";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    CalculationData *data;
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            //id integer primary key autoincrement,date TEXT,name TEXT,address TEXT,phone TEXT,email TEXT,quote TEXT,method TEXT,option TEXT,value TEXT,height TEXT,width TEXT,length TEXT,margin TEXT,tax TEXT,title TEXT)
            data = [[CalculationData alloc] init];
            int no = sqlite3_column_int(selectStatement, 0);
            data.calcid = [NSString stringWithFormat:@"%d",no];
            data.width1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)];
            data.width2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 10)];
            data.length1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)];
            data.length2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 11)];
            data.depth1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 12)];
            data.depth2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 13)];
            data.method = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)];
            data.option = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)];
            data.value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)];
            data.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 23)];
            
            data.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            data.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            data.address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)];
            data.phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            data.email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            data.quote = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)];
            [listdata addObject:data];
            //[data release];
        }
        
    }
    //statement close
    sqlite3_finalize(selectStatement);
    

    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [listdata count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"datalist";
    
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[DataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    CalculationData *data = [[CalculationData alloc] init];
    data = [listdata objectAtIndex:indexPath.row];
    
    cell.label.text = data.title;
    cell.deletebtn.tag = [data.calcid intValue];
    [cell.deletebtn addTarget:self action:@selector(recordremove:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
    // Configure the cell...
    
}

-(void)recordremove:(UIButton *)sender
{
    selectedid = (int)sender.tag;
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to delete this job?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    view.tag = 1;
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1 && buttonIndex == 0)
    {
        sqlite3_stmt *statement;
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        char *selectSql = "delete FROM jobstable where id=?";
        if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_bind_int(statement, 1, selectedid);
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"Error");
                
            }
            sqlite3_finalize(statement);
            [self getDataList];
        }
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CalculationViewController *detailController =segue.destinationViewController;
    DataTableViewCell *button = (DataTableViewCell *)sender;
    detailController.index = (int)button.deletebtn.tag;
    
}


@end
