//
//  QuotationViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculationData.h"

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

#import "Fraction.h"

@interface QuotationViewController : UIViewController<MFMailComposeViewControllerDelegate,UITextViewDelegate>
{
    int index;
    CalculationData *data;
    int main,up,down;
    //Fraction *width1fraction,*length1fraction,*width2fraction,*length2fraction,*depth1fraction,*depth2fraction;
    //NSString *jobstr,*flooringstr,*joiststr,*bearersstr,*poststr,*concretemixstr,*flooringfixingstr,*joistfixingstr,*bearerfixingstr;
    NSString *paversstr,*roadbasestr,*beddingsandstr,*jointsandstr,*cementedgestr,*paverjobstr;
    int selection;
    int selectedmethod,selectedtype;
}
@property (weak, nonatomic) IBOutlet UITextField *quote;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *laying;
@property (weak, nonatomic) IBOutlet UITextField *layingother1;
@property (weak, nonatomic) IBOutlet UITextField *labournet;
@property (weak, nonatomic) IBOutlet UITextField *netcost;
@property (weak, nonatomic) IBOutlet UITextField *margin1;
@property (weak, nonatomic) IBOutlet UITextField *margin2;
- (IBAction)textediting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *taxmount2;
@property (weak, nonatomic) IBOutlet UITextField *total;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *compactor;
@property (weak, nonatomic) IBOutlet UITextField *plantother1;
@property (weak, nonatomic) IBOutlet UITextField *plantother2;
@property (weak, nonatomic) IBOutlet UITextField *plantother3;
@property (weak, nonatomic) IBOutlet UITextField *plantnet;
@property (weak, nonatomic) IBOutlet UITextField *toolsvalue;
@property (weak, nonatomic) IBOutlet UITextField *equipother1;
@property (weak, nonatomic) IBOutlet UITextField *equipother2;
@property (weak, nonatomic) IBOutlet UITextField *equipother3;
@property (weak, nonatomic) IBOutlet UITextField *netequip;


@property (retain, nonatomic) IBOutlet UITextField *pavers;
@property (retain, nonatomic) IBOutlet UITextField *roadbase;
@property (retain, nonatomic) IBOutlet UITextField *beddingsand;
@property (retain, nonatomic) IBOutlet UITextField *jointsand;
@property (retain, nonatomic) IBOutlet UITextField *cement;


@property (weak, nonatomic) IBOutlet UITextField *materialvalue1;
@property (weak, nonatomic) IBOutlet UITextField *materialvalue2;
@property (weak, nonatomic) IBOutlet UITextField *materialvalue3;
@property (weak, nonatomic) IBOutlet UITextField *materialnet;

- (IBAction)texteditting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *subtotal;
@property (weak, nonatomic) IBOutlet UITextField *taxmount1;





@property (weak, nonatomic) IBOutlet UILabel *other1label;
@property (weak, nonatomic) IBOutlet UITextField *other1value;
@property (weak, nonatomic) IBOutlet UILabel *other2label;
@property (weak, nonatomic) IBOutlet UITextField *other2value;
@property (weak, nonatomic) IBOutlet UILabel *other3label;
@property (weak, nonatomic) IBOutlet UITextField *other3value;
@property (weak, nonatomic) IBOutlet UITextField *other4value;
@property (weak, nonatomic) IBOutlet UILabel *other4label;

@property (weak, nonatomic) IBOutlet UITextField *layingother2;
@property (weak, nonatomic) IBOutlet UITextField *layingother3;
@property (weak, nonatomic) IBOutlet UITextField *layingother4;
@property (weak, nonatomic) IBOutlet UILabel *layingother2label;
@property (weak, nonatomic) IBOutlet UILabel *layingother3label;
@property (weak, nonatomic) IBOutlet UILabel *layingother4label;

-(int)checkCompleteValue:(NSString *)edit min:(Fraction *)min max:(Fraction *)max;

- (IBAction)texteditingValue:(id)sender;
- (IBAction)textend:(id)sender;

- (IBAction)emailSend:(id)sender;
@property (assign) int index;
@property (retain) CalculationData *data;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)textStartWriting:(id)sender;
- (IBAction)textediting:(id)sender;
@end
