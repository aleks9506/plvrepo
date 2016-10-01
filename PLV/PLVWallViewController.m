//
//  PLVWallViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 01/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "PLVWallViewController.h"
#import "SWRevealViewController.h"

@interface PLVWallViewController ()

@end

@implementation PLVWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Menu button function
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
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

@end
