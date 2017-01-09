//
//  MaterialLabourViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "MaterialLabourViewController.h"

@interface MaterialLabourViewController ()

@end

@implementation MaterialLabourViewController

-(void)viewDidAppear:(BOOL)animated
{
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
    const unichar ch1 = 0x00b2;
    NSString *temp1 = [NSString stringWithCharacters: &ch1 length:1];
    
    const unichar ch2 = 0x00b3;
    NSString *temp2 = [NSString stringWithCharacters: &ch2 length:1];
    
    NSString* wall = [prefs stringForKey:@"fence"];
    if([prefs stringForKey:@"fence"] == nil)
        wall = @"standard";
    
    
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] isEqualToString:@"metric"])
    {
        
        _timber1unit.text = [NSString stringWithFormat:@"Per M%@",temp1];
        _timber2unit.text = [NSString stringWithFormat:@"Per M%@",temp2];
        _timber3unit.text = [NSString stringWithFormat:@"Per M%@",temp2];
        _timber4unit.text = @"Per Kg";
        _timber5unit.text = @"Per Kg";
        _labourunit.text = [NSString stringWithFormat:@"Per M%@",temp1];
        
    }
    else{
        
        _timber1unit.text = [NSString stringWithFormat:@"Per FT%@",temp1];
        _timber2unit.text = [NSString stringWithFormat:@"Per FT%@",temp2];
        _timber3unit.text = [NSString stringWithFormat:@"Per FT%@",temp2];
        _timber4unit.text = @"Per Lb";
        _timber5unit.text = @"Per Lb";
        _labourunit.text = [NSString stringWithFormat:@"Per FT%@",temp1];
    }
    
    if([prefs stringForKey:@"timber1value"] == nil)
        _timber1.text = [NSString stringWithFormat:@"%@15.00",str];
    else
        _timber1.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timber1value"]];
    
    if([prefs stringForKey:@"timber2value"] == nil)
        _timber2.text = [NSString stringWithFormat:@"%@15.00",str];
    else
        _timber2.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timber2value"]];
    
    if([prefs stringForKey:@"timber3value"] == nil)
        _timber3.text = [NSString stringWithFormat:@"%@25.00",str];
    else
        _timber3.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timber3value"]];
    
    if([prefs stringForKey:@"timber4value"] == nil)
        _timber4.text = [NSString stringWithFormat:@"%@25.00",str];
    else
        _timber4.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timber4value"]];
    if([prefs stringForKey:@"timber5value"] == nil)
        _timber5.text = [NSString stringWithFormat:@"%@5.00",str];
    else
        _timber5.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timber5value"]];
    if([prefs stringForKey:@"timber6value"] == nil)
        _timber6.text = [NSString stringWithFormat:@"%@2.00",str];
    else
        _timber6.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timber6value"]];
    
    
    if([prefs stringForKey:@"timberother1value"] == nil)
        _timberother1.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _timberother1.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timberother1value"]];
    
    if([prefs stringForKey:@"timberother2value"] == nil)
        _timberother2.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _timberother2.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timberother2value"]];
    
    if([prefs stringForKey:@"timberother3value"] == nil)
        _timberother3.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _timberother3.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timberother3value"]];
    
    /*
    if([prefs stringForKey:@"timberother4value"] == nil)
        _timberother4.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _timberother4.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"timberother4value"]];
    */
    
    if([prefs stringForKey:@"materialother4value"] == nil)
        _materialother4value.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _materialother4value.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"materialother4value"]];
    
    /*
    if([prefs stringForKey:@"materialother5value"] == nil)
        _materialother5value.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _materialother5value.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"materialother5value"]];
    if([prefs stringForKey:@"materialother6value"] == nil)
        _materialother6value.text = [NSString stringWithFormat:@"%@0.00",str];
    else
        _materialother6value.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"materialother6value"]];
    */
    
    if([prefs stringForKey:@"timberother1label"] == nil)
        _timberother1label.text = @"Other";
    else
        _timberother1label.text = [prefs stringForKey:@"timberother1label"];
    
    if([prefs stringForKey:@"timberother2label"] == nil)
        _timberother2label.text = @"Other";
    else
        _timberother2label.text = [prefs stringForKey:@"timberother2label"];
    if([prefs stringForKey:@"timberother3label"] == nil)
        _timberother3label.text = @"Other";
    else
        _timberother3label.text = [prefs stringForKey:@"timberother3label"];
    /*
    if([prefs stringForKey:@"timberother4label"] == nil)
        _timberother4label.text = @"Other";
    else
        _timberother4label.text = [prefs stringForKey:@"timberother4label"];
    */
    
    if([prefs stringForKey:@"materialother4label"] == nil)
        _materialother4label.text = @"Other";
    else
        _materialother4label.text = [prefs stringForKey:@"materialother4label"];
    
    /*
    if([prefs stringForKey:@"materialother5label"] == nil)
        _materialother5label.text = @"Other";
    else
        _materialother5label.text = [prefs stringForKey:@"materialother5label"];
    
    if([prefs stringForKey:@"materialother6label"] == nil)
        _materialother6label.text = @"Other";
    else
        _materialother6label.text = [prefs stringForKey:@"materialother6label"];
    */
    
    if([prefs stringForKey:@"labour"] == nil)
        _laying.text = [NSString stringWithFormat:@"%@15.00",str];
    else
        _laying.text = [NSString stringWithFormat:@"%@%@",str,[prefs stringForKey:@"labour"]];
}

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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)savepreferences
{
    //paversvalue,roadbasevalue,beddingvalue,jointvalue,cementvalue,
    //materialother1,materialother2,materialother3,
    //materialothervalue1,materialothervalue2,materialothervalue3
    //layingvalue,layingother1,layingothervalue1
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
    
    [prefs setObject:_timberother1label.text forKey:@"timberother1label"];
    [prefs setObject:_timberother2label.text forKey:@"timberother2label"];
    [prefs setObject:_timberother3label.text forKey:@"timberother3label"];
    //[prefs setObject:_timberother4label.text forKey:@"timberother4label"];
    [prefs setObject:_materialother4label.text forKey:@"materialother4label"];
    [prefs setObject:_materialother5label.text forKey:@"materialother5label"];
    [prefs setObject:_materialother6label.text forKey:@"materialother6label"];
    
    //NSString *str2 = [_blocks.text stringByReplacingOccurrencesOfString:str1 withString:@""];
    NSString *str = [NSString stringWithFormat:@"%.2f",[[_timber1.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timber1value"];
    _timber1.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_timber2.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timber2value"];
    _timber2.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_timber3.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timber3value"];
    _timber3.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_timber4.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timber4value"];
    _timber4.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_timber5.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timber5value"];
    _timber5.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    /*
    str = [NSString stringWithFormat:@"%.2f",[[_timber6.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timber6value"];
    _timber6.text = [NSString stringWithFormat:@"%@%@",str1,str];
    */
    
    str = [NSString stringWithFormat:@"%.2f",[[_timberother1.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timberother1value"];
    _timberother1.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_timberother2.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timberother2value"];
    _timberother2.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_timberother3.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timberother3value"];
    _timberother3.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    /*
    str = [NSString stringWithFormat:@"%.2f",[[_timberother4.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"timberother4value"];
    _timberother4.text = [NSString stringWithFormat:@"%@%@",str1,str];
    */
    
    str = [NSString stringWithFormat:@"%.2f",[[_laying.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"labour"];
    _laying.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    
    str = [NSString stringWithFormat:@"%.2f",[[_materialother4value.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"materialother4value"];
    _materialother4value.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    /*
    str = [NSString stringWithFormat:@"%.2f",[[_materialother5value.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    [prefs setObject:str forKey:@"materialother5value"];
    _materialother5value.text = [NSString stringWithFormat:@"%@%@",str1,str];
    
    str = [NSString stringWithFormat:@"%.2f",[[_materialother6value.text stringByReplacingOccurrencesOfString:str1 withString:@""] doubleValue]];
    
    [prefs setObject:str forKey:@"materialother6value"];
    _materialother6value.text = [NSString stringWithFormat:@"%@%@",str1,str];
    */
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
    
}

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
- (IBAction)textend:(id)sender {
}
@end
