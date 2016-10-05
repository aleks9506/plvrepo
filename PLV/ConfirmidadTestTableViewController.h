//
//  ConfirmidadTestTableViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 29/09/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmidadTestTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
- (IBAction)SendAswer:(id)sender;

//Question 1
- (IBAction)changeSelected_question1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_1_si;
@property (weak, nonatomic) IBOutlet UIButton *radio_1_no;
@property (weak, nonatomic) IBOutlet UITextField *txt_question1;
//Question 2
- (IBAction)changeSelected_question2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_yes;
@property (weak, nonatomic) IBOutlet UIButton *radio_no;
@property (weak, nonatomic) IBOutlet UITextField *txt_question2;

//Question 3.1
- (IBAction)changeSelected_question31:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_4;
@property (weak, nonatomic) IBOutlet UIButton *radio_5;

//Question 3.2
- (IBAction)changeSelected_question32:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_32_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_32_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_32_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_32_4;
@property (weak, nonatomic) IBOutlet UIButton *radio_32_5;
//Question 3.3
- (IBAction)changeSelected_question33:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_33_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_33_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_33_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_33_4;
@property (weak, nonatomic) IBOutlet UIButton *radio_33_5;

//Question 3.4
- (IBAction)changeSelected_question34:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_34_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_34_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_34_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_34_4;
@property (weak, nonatomic) IBOutlet UIButton *radio_34_5;
//Question 4.1
@property (weak, nonatomic) IBOutlet UITextField *txt_question41;

//Question 4.2
@property (weak, nonatomic) IBOutlet UITextField *txt_question32;

//Question 4.3
@property (weak, nonatomic) IBOutlet UITextField *txt_question_43;

@end
