//
//  ContacsViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 05/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "ContacsViewController.h"
#import "SWRevealViewController.h"
#import "ContacTableViewCell.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


@interface ContacsViewController ()<UISearchBarDelegate,UIGestureRecognizerDelegate>


@end

NSMutableArray *jsonArray;
NSString *loginUserId;

@implementation ContacsViewController

- (NSPersistentContainer *)persistentContainer {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Config MenuButton
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self showActivityImage];
    
    //hide keyboard ontouch
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ocultarTeclado:)];
    gesture.delegate = self;
    [_tableView addGestureRecognizer:gesture];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getDataRequest];
    [self.tableView reloadData];
    [[self.view viewWithTag:12] stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSManagedObjectContext *context = [self persistentContainer].viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:context];
    [request setEntity:description];
    
    NSArray *arrayUser = [context executeFetchRequest:request error:nil];
    
    if ([arrayUser count]) {
        NSManagedObject *userData = [arrayUser objectAtIndex:0];
        loginUserId = [userData valueForKey:@"idUser"];
    }
    
}

#pragma mark - Customs Methods

-(void)showActivityImage{
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

-(void)getDataRequest{
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        //connection unavailable
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"No Hay Conexion a Internet" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        //connection available
        NSError *error;
        NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/asistentes"];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    }
}

-(void)geDataFromUri:(NSString *)textSearch followers:(NSString *)followers follow:(NSString *)follow{
    
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/asistentes"];
    NSString *post = [NSString stringWithFormat:@"me_siguen=%@&id_parent=%@&los_sigo=%@&search=%@",followers,loginUserId,follow,textSearch];
    NSLog(@"%@",post);
    
    NSData *postData =[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLenght = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url_string]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Lenght"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task = [[self getURLSession] dataTaskWithRequest:request completionHandler:^( NSData *data, NSURLResponse *response, NSError *error )
                                  {
                                      dispatch_async( dispatch_get_main_queue(),
                                                     ^{
                                                         NSError *erorr;
                                                         // parse returned data
                                                         //NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                         jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&erorr];
                                                         
                                                         [_tableView reloadData];
                                                     } );
                                  }];
    
    [task resume];
}

-(void) ocultarTeclado:(UIGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

//Url Session
- ( NSURLSession * )getURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
                  ^{
                      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                      session = [NSURLSession sessionWithConfiguration:configuration];
                  } );
    
    return session;
}

#pragma mark - Table view data source and Delegates

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


- (IBAction)changeValueSwitch:(id)sender {
    NSString *followers = @"";
    NSString *follow = @"";
    
    if (_sw_followers.isOn) followers=@"1";
    if (_sw_follows.isOn) follow =@"1";
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        //connection unavailable
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"No Hay Conexion a Internet" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        //connection available
        [self geDataFromUri:@"" followers:followers follow:follow];
    }
}
#pragma mark - SearchBar Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *followers = @"";
    NSString *follow = @"";
    
    if (_sw_followers.isOn) followers=@"1";
    if (_sw_follows.isOn) follow =@"1";
    
    [searchBar resignFirstResponder];
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        //connection unavailable
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"No Hay Conexion a Internet" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        //connection available
       [self geDataFromUri:_txt_search.text followers:followers follow:follow];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        NSString *followers = @"";
        NSString *follow = @"";
        
        if (_sw_followers.isOn) followers=@"1";
        if (_sw_follows.isOn) follow =@"1";
        
        [searchBar resignFirstResponder];
        
        if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
        {
            //connection unavailable
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"No Hay Conexion a Internet" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Aceptar"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            //connection available
            [self geDataFromUri:searchText followers:followers follow:follow];
        }
        
    }
}

@end
