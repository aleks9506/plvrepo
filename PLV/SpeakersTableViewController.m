//
//  SpeakersTableViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 27/09/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "SpeakersTableViewController.h"
#import "SWRevealViewController.h"

@interface SpeakersTableViewController ()

@end
NSMutableArray *speakersArray;

@implementation SpeakersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Boton de menu
    _menuButton.target = self.revealViewController;
    _menuButton.action =@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self geDataFromUri];
    [self.tableView reloadData];
    [[self.view viewWithTag:12] stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showActivityImage{
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

-(void)geDataFromUri{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/speakers"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    speakersArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [speakersArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSpeaker" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([speakersArray count] > 0) {
        NSDictionary *obj = [speakersArray objectAtIndex:indexPath.row];
        NSString *str = [obj objectForKey:@"conferencista"];
        cell.textLabel.text=str;
        cell.imageView.image=[UIImage imageNamed:@"user.png"];
    }
    
    return cell;
}


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

@end
