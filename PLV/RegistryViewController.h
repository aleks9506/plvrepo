//
//  RegistryViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 10/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistryViewController : UIViewController
- (IBAction)SelectDocumentation:(id)sender;
- (IBAction)selectCountry:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txt_documentation;
@property (weak, nonatomic) IBOutlet UITextField *txtname;
@property (weak, nonatomic) IBOutlet UITextField *txtlastname;
@property (weak, nonatomic) IBOutlet UITextField *txtMail;
@property (weak, nonatomic) IBOutlet UITextField *txtpassword;
@property (weak, nonatomic) IBOutlet UITextField *txtconfirmPass;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end
