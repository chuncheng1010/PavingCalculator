//
//  CalculatorViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/17/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"

@interface CalculatorViewController : UIViewController
{
    int main;
    int up;
    int down;
    int selectedmethod;
    UITextField *comment1;
    int selectedtype;
}

@property (weak, nonatomic) IBOutlet UITextField *projecttime;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;



@property (weak, nonatomic) IBOutlet UITextField *width1;
@property (weak, nonatomic) IBOutlet UITextField *length1;
@property (weak, nonatomic) IBOutlet UITextField *width2;
@property (weak, nonatomic) IBOutlet UITextField *length2;
@property (weak, nonatomic) IBOutlet UITextField *depth1;
@property (weak, nonatomic) IBOutlet UITextField *depth2;
@property (weak, nonatomic) IBOutlet UILabel *width1unit;
@property (weak, nonatomic) IBOutlet UILabel *length1unit;
@property (weak, nonatomic) IBOutlet UILabel *width2unit;
@property (weak, nonatomic) IBOutlet UILabel *length2unit;
@property (weak, nonatomic) IBOutlet UILabel *depth1unit;
@property (weak, nonatomic) IBOutlet UILabel *depth2unit;

@property (weak, nonatomic) IBOutlet UITextField *square;
@property (weak, nonatomic) IBOutlet UITextField *privatearea;
@property (weak, nonatomic) IBOutlet UITextField *pavingstone;
@property (weak, nonatomic) IBOutlet UITextField *roadbase;
@property (weak, nonatomic) IBOutlet UITextField *beddingsand;
@property (weak, nonatomic) IBOutlet UITextField *jointsand;
@property (weak, nonatomic) IBOutlet UITextField *cement;
@property (weak, nonatomic) IBOutlet UITextField *compaction;
@property (weak, nonatomic) IBOutlet UILabel *squareunit;
@property (weak, nonatomic) IBOutlet UILabel *pavingareaunit;
@property (weak, nonatomic) IBOutlet UILabel *pavingstoneunit;
@property (weak, nonatomic) IBOutlet UILabel *roadbaseunit;
@property (weak, nonatomic) IBOutlet UILabel *beddingsandunit;
@property (weak, nonatomic) IBOutlet UILabel *jointsandunit;
@property (weak, nonatomic) IBOutlet UILabel *cementunit;

-(void)fieldinitialize;
- (IBAction)getAnswer:(id)sender;
-(NSString *)display:(int)m u:(int)u d:(int)d;
-(int)checkCompleteValue:(UITextField *)edit min:(Fraction *)min max:(Fraction *)max;
- (IBAction)textend:(id)sender;

- (IBAction)saveData:(id)sender;

@end
