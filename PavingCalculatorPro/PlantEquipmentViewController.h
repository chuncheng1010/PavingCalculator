//
//  PlantEquipmentViewController.h
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlantEquipmentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *compactor;
@property (weak, nonatomic) IBOutlet UITextField *plantother1;

@property (weak, nonatomic) IBOutlet UITextField *plantother2;
@property (weak, nonatomic) IBOutlet UITextField *plantother3;
@property (weak, nonatomic) IBOutlet UITextField *plantvalue;
@property (weak, nonatomic) IBOutlet UITextField *plantvalue1;
@property (weak, nonatomic) IBOutlet UITextField *plantvalue2;
@property (weak, nonatomic) IBOutlet UITextField *plantvalue3;
@property (weak, nonatomic) IBOutlet UITextField *tools;
@property (weak, nonatomic) IBOutlet UITextField *toolsother1;
@property (weak, nonatomic) IBOutlet UITextField *toolsother2;
@property (weak, nonatomic) IBOutlet UITextField *toolsother3;
@property (weak, nonatomic) IBOutlet UITextField *toolsvalue;
@property (weak, nonatomic) IBOutlet UITextField *toolsvalue1;
@property (weak, nonatomic) IBOutlet UITextField *toolsvalue2;
@property (weak, nonatomic) IBOutlet UITextField *toolsvalue3;
- (IBAction)textend:(id)sender;
- (IBAction)SaveData:(id)sender;
@end
