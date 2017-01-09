//
//  CalculationViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculationData.h"
#import "Fraction.h"

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface CalculationViewController : UIViewController<MFMailComposeViewControllerDelegate>

{
    int index;
    CalculationData *data;
    int main;
    int up;
    int down;
    int selectedmethod;
    int selectedtype;
}
@property (assign) int index;
@property (retain) CalculationData *data;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)sendEmail:(id)sender;




@property (weak, nonatomic) IBOutlet UITextField *pavers;
@property (weak, nonatomic) IBOutlet UITextField *pavingarea;
@property (weak, nonatomic) IBOutlet UITextField *pavingstone;
@property (weak, nonatomic) IBOutlet UITextField *roadbase;
@property (weak, nonatomic) IBOutlet UITextField *beddingsand;
@property (weak, nonatomic) IBOutlet UITextField *cement;
@property (weak, nonatomic) IBOutlet UITextField *jointsand;
@property (weak, nonatomic) IBOutlet UITextField *compaction;
@property (weak, nonatomic) IBOutlet UILabel *pavingareaunit;
@property (weak, nonatomic) IBOutlet UILabel *pavingstoneunit;
@property (weak, nonatomic) IBOutlet UILabel *roadbaseunit;
@property (weak, nonatomic) IBOutlet UILabel *beddingsandunit;
@property (weak, nonatomic) IBOutlet UILabel *cementunit;
@property (weak, nonatomic) IBOutlet UILabel *jointsandunit;



-(int)checkCompleteValue:(NSString *)edit min:(Fraction *)min max:(Fraction *)max;


-(void)calculate;
-(void)savepreferences;
- (IBAction)saveData:(id)sender;
- (IBAction)textEnd:(id)sender;
@end
