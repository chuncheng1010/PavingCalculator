//
//  PlantEquipmentViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "PlantEquipmentViewController.h"

@interface PlantEquipmentViewController ()

@end

@implementation PlantEquipmentViewController

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
    NSString *str;
    int currency;
    if([prefs stringForKey:@"currency"] == nil || [[prefs stringForKey:@"currency"] intValue] == 0)
        currency = 0;
    else
        currency = [[prefs stringForKey:@"currency"] intValue];
    switch (currency) {
        case 0:
            str = @"$";
            break;
        case 1:
            str = @"€";
            break;
        case 2:
            str = @"￥";
            break;
        case 3:
            str = @"₤";
            break;
        case 4:
            str = @"F";
            break;
        default:
            break;
    }
    
    _compactor.text = [prefs stringForKey:@"compactor"];
    if([_compactor.text length] == 0)
        _compactor.text = @"Plant";
    _plantother1.text = [prefs stringForKey:@"plantother1"];
    if([_plantother1.text length] == 0)
        _plantother1.text = @"Other";
    _plantother2.text = [prefs stringForKey:@"plantother2"];
    if([_plantother2.text length] == 0)
        _plantother2.text = @"Other";
    _plantother3.text = [prefs stringForKey:@"plantother3"];
    if([_plantother3.text length] == 0)
        _plantother3.text = @"Other";
    
    _tools.text = [prefs stringForKey:@"tools"];
    if([_tools.text length] == 0)
        _tools.text = @"Equipment";
    
    _toolsother1.text = [prefs stringForKey:@"toolsother1"];
    if([_toolsother1.text length] == 0)
        _toolsother1.text = @"Other";
    _toolsother2.text = [prefs stringForKey:@"toolsother2"];
    if([_toolsother2.text length] == 0)
        _toolsother2.text = @"Other";
    _toolsother3.text = [prefs stringForKey:@"toolsother3"];
    if([_toolsother3.text length] == 0)
        _toolsother3.text = @"Other";
    
    _plantvalue.text = [prefs stringForKey:@"plantvalue"];
    if([_plantvalue.text length] == 0)
        _plantvalue.text = @"10.00";
    _plantvalue.text = [NSString stringWithFormat:@"%@%@",str,_plantvalue.text];
    
    
    
    _plantvalue1.text = [prefs stringForKey:@"plantothervalue1"];
    if([_plantvalue1.text length] == 0)
        _plantvalue1.text = @"0.00";
    _plantvalue1.text = [NSString stringWithFormat:@"%@%@",str,_plantvalue1.text];
    
    
    _plantvalue2.text = [prefs stringForKey:@"plantothervalue2"];
    if([_plantvalue2.text length] == 0)
        _plantvalue2.text = @"0.00";
    _plantvalue2.text = [NSString stringWithFormat:@"%@%@",str,_plantvalue2.text];
    
    
    _plantvalue3.text = [prefs stringForKey:@"plantothervalue3"];
    if([_plantvalue3.text length] == 0)
        _plantvalue3.text = @"0.00";
    _plantvalue3.text = [NSString stringWithFormat:@"%@%@",str,_plantvalue3.text];
    
    
    _toolsvalue.text = [prefs stringForKey:@"toolsvalue"];
    if([_toolsvalue.text length] == 0)
        _toolsvalue.text = @"10.00";
    _toolsvalue.text = [NSString stringWithFormat:@"%@%@",str,_toolsvalue.text];
    
    
    _toolsvalue1.text = [prefs stringForKey:@"toolsothervalue1"];
    if([_toolsvalue1.text length] == 0)
        _toolsvalue1.text = @"0.00";
    _toolsvalue1.text = [NSString stringWithFormat:@"%@%@",str,_toolsvalue1.text];
    
    
    _toolsvalue2.text = [prefs stringForKey:@"toolsothervalue2"];
    if([_toolsvalue2.text length] == 0)
        _toolsvalue2.text = @"0.00";
    _toolsvalue2.text = [NSString stringWithFormat:@"%@%@",str,_toolsvalue2.text];
    
    
    _toolsvalue3.text = [prefs stringForKey:@"toolsothervalue3"];
    if([_toolsvalue3.text length] == 0)
        _toolsvalue3.text = @"0.00";
    _toolsvalue3.text = [NSString stringWithFormat:@"%@%@",str,_toolsvalue3.text];
    
}

-(void)savepreferences
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *str1;
    int currency;
    if([prefs stringForKey:@"currency"] == nil || [[prefs stringForKey:@"currency"] intValue] == 0)
        currency = 0;
    else
        currency = [[prefs stringForKey:@"currency"] intValue];
    switch (currency) {
        case 0:
            str1 = @"$";
            break;
        case 1:
            str1 = @"€";
            break;
        case 2:
            str1 = @"￥";
            break;
        case 3:
            str1 = @"₤";
            break;
        case 4:
            str1 = @"F";
            break;
        default:
            break;
    }
    
    [prefs setObject:_compactor.text forKey:@"compactor"];
    //plantother1,plantother2,plantother3,tools,toolsother1,toolsother2,toolsother3
    [prefs setObject:_plantother1.text forKey:@"plantother1"];
    [prefs setObject:_plantother2.text forKey:@"plantother2"];
    [prefs setObject:_plantother3.text forKey:@"plantother3"];
    
    [prefs setObject:_tools.text forKey:@"tools"];
    [prefs setObject:_toolsother1.text forKey:@"toolsother1"];
    [prefs setObject:_toolsother2.text forKey:@"toolsother2"];
    [prefs setObject:_toolsother3.text forKey:@"toolsother3"];
    
    //plantvalue,plantothervalue1,plantothervalue2,plantothervalue3,toolsvalue,toolsothervalue1,toolsothervalue2,toolsothervalue3
    NSString *str = [NSString stringWithFormat:@"%.2f",[[_plantvalue.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"plantvalue"];
    _plantvalue.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    
    str = [NSString stringWithFormat:@"%.2f",[[_plantvalue1.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"plantothervalue1"];
    _plantvalue1.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_plantvalue2.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"plantothervalue2"];
    _plantvalue2.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_plantvalue3.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"plantothervalue3"];
    _plantvalue3.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_toolsvalue.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"toolsvalue"];
    _toolsvalue.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_toolsvalue1.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"toolsothervalue1"];
    _toolsvalue1.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_toolsvalue2.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"toolsothervalue2"];
    _toolsvalue2.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_toolsvalue3.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"toolsothervalue3"];
    _toolsvalue3.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self savepreferences];
    }
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)savedata
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    
}

- (IBAction)textend:(id)sender {
}

- (IBAction)SaveData:(id)sender {
    [self savedata];
}
@end
