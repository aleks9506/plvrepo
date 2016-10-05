//
//  ConfirmidadTestTableViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 29/09/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "ConfirmidadTestTableViewController.h"
#import "SWRevealViewController.h"

@interface ConfirmidadTestTableViewController ()<UIGestureRecognizerDelegate>

@end

//Images to Radio
UIImage *imageYes;
UIImage *imageNo;

//varToPostValues

NSString *aswer1;
NSString *aswer2;
NSString *aswer31;
NSString *aswer32;
NSString *aswer33;
NSString *aswer34;

@implementation ConfirmidadTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Var ini
    
    imageNo = [UIImage imageNamed:@"radio-off.png"];
    imageYes = [UIImage imageNamed:@"radio-on.png"];
    
    //MenuButton
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Ocultar teclado al toque
    
    //Ocultar el teclado cuando el scroll view es presionado
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ocultarTeclado:)];
    gesture.delegate = self;
    [self.tableView addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeSelected_question1:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) {
        //select YES
        [_radio_1_no setImage:imageNo forState:UIControlStateNormal];
        [_radio_1_si setImage:imageYes forState:UIControlStateNormal];
    }else
    {
        [_radio_1_no setImage:imageYes forState:UIControlStateNormal];
        [_radio_1_si setImage:imageNo forState:UIControlStateNormal];
    }
    
    aswer1 = [NSString stringWithFormat:@"%li",(long)button.tag];
}
- (IBAction)changeSelected_question2:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) {
        //select YES
        [_radio_yes setImage:imageYes forState:UIControlStateNormal];
        [_radio_no setImage:imageNo forState:UIControlStateNormal];
    }else
    {
        [_radio_no setImage:imageYes forState:UIControlStateNormal];
        [_radio_yes setImage:imageNo forState:UIControlStateNormal];
    }
    aswer2 = [NSString stringWithFormat:@"%li",(long)button.tag];
    
}
- (IBAction)changeSelected_question31:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_1 setImage:imageYes forState:UIControlStateNormal];
            [_radio_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_2 setImage:imageYes forState:UIControlStateNormal];
            [_radio_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_3 setImage:imageYes forState:UIControlStateNormal];
            [_radio_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_4 setImage:imageYes forState:UIControlStateNormal];
            [_radio_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [_radio_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_5 setImage:imageYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    aswer31 = [NSString stringWithFormat:@"%li",(long)buttonSelected.tag];
    
}
- (IBAction)changeSelected_question32:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_32_1 setImage:imageYes forState:UIControlStateNormal];
            [_radio_32_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_32_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_2 setImage:imageYes forState:UIControlStateNormal];
            [_radio_32_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_32_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_3 setImage:imageYes forState:UIControlStateNormal];
            [_radio_32_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_32_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_4 setImage:imageYes forState:UIControlStateNormal];
            [_radio_32_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [_radio_32_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_32_5 setImage:imageYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    aswer32 = [NSString stringWithFormat:@"%li",(long)buttonSelected.tag];
    
}
- (IBAction)changeSelected_question33:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_33_1 setImage:imageYes forState:UIControlStateNormal];
            [_radio_33_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_33_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_2 setImage:imageYes forState:UIControlStateNormal];
            [_radio_33_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_33_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_3 setImage:imageYes forState:UIControlStateNormal];
            [_radio_33_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_33_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_4 setImage:imageYes forState:UIControlStateNormal];
            [_radio_33_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [_radio_33_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_33_5 setImage:imageYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    aswer33 = [NSString stringWithFormat:@"%li",(long)buttonSelected.tag];
}
- (IBAction)changeSelected_question34:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_34_1 setImage:imageYes forState:UIControlStateNormal];
            [_radio_34_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_34_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_2 setImage:imageYes forState:UIControlStateNormal];
            [_radio_34_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_34_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_3 setImage:imageYes forState:UIControlStateNormal];
            [_radio_34_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_34_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_4 setImage:imageYes forState:UIControlStateNormal];
            [_radio_34_5 setImage:imageNo forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [_radio_34_1 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_2 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_3 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_4 setImage:imageNo forState:UIControlStateNormal];
            [_radio_34_5 setImage:imageYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    aswer34 = [NSString stringWithFormat:@"%li",(long)buttonSelected.tag];
}

-(void) ocultarTeclado:(UIGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}
- (IBAction)SendAswer:(id)sender {
    
    BOOL flag = YES;
    
    if (aswer1 == nil || aswer2 == nil || aswer31 == nil || aswer32 == nil || aswer33 == nil || aswer34 == nil || [_txt_question41.text  isEqual: @""] || [_txt_question_43 isEqual:@""]) {
        flag =NO;
    }
    
    if(flag){
       //Enviar datos
        NSLog(@"respuesta1:%@",aswer1);
        NSLog(@"respuesta1:%@",aswer2);
        NSLog(@"respuesta1:%@",aswer31);
        NSLog(@"respuesta1:%@",aswer32);
        NSLog(@"respuesta1:%@",aswer33);
        NSLog(@"respuesta1:%@",aswer34);
    }else{
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Lo sentimos, seleccione el valor correspondiente" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}
@end
