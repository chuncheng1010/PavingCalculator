//
//  AppDelegate.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/17/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    sqlite3 *db;
}

@property (strong, nonatomic) UIWindow *window;

@property (assign) sqlite3 *db;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

@end

