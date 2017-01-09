//
//  QuotationListTableViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotationListTableViewController : UITableViewController
{
    NSMutableArray *listdata;
    int selectedid;
    int type;
}
@property (assign) int type;
-(void)getDataList;
@end
