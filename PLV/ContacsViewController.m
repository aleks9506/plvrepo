//
//  ContacsViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 05/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//
#import "RestAPI.h"
#import "ContacsViewController.h"
#import "SWRevealViewController.h"
#import "ContacTableViewCell.h"

@interface ContacsViewController ()<RestAPIDelegate>
@property (nonatomic, strong) RestAPI *restApi;

@end

NSMutableArray *jsonArray;

@implementation ContacsViewController

-(RestAPI *)restApi
{
    if (!_restApi)
    {
        _restApi = [[RestAPI alloc] init];
    }
    return _restApi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Config MenuButton
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self showActivityImage];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self geDataFromUri:@"" followers:@"" follow:@"" parent:@"785"];
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

-(void)geDataFromUri:(NSString *)textSearch followers:(NSString *)followers follow:(NSString *)follow parent:(NSString *)userId{
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/asistentes"];
    NSString *post = [NSString stringWithFormat:@"search=%@&id_parent=%@&me_siguen=%@&los_sigo=%@",textSearch,userId,followers,follow];
    
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    self.restApi.delegate = self;
    [self.restApi httpRequest:request];
    
   // NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
   // jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [jsonArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 ContacTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContacCell" forIndexPath:indexPath];
     
     if ([jsonArray count] > 0) {
         NSDictionary *obj = [jsonArray objectAtIndex:indexPath.row];
         NSString *str = [NSString stringWithFormat: @"%@ %@", [obj objectForKey:@"nombres"], [obj objectForKey:@"apellidos"]];
         cell.llbl_name.text = str;
         cell.userImage.image=[UIImage imageNamed:@"user.png"];
         
         if ([[obj objectForKey:@"asistencia"] isEqual:@"1"]) {
             cell.confirmImage.image = [UIImage imageNamed:@"Punto_verde.png"];
         }
     }else
     {
         cell.llbl_name.text = @"No Se encontraron resultados";
     }
     
     // Configure the cell...
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

// This method is used to receive the data which we get using post method.
- (void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    NSError *error = nil;
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [self.tableView reloadData];
}

- (IBAction)follows_on:(id)sender {
    [self geDataFromUri:@"" followers:@"1" follow:@"" parent:@"785"];
}

- (IBAction)followers_on:(id)sender {
}
@end
