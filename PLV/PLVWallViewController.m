//
//  PLVWallViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 01/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "PLVWallViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface PLVWallViewController ()


@end


@implementation PLVWallViewController

- (NSPersistentContainer *)persistentContainer {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self isUserLogin];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Menu button function
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

-(void)isUserLogin{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *context = [self persistentContainer].viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:context];
    [request setEntity:description];
    
    NSArray *arrayUser = [context executeFetchRequest:request error:nil];
    if ([arrayUser count] != 0) {
        NSLog(@"tiene datos");
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        LoginViewController *controller  = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.revealViewController setFrontViewController:controller animated:YES];
        
        //[self presentViewController:controller animated:YES completion:nil];
        
    }else
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        LoginViewController *controller  = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
    
    
    
    
    
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
