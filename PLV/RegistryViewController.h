//
//  RegistryViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 10/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txt_docType;

@property (weak, nonatomic) IBOutlet UITextField *txt_country;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *txt_documentation;
@property (weak, nonatomic) IBOutlet UITextField *txtname;
@property (weak, nonatomic) IBOutlet UITextField *txtlastname;
@property (weak, nonatomic) IBOutlet UITextField *txtMail;
@property (weak, nonatomic) IBOutlet UITextField *txtpassword;
@property (weak, nonatomic) IBOutlet UITextField *txtconfirmPass;

//Actions
- (IBAction)Cancel:(id)sender;
- (IBAction)SendData:(id)sender;



@end
