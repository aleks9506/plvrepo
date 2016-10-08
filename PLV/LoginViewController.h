//
//  LoginViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 08/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtMail;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
- (IBAction)btn_Login:(id)sender;

@end
