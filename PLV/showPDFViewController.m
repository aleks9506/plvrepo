//
//  showPDFViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 05/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "showPDFViewController.h"

@interface showPDFViewController ()<UIWebViewDelegate>

@end

@implementation showPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    _webview.delegate = self;
    NSLog(@"%@", _UrlRequested);
    NSURL *url = [NSURL URLWithString:_UrlRequested];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview setScalesPageToFit:YES];
    [self.webview loadRequest:request];
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

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

@end
