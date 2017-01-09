//
//  NoteViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController
- (IBAction)saveNote:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
