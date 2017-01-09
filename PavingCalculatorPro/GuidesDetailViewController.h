//
//  GuidesDetailViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidesDetailViewController : UIViewController
{
    int index;
}
@property (assign) int index;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
