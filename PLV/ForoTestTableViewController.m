//
//  ForoTestTableViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 29/09/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "ForoTestTableViewController.h"
#import "SWRevealViewController.h"

@interface ForoTestTableViewController ()<UIGestureRecognizerDelegate>

@end

//Images to Radio
UIImage *imgYes;
UIImage *imgNo;

//variables
NSString *aswers1;
NSString *aswers2;
NSString *aswers3;
NSString *aswers4;

@implementation ForoTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Var ini
    
    imgNo = [UIImage imageNamed:@"radio-off.png"];
    imgYes= [UIImage imageNamed:@"radio-on.png"];
    
    //Boton Menu
    _menuButton.target =self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Ocultar el teclado cuando el table view es presionado
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
}
*/
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

- (IBAction)selectedRadio_1:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_1_1 setImage:imgYes forState:UIControlStateNormal];
            [_radio_1_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_1_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_2 setImage:imgYes forState:UIControlStateNormal];
            [_radio_1_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_1_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_3 setImage:imgYes forState:UIControlStateNormal];
            [_radio_1_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_1_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_1_4 setImage:imgYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    aswers1 = [NSString stringWithFormat:@"%ld",(long) buttonSelected.tag];
    
}
- (IBAction)selectedRadio2:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_2_1 setImage:imgYes forState:UIControlStateNormal];
            [_radio_2_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_2_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_2 setImage:imgYes forState:UIControlStateNormal];
            [_radio_2_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_2_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_3 setImage:imgYes forState:UIControlStateNormal];
            [_radio_2_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_2_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_2_4 setImage:imgYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    aswers2 = [NSString stringWithFormat:@"%ld",(long) buttonSelected.tag];
    
}
- (IBAction)selectedRadio3:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_3_1 setImage:imgYes forState:UIControlStateNormal];
            [_radio_3_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_3_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_2 setImage:imgYes forState:UIControlStateNormal];
            [_radio_3_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_3_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_3 setImage:imgYes forState:UIControlStateNormal];
            [_radio_3_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_3_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_3_4 setImage:imgYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    aswers3 = [NSString stringWithFormat:@"%ld",(long) buttonSelected.tag];
    
}
- (IBAction)selectedRadio4:(id)sender {
    UIButton *buttonSelected = (UIButton *)sender;
    switch (buttonSelected.tag) {
        case 1:
        {
            [_radio_4_1 setImage:imgYes forState:UIControlStateNormal];
            [_radio_4_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_radio_4_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_2 setImage:imgYes forState:UIControlStateNormal];
            [_radio_4_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [_radio_4_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_3 setImage:imgYes forState:UIControlStateNormal];
            [_radio_4_4 setImage:imgNo forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [_radio_4_1 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_2 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_3 setImage:imgNo forState:UIControlStateNormal];
            [_radio_4_4 setImage:imgYes forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    aswers4 = [NSString stringWithFormat:@"%ld",(long) buttonSelected.tag];
    
}

-(void) ocultarTeclado:(UIGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (IBAction)sendAswers:(id)sender {
    
    NSLog(@"respuesta1:%@",aswers1);
    NSLog(@"respuesta2:%@",aswers2);
    NSLog(@"respuesta3:%@",aswers3);
    NSLog(@"respuesta4:%@",aswers4);
}
@end
