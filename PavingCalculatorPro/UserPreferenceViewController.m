//
//  UserPreferenceViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "UserPreferenceViewController.h"

@interface UserPreferenceViewController ()

@end

@implementation UserPreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] isEqualToString:@"metric"] == YES)
    {
        
        methodindex = 0;
    }
    else
    {
        methodindex = 1;//[[prefs stringForKey:@"method"] intValue];
        
    }
    [self measurementsDisplay:methodindex];
    
    /*
    if([prefs stringForKey:@"fence"] == nil || [[prefs stringForKey:@"fence"] isEqualToString:@"standard"] == YES)
        typeindex = 0;
    
    else if([[prefs stringForKey:@"fence"] isEqualToString:@"standard1"] == YES)
    {
        typeindex = 1;//[[prefs stringForKey:@"fence"] intValue];
    }else
    {typeindex = 2;
    }
    [self concreteTypeDisplay:typeindex];
    */
    
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    
    const unichar ch1 = 0x00b2;
    NSString *temp1 = [NSString stringWithCharacters: &ch1 length:1];
    
    _metriclabel.text = [NSString stringWithFormat:@"MM, METERS, M%@, M%@,Kg",temp1,temp];
    
    _imperiallabel.text = [NSString stringWithFormat:@"INCHES, FEET, FT%@, FT%@, Lbs",temp1,temp];
    
    
    if([prefs stringForKey:@"pref"] == nil || [[prefs stringForKey:@"pref"] isEqualToString:@"business"] == YES)
        preferenceindex = 1;
    else
        preferenceindex = [[prefs stringForKey:@"pref"] intValue];
    [self userPreferenceDisplay:preferenceindex];
    
    if([prefs stringForKey:@"currency"] == nil || [[prefs stringForKey:@"currency"] isEqualToString:@"0"] == YES)
        currencyindex = 0;
    else
        currencyindex = [[prefs stringForKey:@"currency"] intValue];
    [self currencyDisplay:currencyindex];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)measurementsDisplay:(int)value
{
    switch (value) {
        case 0:
            [_methodbtn setTitle:@"Metric (Metres)" forState:UIControlStateNormal];
            break;
        case 1:
            [_methodbtn setTitle:@"Imperial (Feet)" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    methodindex = value;
}

-(void)userPreferenceDisplay:(int)value
{
    switch (value) {
        case 0:
            [_quotationbtn setTitle:@"Calculate" forState:UIControlStateNormal];
            break;
        case 1:
            [_quotationbtn setTitle:@"Calculate & Quote" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    preferenceindex = value;
}

-(void)currencyDisplay:(int)value
{
    switch (value) {
        case 0:
            [_currencybtn setTitle:@"Dollar($)" forState:UIControlStateNormal];
            break;
        case 1:
            [_currencybtn setTitle:@"Euro(€)" forState:UIControlStateNormal];
            break;
        case 2:
            [_currencybtn setTitle:@"Yen(¥)" forState:UIControlStateNormal];
            break;
        case 3:
            [_currencybtn setTitle:@"Pound(₤)" forState:UIControlStateNormal];
            break;
        case 4:
            [_currencybtn setTitle:@"Franc(F)" forState:UIControlStateNormal];
            break;
        
        default:
            break;
    }
    currencyindex = value;
}


-(void)concreteTypeDisplay:(int)value
{
    switch(value)
    {
        case 0:
            [_typebtn setTitle:@"1:2:9 - (Protected Mix" forState:UIControlStateNormal];
            break;
        case 1:
            [_typebtn setTitle:@"1:1:6 - (General Purpose)" forState:UIControlStateNormal];
            break;
        case 2:
            [_typebtn setTitle:@"1:4 - (Exposure Purpose)" forState:UIControlStateNormal];
            break;
        
        default:
            break;
            
    }
    typeindex = value;
}

-(void)savedata
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",_typeSelect.selectedSegmentIndex);
    if(buttonIndex == 0)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        if(methodindex == 0)
            [prefs setObject:@"metric" forKey:@"method"];
        else
            [prefs setObject:@"imperial" forKey:@"method"];
        
        /*
        if(typeindex == 0)
            [prefs setObject:@"standard" forKey:@"fence"];
        else if(typeindex == 1)
            [prefs setObject:@"standard1" forKey:@"fence"];
        else
            [prefs setObject:@"lapped" forKey:@"fence"];
         */
        [prefs setObject:[NSString stringWithFormat:@"%d",currencyindex] forKey:@"currency"];
        if(preferenceindex == 0)
            [prefs setObject:@"personal" forKey:@"pref"];
        else
            [prefs setObject:@"business" forKey:@"pref"];
        
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];        
    }
    //[self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SaveData:(id)sender {
    [self savedata];
}
- (IBAction)methodSelect:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Measurement - Preference"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Metric (Metres)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self measurementsDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Imperial (Feet)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self measurementsDisplay:1];
    }];
    [controller addAction:second];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)typeSelect:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Mortar Mix - Preferences"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"1:2:9 - (Protected Mix" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self concreteTypeDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"1:1:6 - (General Purpose)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self concreteTypeDisplay:1];
    }];
    [controller addAction:second];
    
    UIAlertAction *third = [UIAlertAction actionWithTitle:@"1:4 - (Exposure Purpose)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self concreteTypeDisplay:2];
    }];
    [controller addAction:third];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)preferenceSelect:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"User Preferences"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Calculate" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self userPreferenceDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Calculate & Quote" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self userPreferenceDisplay:1];
    }];
    [controller addAction:second];
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)currencySelect:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                        message:@"Currency Settings"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                        }];
    
    [controller addAction:alertAction];
    
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"Dollar($)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:0];
    }];
    [controller addAction:first];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Euro(€)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:1];
    }];
    [controller addAction:second];
    UIAlertAction *third = [UIAlertAction actionWithTitle:@"Yen(¥)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:2];
    }];
    [controller addAction:third];
    UIAlertAction *fourth = [UIAlertAction actionWithTitle:@"Pound(₤)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:3];
    }];
    [controller addAction:fourth];
    UIAlertAction *fifth = [UIAlertAction actionWithTitle:@"Franc(F)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"Dismiss button tapped!");
        [self currencyDisplay:4];
    }];
    [controller addAction:fifth];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
