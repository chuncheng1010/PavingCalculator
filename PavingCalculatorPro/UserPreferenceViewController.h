//
//  UserPreferenceViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPreferenceViewController : UIViewController
{
    int typeindex;
    
    int preferenceindex;
    int methodindex;
    int currencyindex;
}

@property (weak, nonatomic) IBOutlet UILabel *metriclabel;
@property (weak, nonatomic) IBOutlet UILabel *imperiallabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *methodSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSelect;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySelect;
- (IBAction)SaveData:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *methodbtn;
@property (weak, nonatomic) IBOutlet UIButton *typebtn;
@property (weak, nonatomic) IBOutlet UIButton *quotationbtn;
- (IBAction)methodSelect:(id)sender;
- (IBAction)typeSelect:(id)sender;
- (IBAction)preferenceSelect:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *currencybtn;
- (IBAction)currencySelect:(id)sender;

@end
