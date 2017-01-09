//
//  CalculatorViewController.m
//  DeckingCalculatorPro
//
//  Created by lichuncheng on 12/17/16.
//  Copyright © 2016 lichuncheng. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Fraction.h"
#import "RegexKitLite.h"
#import "AppDelegate.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

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

/*
- (void)viewDidLayoutSubviews
{
    float theWidth = self.view.frame.size.width;
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, theWidth, 44);
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self fieldinitialize];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)savepreferences
{
    //save data
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    sqlite3_stmt *insertStatement;
    char *insertSql = "INSERT INTO jobstable (date,name,address,phone,email,quote,preference,width1,length1,width2,length2,depth1,depth2,pavingjob,pavingstone,roadbase,beddingsand,jointsand,cementdege,compactor,margin,tax,title) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    //int ret = sqlite3_prepare_v2(delegate.db, insertSql, -1, &insertStatement, NULL);
    if (sqlite3_prepare_v2(delegate.db, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
        
        
        //sqlite3_bind_int(insertStatement, 1, 1);
        sqlite3_bind_text(insertStatement, 1, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 2, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 3, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 4, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 5, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 6, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        
        if(selectedmethod == 0)
        {
            sqlite3_bind_text(insertStatement, 7, [@"0" UTF8String],  -1, SQLITE_TRANSIENT);
            
        }
        else
        {
            sqlite3_bind_text(insertStatement, 7, [@"1" UTF8String],  -1, SQLITE_TRANSIENT);
            
        }
        
        sqlite3_bind_text(insertStatement, 8, [_width1.text UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 9, [_length1.text UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 10, [_width2.text UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 11, [_length2.text UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 12, [_depth1.text UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 13, [_depth2.text UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 14, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 15, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 16, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 17, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 18, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 19, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 20, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 21, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 22, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 23, [comment1.text UTF8String],  -1, SQLITE_TRANSIENT);
        
        
        
        // sql
        if (sqlite3_step(insertStatement) != SQLITE_DONE) {
            NSLog(@"Error");
            
        }
        sqlite3_finalize(insertStatement);
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        //[view release];
        
    }
    NSLog(@"FAILED TO INSERT THE RECORD : %@",[NSString stringWithCString:sqlite3_errmsg(delegate.db) encoding:NSStringEncodingConversionAllowLossy]);
    
    //[self.navigationController popViewControllerAnimated:YES];
}
-(void)savedata
{
    if([_compaction.text length] == 0)
    {
        UIAlertView *view1 = [[UIAlertView alloc] initWithTitle:@"" message:@"There is no data to save." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [view1 show];
        //[view1 release];
        return;
    }
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save calculator answers?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    view.tag = 1;
    [view show];
    //[view release];
}

- (void) fieldinitialize{
    
    
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    
    const unichar ch1 = 0x00b2;
    NSString *temp1 = [NSString stringWithCharacters: &ch1 length:1];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    _square.text = @"";
    _pavingstone.text = @"";
    _privatearea.text = @"";
    _roadbase.text = @"";
    _beddingsand.text = @"";
    _jointsand.text = @"";
    _cement.text = @"";
    _compaction.text = @"";
    _width1.text = @"";
    _length1.text = @"";
    _width2.text = @"";
    _length2.text = @"";
    
    
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] isEqualToString:@"metric"] == YES)
    {
        selectedmethod = 0;
    }
    else
        selectedmethod = 1;
    if(selectedmethod == 0)
    {
        _width1unit.text = @"Metres";
        _length1unit.text = @"Metres";
        
        _width2unit.text = @"MM";
        _length2unit.text = @"MM";
        
        _depth1unit.text = @"MM";
        _depth2unit.text = @"MM";
        
        _pavingareaunit.text = [NSString stringWithFormat:@"M%@",temp1];
        _roadbaseunit.text = [NSString stringWithFormat:@"M%@",temp];
        _beddingsandunit.text = [NSString stringWithFormat:@"M%@",temp];
        _jointsandunit.text = @"Kg";
        _cementunit.text = @"Kg";
        
        _depth1.text = @"100";
        _depth2.text = @"30";
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Paving Calculator - Metric"];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        _titlelabel.attributedText = attributeString;
        
    }
    else{
        _pavingareaunit.text = [NSString stringWithFormat:@"FT%@",temp1];
        _roadbaseunit.text = [NSString stringWithFormat:@"FT%@",temp];
        _beddingsandunit.text = [NSString stringWithFormat:@"FT%@",temp];
        _jointsandunit.text = @"Lbs";
        _cementunit.text = @"Lbs";
        
        _width1unit.text = @"FEET";
        _length1unit.text = @"FEET";
        
        _width2unit.text = @"INCHES";
        _length2unit.text = @"INCHES";
        
        _depth1unit.text = @"INCHES";
        _depth2unit.text = @"INCHES";
        
        _depth1.text = @"3 15/16";
        _depth2.text = @"1 3/16";
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Paving Calculator - Imperial"];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        //_titlelabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"combobackground.png"]];
        _titlelabel.attributedText = attributeString;
        
    }
    
}

- (IBAction)getAnswer:(id)sender {
    
    double checkval = 0, width1value,length1value,width2value,length2value,depth1value,depth2value,value,value1;
    [_width1 resignFirstResponder];
    [_length1 resignFirstResponder];
    [_depth1 resignFirstResponder];
    
    [_width2 resignFirstResponder];
    [_length2 resignFirstResponder];
    [_depth2 resignFirstResponder];
    
    if([_width1.text length] == 0 || [_width2.text length] == 0)
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input width." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
        //[view release];
        return;
    }
    
    if([_length1.text length] == 0 || [_length2.text length] == 0)
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input length." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
        //[view release];
        return;
    }
    
    if([_depth1.text length] == 0 || [_depth2.text length] == 0)
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input depth." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
        //[view release];
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] isEqualToString:@"metric"] == YES)
        selectedmethod = 0;
    else
        selectedmethod = 1;
    if(selectedmethod == 0)
    {
        checkval = [_width1.text doubleValue];
        if(checkval < 0 || checkval > 100 || checkval == 0.0)
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Width" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        
        checkval = [_length1.text doubleValue];
        if(checkval < 0 || checkval > 100 || checkval == 0.0)
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Length" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        
        checkval = [_width2.text doubleValue];
        if(checkval < 0 || checkval > 1500 || checkval == 0.0)
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Width" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        
        checkval = [_length2.text doubleValue];
        if(checkval < 0 || checkval > 1500 || checkval == 0.0)
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Length" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        
        checkval = [_depth1.text doubleValue];
        if(checkval < 0 || checkval > 150 || checkval == 0.0)
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        
        checkval = [_depth2.text doubleValue];
        if(checkval < 0 || checkval > 150 || checkval == 0.0)
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        
        
        
        _width1.text = [NSString stringWithFormat:@"%.3f", [_width1.text doubleValue]];
        _length1.text = [NSString stringWithFormat:@"%.3f", [_length1.text doubleValue]];
        
        
        //calcuate values
        width1value = [_width1.text doubleValue];
        length1value = [_length1.text doubleValue];
        width2value = [_width2.text doubleValue];
        length2value = [_length2.text doubleValue];
        depth1value = [_depth1.text doubleValue];
        depth2value = [_depth2.text doubleValue];
        
        
        value = width1value * length1value;
        value1 = value;
        _privatearea.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = value/((width2value/1000) * (length2value/1000));
        _pavingstone.text = [NSString stringWithFormat:@"%d", (int)round(value)];
        
        value = value / value1;
        _square.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
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
        int ret = [self checkCompleteValue:_width1 min:min max:max];
        if(ret == 0)
        {
            _width1.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        else if(ret == 1)
        {
            _width1.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        width1fraction = [[Fraction alloc] init];
        width1fraction.main = main;
        width1fraction.up = up;
        width1fraction.down = down;
        
        ret = [self checkCompleteValue:_length1 min:min max:max];
        if(ret == 0)
        {
            _length1.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        else if(ret == 1)
        {
            _length1.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        length1fraction = [[Fraction alloc] init];
        length1fraction.main = main;
        length1fraction.up = up;
        length1fraction.down = down;
        
        max.main = 1500;
        max.up = 0;
        max.down = 0;
        
        ret = [self checkCompleteValue:_width2 min:min max:max];
        if(ret == 0)
        {
            _width2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        else if(ret == 1)
        {
            _width2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        width2fraction = [[Fraction alloc] init];
        width2fraction.main = main;
        width2fraction.up = up;
        width2fraction.down = down;
        
        ret = [self checkCompleteValue:_length2 min:min max:max];
        if(ret == 0)
        {
            _length2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        else if(ret == 1)
        {
            _length2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        length2fraction = [[Fraction alloc] init];
        length2fraction.main = main;
        length2fraction.up = up;
        length2fraction.down = down;
        
        
        max.main = 8;
        max.up = 0;
        max.down = 0;
        
        
        ret = [self checkCompleteValue:_depth1 min:min max:max];
        if(ret == 0)
        {
            _depth1.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        else if(ret == 1)
        {
            _depth2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        depth1fraction = [[Fraction alloc] init];
        depth1fraction.main = main;
        depth1fraction.up = up;
        depth1fraction.down = down;
        
        ret = [self checkCompleteValue:_depth2 min:min max:max];
        if(ret == 0)
        {
            _depth2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct data" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
        else if(ret == 1)
        {
            _depth2.text = @"";
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [view show];
            //[view release];
            return;
        }
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
        _privatearea.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
        value = value/((width2value/12) * (length2value/12));
        _pavingstone.text = [NSString stringWithFormat:@"%d", (int)round(value)];
        
        value = value / value1;
        _square.text = [NSString stringWithFormat:@"%.1f", round(value * 10)/10.0];
        
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

-(int)checkCompleteValue:(UITextField *)edit min:(Fraction *)min max:(Fraction *)max
{
    double value;
    NSString *str = edit.text;
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
    edit.text = [NSString stringWithFormat:@"%@",[self display:main u:up d:16]];
    return 2;
}

- (IBAction)textend:(id)sender {
}

- (IBAction)saveData:(id)sender {
    if([_compaction.text length] == 0)
    {
        UIAlertView *view1 = [[UIAlertView alloc] initWithTitle:@"" message:@"There is no data to save." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [view1 show];
        //[view1 release];
        return;
    }
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save calculator answers?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    view.tag = 1;
    [view show];
    //[view release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1 && buttonIndex == 0)
    {
        /*
         UIAlertView *commentView = [[UIAlertView alloc] initWithTitle:@"Please enter job name." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
         
         comment1 = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 24.0)];
         comment1.autocorrectionType = UITextAutocorrectionTypeNo;
         comment1.keyboardType = UIKeyboardTypeDefault;
         comment1.returnKeyType = UIReturnKeyDone;
         comment1.clearButtonMode = UITextFieldViewModeWhileEditing;
         
         
         UIFont* font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
         [comment1 setFont:font];
         [comment1 setBackgroundColor:[UIColor whiteColor]];
         comment1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         [comment1 becomeFirstResponder];
         comment1.delegate = self;
         [commentView addSubview:comment1];
         commentView.tag = 2;
         [commentView show];
         [commentView release];
         return;
         */
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter job name." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              comment1 = alert.textFields.firstObject;
                              //NSString *temp = comment1.text;
                              [self savepreferences];
                          }]];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Enter Name:";
            textField.secureTextEntry = NO;
        }];
        [self presentViewController:alert animated:YES completion:nil];
        //[self savepreferences];
    }
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
