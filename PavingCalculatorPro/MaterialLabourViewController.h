//
//  MaterialLabourViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialLabourViewController : UIViewController
- (IBAction)textend:(id)sender;

- (IBAction)SaveData:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *laying;
@property (weak, nonatomic) IBOutlet UITextField *materialother4value;
@property (weak, nonatomic) IBOutlet UITextField *materialother5value;

@property (weak, nonatomic) IBOutlet UITextField *materialother6value;



@property (weak, nonatomic) IBOutlet UITextField *materialother4label;
@property (weak, nonatomic) IBOutlet UITextField *materialother5label;
@property (weak, nonatomic) IBOutlet UITextField *materialother6label;

@property (weak, nonatomic) IBOutlet UILabel *timber1label;
@property (weak, nonatomic) IBOutlet UITextField *timber1;
@property (weak, nonatomic) IBOutlet UILabel *timber1unit;
@property (weak, nonatomic) IBOutlet UILabel *timber2label;
@property (weak, nonatomic) IBOutlet UITextField *timber2;
@property (weak, nonatomic) IBOutlet UILabel *timber2unit;
@property (weak, nonatomic) IBOutlet UILabel *timber3label;
@property (weak, nonatomic) IBOutlet UITextField *timber3;
@property (weak, nonatomic) IBOutlet UILabel *timber3unit;
@property (weak, nonatomic) IBOutlet UILabel *timber4label;
@property (weak, nonatomic) IBOutlet UITextField *timber4;
@property (weak, nonatomic) IBOutlet UILabel *timber4unit;
@property (weak, nonatomic) IBOutlet UILabel *timber5label;
@property (weak, nonatomic) IBOutlet UITextField *timber5;
@property (weak, nonatomic) IBOutlet UILabel *timber5unit;
@property (weak, nonatomic) IBOutlet UITextField *timber6;
@property (weak, nonatomic) IBOutlet UILabel *timber6unit;

@property (weak, nonatomic) IBOutlet UITextField *timberother1label;
@property (weak, nonatomic) IBOutlet UITextField *timberother1;
@property (weak, nonatomic) IBOutlet UITextField *timberother2label;
@property (weak, nonatomic) IBOutlet UITextField *timberother2;
@property (weak, nonatomic) IBOutlet UITextField *timberother3label;
@property (weak, nonatomic) IBOutlet UITextField *timberother3;
@property (weak, nonatomic) IBOutlet UITextField *timberother4label;
@property (weak, nonatomic) IBOutlet UITextField *timberother4;
@property (weak, nonatomic) IBOutlet UILabel *timberother4unit;


@property (weak, nonatomic) IBOutlet UILabel *labourunit;
@end
