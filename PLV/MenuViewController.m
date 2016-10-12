//
//  MenuViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 12/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "MenuViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "LoginViewController.h"

NSManagedObject *userData;

@interface MenuViewController ()

@end

@implementation MenuViewController

- (NSPersistentContainer *)persistentContainer {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self isloginUser];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isloginUser{
    NSManagedObjectContext *context = [self persistentContainer].viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:context];
    [request setEntity:description];
    
    NSArray *arrayUser = [context executeFetchRequest:request error:nil];
    if ([arrayUser count]) {
        userData = [arrayUser objectAtIndex:0];
        _lblName.text = [userData valueForKey:@"nombre"];
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://plv.procesos-iq.com/%@",[userData valueForKey:@"image"]]]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                 _profilePhoto.image= [UIImage imageWithData: data];
            });
            
        });
        
    }else
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        LoginViewController *controller  = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)btn_logOut:(id)sender {
    NSManagedObjectContext *context = [self persistentContainer].viewContext;
    [context deleteObject:userData];
    [self isloginUser];
}
@end
