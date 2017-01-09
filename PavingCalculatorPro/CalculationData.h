//
//  CalculationData.h
//  materialweight
//
//  Created by Lion User on 05/05/2013.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculationData : NSObject
{
    NSString *calcid;
    NSString *title;
    NSString *width1;
    NSString *width2;
    NSString *length1;
    NSString *length2;
    NSString *depth1;
    NSString *depth2;
    NSString *method;
    NSString *option;
    NSString *value;
    NSString *date;
    NSString *name;
    NSString *address;
    NSString *phone;
    NSString *email;
    NSString *quote;
}
@property (retain) NSString *calcid;
@property (retain) NSString *title;
@property (retain) NSString *width1;
@property (retain) NSString *width2;
@property (retain) NSString *length1;
@property (retain) NSString *length2;
@property (retain) NSString *depth1;
@property (retain) NSString *depth2;
@property (retain) NSString *method;
@property (retain) NSString *option;
@property (retain) NSString *value;

@property (retain) NSString *date;
@property (retain) NSString *name;
@property (retain) NSString *address;
@property (retain) NSString *phone;
@property (retain) NSString *email;
@property (retain) NSString *quote;



@end
