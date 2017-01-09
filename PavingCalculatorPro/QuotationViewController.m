//
//  QuotationViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "QuotationViewController.h"
#import <sqlite3.h>
#import "AppDelegate.h"
#import "Fraction.h"
#import "RegexKitLite.h"

@interface QuotationViewController ()

@end

@implementation QuotationViewController
@synthesize index;
@synthesize data;

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollview.contentInset = contentInsets;
    _scrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, _margin1.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _margin1.frame.origin.y-kbSize.height);
        [_scrollview setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollview.contentInset = contentInsets;
    _scrollview.scrollIndicatorInsets = contentInsets;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
    sqlite3_stmt *selectStatement;
    char *selectSql = "SELECT * FROM jobstable";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //CalculationData *data;
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            //id integer primary key autoincrement,date TEXT,name TEXT,address TEXT,phone TEXT,email TEXT,quote TEXT,method TEXT,option TEXT,value TEXT,height TEXT,width TEXT,length TEXT,margin TEXT,tax TEXT,title TEXT)
            //data = [[CalculationData alloc] init];
            int no = sqlite3_column_int(selectStatement, 0);
            data.calcid = [NSString stringWithFormat:@"%d",no];
            data.width1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)];
            data.width2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 10)];
            data.length1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)];
            data.length2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 11)];
            data.depth1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 12)];
            data.depth2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 13)];
            data.method = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)];
            data.option = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)];
            data.value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)];
            data.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 23)];
            
            data.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            data.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            data.address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)];
            data.phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            data.email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)];
            data.quote = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)];
            
            //[data release];
        }
        
    }
    //statement close
    sqlite3_finalize(selectStatement);
    
    _date.text = data.date;
    _name.text = data.name;
    _address.text = data.address;
    _phone.text = data.phone;
    _email.text = data.email;
    _quote.text = data.quote;
    
    [self calculate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    // Do any additional setup after loading the view.
    data = [[CalculationData alloc] init];
    //self.margin1.delegate = self;
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender {
    //sender.delegate = self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField becomeFirstResponder];
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

-(void)calculate
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //plantvalue,plantothervalue1,plantothervalue2,plantothervalue3,toolsvalue,toolsothervalue1,toolsothervalue2,toolsothervalue3
    
    int currency;
    NSString *str;
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
    
    NSString *t1,*t2,*t3,*t4,*t5,*t6,*t7,*t8,*t9,*t10;
    t1 = [prefs stringForKey:@"plantvalue"];
    if([t1 length] == 0)
        t1 = @"10.00";
    _compactor.text = [NSString stringWithFormat:@"%@%@",str,t1];
    
    t2 = [prefs stringForKey:@"plantothervalue1"];
    if([t2 length] == 0)
        t2 = @"0.00";
    _plantother1.text = [NSString stringWithFormat:@"%@%@",str,t2];
    
    t3 = [prefs stringForKey:@"plantothervalue2"];
    if([t3 length] == 0)
        t3 = @"0.00";
    _plantother2.text = [NSString stringWithFormat:@"%@%@",str,t3];
    
    t4 = [prefs stringForKey:@"plantothervalue3"];
    if([t4 length] == 0)
        t4 = @"0.00";
    _plantother3.text = [NSString stringWithFormat:@"%@%@",str,t4];
    
    double d = [t1 doubleValue] + [t2 doubleValue] + [t3 doubleValue] + [t4 doubleValue];
    _plantnet.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    t1 = [prefs stringForKey:@"toolsvalue"];
    if([t1 length] == 0)
        t1 = @"10.00";
    _toolsvalue.text = [NSString stringWithFormat:@"%@%@",str,t1];
    
    t2 = [prefs stringForKey:@"toolsothervalue1"];
    if([t2 length] == 0)
        t2 = @"0.00";
    _equipother1.text = [NSString stringWithFormat:@"%@%@",str,t2];
    
    t3 = [prefs stringForKey:@"toolsothervalue2"];
    if([t3 length] == 0)
        t3 = @"0.00";
    _equipother2.text = [NSString stringWithFormat:@"%@%@",str,t3];
    
    t4 = [prefs stringForKey:@"toolsothervalue3"];
    if([t4 length] == 0)
        t4 = @"0.00";
    _equipother3.text = [NSString stringWithFormat:@"%@%@",str,t4];
    
    d = [t1 doubleValue] + [t2 doubleValue] + [t3 doubleValue] + [t4 doubleValue];
    _netequip.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    [self valueSettings];
    
    //paversvalue,roadbasevalue,beddingvalue,jointvalue,cementvalue,
    
    
    t1 = paverjobstr;
    t2 = [prefs stringForKey:@"timber1value"];
    if([t2 length] == 0)
        t2 = @"15.00";
    d = [t1 doubleValue] * [t2 doubleValue];
    _pavers.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    t3 = [NSString stringWithFormat:@"%f",d];
    
    t1 = roadbasestr;
    t2 = [prefs stringForKey:@"timber2value"];
    if([t2 length] == 0)
        t2 = @"15.00";
    d = [t1 doubleValue] * [t2 doubleValue];
    _roadbase.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    t4 = [NSString stringWithFormat:@"%f",d];
    
    t1 = beddingsandstr;
    t2 = [prefs stringForKey:@"timber3value"];
    if([t2 length] == 0)
        t2 = @"25.00";
    d = [t1 doubleValue] * [t2 doubleValue];
    _beddingsand.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    t5 = [NSString stringWithFormat:@"%f",d];
    
    t1 = jointsandstr;
    t2 = [prefs stringForKey:@"timber4value"];
    if([t2 length] == 0)
        t2 = @"5.00";
    d = [t1 doubleValue] * [t2 doubleValue];
    _jointsand.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    t6 = [NSString stringWithFormat:@"%f",d];
    
    t1 = cementedgestr;
    t2 = [prefs stringForKey:@"timber5value"];
    if([t2 length] == 0)
        t2 = @"2.00";
    d = [t1 doubleValue] * [t2 doubleValue];
    _cement.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    t7 = [NSString stringWithFormat:@"%f",d];
    
    //materialothervalue1,materialothervalue2,materialothervalue3
    
    t1 = [prefs stringForKey:@"timberother1value"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _materialvalue1.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t8 = t1;
    
    t1 = [prefs stringForKey:@"timberother2value"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _materialvalue2.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t9 = t1;
    
    t1 = [prefs stringForKey:@"timberother3value"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _materialvalue3.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t10 = t1;
    
    
    d = [t3 doubleValue] + [t4 doubleValue] + [t5 doubleValue] + [t6 doubleValue] + [t7 doubleValue] + [t8 doubleValue] + [t9 doubleValue] + [t10 doubleValue];
    _materialnet.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    //layingvalue,layingother1,layingothervalue1
    t2 = [prefs stringForKey:@"layingvalue"];
    if([t2 length] == 0)
        t2 = @"15.00";
    d = [t2 doubleValue] * [paverjobstr doubleValue];
    _laying.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    t3 = [NSString stringWithFormat:@"%f",d];
    
    t2 = [prefs stringForKey:@"materialother4value"];
    if([t2 length] == 0)
        t2 = @"0.00";
    _layingother1.text = [NSString stringWithFormat:@"%@%@",str,t2];
    t4 = t2;
    
    d = [t3 doubleValue] + [t4 doubleValue];
    _labournet.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    d = [[_plantnet.text substringFromIndex:1] doubleValue] + [[_netequip.text substringFromIndex:1] doubleValue] + [[_materialnet.text substringFromIndex:1] doubleValue] + [[_labournet.text substringFromIndex:1] doubleValue];
    _netcost.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    [self valueCalculate];
    
    [self valueCalculate];
    
}
-(void)valueCalculate
{
    NSString *t1,*netcost,*margin,*subto,*taxto;
    double d;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int currency;
    NSString *str;
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
    
    
    t1 = _margin1.text;
    if([t1 length] == 0)
    {
        _margin1.text = @"20";
        t1 = @"20";
    }
    
    netcost = _netcost.text;
    t1 = [NSString stringWithFormat:@"%@%.2f",str,[[netcost substringFromIndex:1] doubleValue] * [t1 doubleValue] / 100];//String.format("%.2f",Double.parseDouble(t1) * Double.parseDouble(netcost) / 100);
    
    //marginvalue.setText("$" + present(t1));
    _margin2.text = t1;
    margin = t1;
    
    //t1 = String.format("%.2f",Double.parseDouble(netcost) + Double.parseDouble(margin));
    d = [[netcost substringFromIndex:1] doubleValue] + [[margin substringFromIndex:1] doubleValue];
    t1 = [NSString stringWithFormat:@"%@%.2f",str,d];
    _subtotal.text = t1;
    //subtotal.setText("$" + present(t1));
    subto = t1;
    
    
    t1 = _taxmount1.text;
    if([t1 length] == 0)
    {
        _taxmount1.text = @"10";
        t1 = @"10";
    }
    
    d = [t1 doubleValue] * [[subto substringFromIndex:1] doubleValue]/100;
    t1 = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    _taxmount2.text = t1;
    taxto = t1;
    
    d = [[subto substringFromIndex:1] doubleValue] + [[taxto substringFromIndex:1] doubleValue];
    t1 = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];//String.format("%.2f",(Double.parseDouble(subto) + Double.parseDouble(taxto)));
    //total.setText("$" + present(t1));
    _total.text = t1;
}

-(void)valueSettings
{
    double width1value,length1value,width2value,length2value,depth1value,depth2value,value,value1;
    if([data.method intValue] == 0)
    {
        width1value = [data.width1 doubleValue];
        length1value = [data.length1 doubleValue];
        
        width2value = [data.width2 doubleValue];
        length2value = [data.length2 doubleValue];
        
        depth1value = [data.depth1 doubleValue];
        depth2value = [data.depth2 doubleValue];
        
        //_totalpaving.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        value = width1value * length1value;
        value1 = value;
        paversstr = [NSString stringWithFormat:@"%f", value];
        paverjobstr = paversstr;
        
        
        value = value / value1;
        _pavers.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = width1value * length1value * (depth1value/1000);
        roadbasestr = [NSString stringWithFormat:@"%f", value];
        
        value = width1value * length1value * (depth2value/1000);
        beddingsandstr = [NSString stringWithFormat:@"%f", value];
        
        value = width1value * length1value * 0.583;
        jointsandstr = [NSString stringWithFormat:@"%f", value];
        
        value = ((width1value + length1value) * 2) * 9;
        cementedgestr = [NSString stringWithFormat:@"%f", value];
        
    }
    else
    {
        Fraction *length1fraction,*width1fraction,*length2fraction,*width2fraction,*depth1fraction,*depth2fraction;
        Fraction *min = [[Fraction alloc] init];
        min.main = 0;
        min.up = 0;
        min.down = 0;
        Fraction *max = [[Fraction alloc] init];
        max.main = 100;
        max.up = 0;
        max.down = 0;
        int ret = [self checkCompleteValue:data.width1 min:min max:max];
        
        width1fraction = [[Fraction alloc] init];
        width1fraction.main = main;
        width1fraction.up = up;
        width1fraction.down = down;
        
        ret = [self checkCompleteValue:data.length1 min:min max:max];
        
        length1fraction = [[Fraction alloc] init];
        length1fraction.main = main;
        length1fraction.up = up;
        length1fraction.down = down;
        
        max.main = 1500;
        max.up = 0;
        max.down = 0;
        
        ret = [self checkCompleteValue:data.width2 min:min max:max];
        
        width2fraction = [[Fraction alloc] init];
        width2fraction.main = main;
        width2fraction.up = up;
        width2fraction.down = down;
        
        ret = [self checkCompleteValue:data.length2 min:min max:max];
        
        length2fraction = [[Fraction alloc] init];
        length2fraction.main = main;
        length2fraction.up = up;
        length2fraction.down = down;
        
        
        max.main = 8;
        max.up = 0;
        max.down = 0;
        
        
        ret = [self checkCompleteValue:data.depth1 min:min max:max];
        
        depth1fraction = [[Fraction alloc] init];
        depth1fraction.main = main;
        depth1fraction.up = up;
        depth1fraction.down = down;
        
        ret = [self checkCompleteValue:data.depth2 min:min max:max];
        
        depth2fraction = [[Fraction alloc] init];
        depth2fraction.main = main;
        depth2fraction.up = up;
        depth2fraction.down = down;
        
        
        width1value = (width1fraction.main * 16 + width1fraction.up)/16.0;
        length1value = (length1fraction.main * 16 + length1fraction.up)/16.0;
        width2value = (width2fraction.main * 16 + width2fraction.up)/16.0;
        length2value = (length2fraction.main * 16 + length2fraction.up)/16.0;
        depth1value = (depth1fraction.main * 16 + depth1fraction.up)/16.0;
        depth2value = (depth2fraction.main * 16 + depth2fraction.up)/16.0;
        
        
        /*
        [width1fraction release];
        [length1fraction release];
        [width2fraction release];
        [length2fraction release];
        [depth1fraction release];
        [depth2fraction release];
        [min release];
        [max release];
        */
         
        value = width1value * length1value;
        value1 = value;
        paversstr = [NSString stringWithFormat:@"%f", value];
        paverjobstr = paversstr;
        
        
        value = width1value * length1value * (depth1value/12);
        roadbasestr = [NSString stringWithFormat:@"%f", value];
        
        value = width1value * length1value * (depth2value/12);
        beddingsandstr = [NSString stringWithFormat:@"%f", value];
        
        value = width1value * length1value * 0.12;
        jointsandstr = [NSString stringWithFormat:@"%f", value];
        
        value = ((width1value + length1value) * 2) * 6.0476327;
        cementedgestr = [NSString stringWithFormat:@"%f", value];
        
        
    }
}

-(int)checkCompleteValue:(NSString *)edit min:(Fraction *)min max:(Fraction *)max
{
    double value;
    NSString *str = edit;
    NSString *temp;
    NSString *pat = @"(^[0-9]+)\\p{Space}([0-9]+)/([1-9]+)$";
    NSString *result = [str stringByMatching:pat];
    if(result != nil) {
        
        main = [[str stringByMatching:pat capture:1] intValue];//Integer.parseInt(m.group(1));
        up = [[str stringByMatching:pat capture:2] intValue];//Integer.parseInt(m.group(2));
        down = [[str stringByMatching:pat capture:3] intValue];//Integer.parseInt(m.group(3));
        main += up/down;
        value = up/(down * 1.0);
        //value = Math.round(value * 10)/10.0;
        down = 16;
        up = (int)round(value *16);
        //System.out.println(main + " " + up + " " + down);
        if(main * 16 + up < min.main * 16 + min.up)
            return 1;
        if(main *16 + up > max.main * 16 + max.up)
            return 1;
        
    }
    else
    {
        pat = @"(^[0-9]+)\\.([0-9]+)$";
        result = [str stringByMatching:pat];
        if(result != nil)
        {
            main = [[str stringByMatching:pat capture:1] intValue];//Integer.parseInt(m.group(1));
            temp = [NSString stringWithFormat:@"%@.%@",[str stringByMatching:pat capture:1],[str stringByMatching:pat capture:2]];//String.format("%s.%s", m.group(1),m.group(2));
            value = [temp doubleValue];//Double.parseDouble(temp);
            value = value - main;
            down = 16;
            up = (int)round(value *16);
            //System.out.println(main + " " + up + " " + down);
        }
        else
        {
            pat = @"(^[0-9]+)/([1-9]+)$";
            result = [str stringByMatching:pat];
            if(result != nil)
            {
                main = [[str stringByMatching:pat capture:1] intValue]/[[str stringByMatching:pat capture:2] intValue];//Integer.parseInt(m.group(1))/Integer.parseInt(m.group(2));
                up = [[str stringByMatching:pat capture:1] intValue] - main * [[str stringByMatching:pat capture:2] intValue];//Integer.parseInt(m.group(1))  - main * Integer.parseInt(m.group(2));
                //(up * 1.0)/(Integer.parseInt(m.group(2)) * 1.0);
                value = (up * 1.0)/([[str stringByMatching:pat capture:2] intValue] * 1.0);
                down = 16;
                up = (int)round(value * 16);
                
            }
            else
            {
                pat = @"(^[0-9]+)$";
                result = [str stringByMatching:pat];
                if(result != nil)
                {
                    main = [[str stringByMatching:pat capture:1] intValue];//Integer.parseInt(m.group(0));
                    up = 0;
                    down = 16;
                }
                else
                    return 0;
            }
        }
        
    }
    //System.out.println(main + " " + up + " " + down);
    if(main * 16 + up < min.main * 16 + min.up)
        return 1;
    if(main *16 + up > max.main * 16 + max.up)
        return 1;
    //edit.text = [NSString stringWithFormat:@"%@",[self display:main u:up d:16]];
    return 2;
}

-(void)savedata
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    //[view release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self savepreferences];
    }
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)savepreferences
{
    sqlite3_stmt *selectStatement;
    char *selectSql = "update jobstable set date=?,name=?,phone=?,address=?,email=?,quote=? where id=?";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(selectStatement, 1, [_date.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 2, [_name.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 3, [_phone.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 4, [_address.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 5, [_email.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 6, [_quote.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(selectStatement, 7, [data.calcid intValue]);
        int success = sqlite3_step(selectStatement);
        sqlite3_reset(selectStatement);
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        //[view release];
        
    }
    
    sqlite3_finalize(selectStatement);
    [self.margin1 becomeFirstResponder];
}



- (IBAction)texteditingValue:(id)sender {
    
}

- (IBAction)textend:(id)sender {
    
}

- (IBAction)emailSend:(id)sender {
    
    if([MFMailComposeViewController canSendMail])
    {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    
    [picker setSubject:@""];
    
    [picker setToRecipients:[NSArray arrayWithObjects:_email.text,nil]];
    
    NSString *content = [NSString stringWithFormat:@"Quote: %@\n",_date.text];
    content = [NSString stringWithFormat:@"Date: %@\n",_date.text];
    content = [content stringByAppendingFormat:@"Name: %@\n",_name.text];
    content = [content stringByAppendingFormat:@"Address: %@\n",_address.text];
    content = [content stringByAppendingFormat:@"Phone: %@\n",_phone.text];
    content = [content stringByAppendingFormat:@"Email: %@\n",_email.text];
    
    content = [content stringByAppendingFormat:@"Plant: %@\n",_compactor.text];
    content = [content stringByAppendingFormat:@"Other: %@\n",_plantother1.text];
    content = [content stringByAppendingFormat:@"Other: %@\n",_plantother2.text];
    content = [content stringByAppendingFormat:@"Other: %@\n",_plantother3.text];
    content = [content stringByAppendingFormat:@"Net Plant: %@\n",_plantnet.text];
    
    content = [content stringByAppendingFormat:@"Equipment: %@\n",_toolsvalue.text];
    content = [content stringByAppendingFormat:@"Other: %@\n",_equipother1.text];
    content = [content stringByAppendingFormat:@"Other: %@\n",_equipother2.text];
    content = [content stringByAppendingFormat:@"Other: %@\n",_equipother3.text];
    content = [content stringByAppendingFormat:@"Net Equipment: %@\n",_netequip.text];
    
        content = [content stringByAppendingFormat:@"Pavers: %@\n",_pavers.text];
        content = [content stringByAppendingFormat:@"Road Base: %@\n",_roadbase.text];
        content = [content stringByAppendingFormat:@"Bedding Sand: %@\n",_beddingsand.text];
        content = [content stringByAppendingFormat:@"Joint Sand: %@\n",_jointsand.text];
        content = [content stringByAppendingFormat:@"Sand & Cement: %@\n",_cement.text];
        content = [content stringByAppendingFormat:@"Other: %@\n",_materialvalue1.text];
        content = [content stringByAppendingFormat:@"Other: %@\n",_materialvalue2.text];
        content = [content stringByAppendingFormat:@"Other: %@\n",_materialvalue3.text];
        content = [content stringByAppendingFormat:@"Net Materials: %@\n",_materialnet.text];
        
        content = [content stringByAppendingFormat:@"Laying: %@\n",_laying.text];
        content = [content stringByAppendingFormat:@"Other: %@\n",_layingother1.text];
        content = [content stringByAppendingFormat:@"Other: %@\n",_labournet.text];
        
        content = [content stringByAppendingFormat:@"Total Net Costs: %@\n",_netcost.text];
        content = [content stringByAppendingFormat:@"My Margin: %@ %@\n",_margin1.text,_margin2.text];
        content = [content stringByAppendingFormat:@"Sub TOTAL: %@\n",_subtotal.text];
        content = [content stringByAppendingFormat:@"Tax Amount: %@ %@\n",_taxmount1.text,_taxmount2.text];
        content = [content stringByAppendingFormat:@"TOTAL: %@\n",_total.text];
    
    
    
    [picker setMessageBody:content isHTML:NO];
    
    [self presentModalViewController:picker animated:YES];
    
    //[picker release];
}
else
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Can not send Mail." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
    //[view release];
}
}

- (void) mailComposeController:(MFMailComposeViewController *) controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    UIAlertView *view;
    if(result == MFMailComposeResultSent)
    {
        view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    }
    else
    {
        view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully not sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    }
    [view show];
    //[view release];
    [controller dismissModalViewControllerAnimated:YES];
}
- (IBAction)textediting:(id)sender {
    [self valueCalculate];
}
- (IBAction)textStartWriting:(id)sender {
    [sender becomeFirstResponder];
}
@end
