//
//  ForoTestTableViewController.h
//  PLV
//
//  Created by Carlos Burgueño on 29/09/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForoTestTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
- (IBAction)sendAswers:(id)sender;


//pregunta 1
- (IBAction)selectedRadio_1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_1_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_1_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_1_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_1_4;

//pregunta 2

- (IBAction)selectedRadio2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_2_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_2_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_2_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_2_4;

//pregunta 3
- (IBAction)selectedRadio3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_3_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_3_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_3_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_3_4;

//pregunta 4
- (IBAction)selectedRadio4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *radio_4_1;
@property (weak, nonatomic) IBOutlet UIButton *radio_4_2;
@property (weak, nonatomic) IBOutlet UIButton *radio_4_3;
@property (weak, nonatomic) IBOutlet UIButton *radio_4_4;

//pregunta 5
@property (weak, nonatomic) IBOutlet UITextField *txt_pregunta5;

//pregunta 5
@property (weak, nonatomic) IBOutlet UITextField *txt_pregunta6;

//pregunta 5
@property (weak, nonatomic) IBOutlet UILabel *txt_pregunta7;

//pregunta 5
@property (weak, nonatomic) IBOutlet UILabel *txt_pregunta8;

@end
