//
//  CalculationViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/18/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "CalculationViewController.h"
#import <sqlite3.h>
#import "AppDelegate.h"
#import "RegexKitLite.h"


@interface CalculationViewController ()

@end

@implementation CalculationViewController

@synthesize index;
@synthesize data;
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
}

-(void)viewDidAppear:(BOOL)animated
{
    sqlite3_stmt *selectStatement;
    //(id,date,name,address,phone,email,margin,preference,height,length,balusterspacing,balusterwidth,picturesbalusters,picturewidth,quote,title)
    
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
    
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    
    const unichar ch1 = 0x00b2;
    NSString *temp1 = [NSString stringWithCharacters: &ch1 length:1];
    if([data.method intValue] == 0)
    {
        _pavingareaunit.text = [NSString stringWithFormat:@"M%@",temp1];
        _roadbaseunit.text = [NSString stringWithFormat:@"M%@",temp];
        _beddingsandunit.text = [NSString stringWithFormat:@"M%@",temp];
        _cementunit.text = @"Kg";
        _jointsandunit.text = @"Kg";
    }
    else
    {
        _pavingareaunit.text = [NSString stringWithFormat:@"FT%@",temp1];
        _roadbaseunit.text = [NSString stringWithFormat:@"FT%@",temp];
        _beddingsandunit.text = [NSString stringWithFormat:@"FT%@",temp];
        _cementunit.text = @"Lbs";
        _jointsandunit.text = @"Lbs";
    }
    _date.text = data.date;
    _name.text = data.name;
    _address.text = data.address;
    _phone.text = data.phone;
    _email.text = data.email;
    
    [self calculate];
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

- (IBAction)sendEmail:(id)sender {
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        
        [picker setSubject:@""];
        
        [picker setToRecipients:[NSArray arrayWithObjects:_email.text,nil]];
        
        NSString *content = [NSString stringWithFormat:@"Date: %@\n",_date.text];
        content = [content stringByAppendingFormat:@"Name: %@\n",_name.text];
        content = [content stringByAppendingFormat:@"Address: %@\n",_address.text];
        content = [content stringByAppendingFormat:@"Phone: %@\n",_phone.text];
        content = [content stringByAppendingFormat:@"Email: %@\n",_email.text];
        
        
        
        content = [content stringByAppendingFormat:@"Pavers Per Square: %@\n",_pavers.text];
        content = [content stringByAppendingFormat:@"Total Paving Area: %@\n",_pavingarea.text];
        content = [content stringByAppendingFormat:@"Total Paving Stones: %@\n",_pavingstone.text];
        content = [content stringByAppendingFormat:@"Total Road Base: %@\n",_roadbase.text];
        content = [content stringByAppendingFormat:@"Total Bedding Sand: %@\n",_beddingsand.text];
        content = [content stringByAppendingFormat:@"Total Sand & Cement: %@\n",_cement.text];
        content = [content stringByAppendingFormat:@"Total Joint Sand: %@\n",_jointsand.text];
        content = [content stringByAppendingFormat:@"Total Compaction: %@\n",_compaction.text];
        
        
        
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

-(void)savedata
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
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

-(void)savepreferences
{
    sqlite3_stmt *selectStatement;
    char *selectSql = "update jobstable set date=?,name=?,phone=?,address=?,email=? where id=?";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(selectStatement, 1, [_date.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 2, [_name.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 3, [_phone.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 4, [_address.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 5, [_email.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(selectStatement, 6, [data.calcid intValue]);
        int success = sqlite3_step(selectStatement);
        sqlite3_reset(selectStatement);
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        
        
    }
    sqlite3_finalize(selectStatement);
}

- (IBAction)saveData:(id)sender {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
}

- (IBAction)textEnd:(id)sender {
}

-(void)calculate
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
        _pavingarea.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = value/((width2value/1000) * (length2value/1000));
        _pavingstone.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = value / value1;
        _pavers.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = width1value * length1value * (depth1value/1000);
        _roadbase.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = width1value * length1value * (depth2value/1000);
        _beddingsand.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = width1value * length1value * 0.583;
        _jointsand.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = ((width1value + length1value) * 2) * 9;
        _cement.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = width1value * length1value * 0.3;
        _compaction.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
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
        _pavingarea.text = [NSString stringWithFormat:@"%.1f", round(value * 100)/100.0];
        
        value = value/((width2value/12) * (length2value/12));
        _pavingstone.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = value / value1;
        _pavers.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = width1value * length1value * (depth1value/12);
        _roadbase.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = width1value * length1value * (depth2value/12);
        _beddingsand.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = width1value * length1value * 0.12;
        _jointsand.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = ((width1value + length1value) * 2) * 6.0476327;
        _cement.text = [NSString stringWithFormat:@"%.2f", round(value * 100)/100.0];
        
        value = width1value * length1value * 0.028;
        _compaction.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
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

-(NSString *)display:(int)m u:(int)u d:(int)d
{
    if(m == 0 && u == 0)
        return @"0";
    if(m != 0 && u != 0)
        return [NSString stringWithFormat:@"%d %d/%d",m,u,16];//String.format("%d %d/%d", m,u,16);
    else if(m == 0)
        return [NSString stringWithFormat:@"%d/%d",u,16];//String.format("%d/%d", u,16);
    else
        return [NSString stringWithFormat:@"%d",m];//String.format("%d", m);
}

@end
