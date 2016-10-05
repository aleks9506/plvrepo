//
//  showPDFViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 05/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showPDFViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet NSString *UrlRequested;
@end
