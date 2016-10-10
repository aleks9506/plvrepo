//
//  RecoverPasswordViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 10/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecoverPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPass;
- (IBAction)changePassword:(id)sender;
- (IBAction)Cancel:(id)sender;

@end
