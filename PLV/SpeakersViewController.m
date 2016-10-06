//
//  SpeakersViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 06/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SWRevealViewController.h"
#import "DetailSpeakerViewController.h"

@interface SpeakersViewController ()<UISearchBarDelegate,UIGestureRecognizerDelegate,UITableViewDelegate>

@end

NSMutableArray *speakersArray;

@implementation SpeakersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Config MenuButton
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //hide keyboard ontouch
    /*UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ocultarTeclado:)];
    gesture.delegate = self;
    [_tableView addGestureRecognizer:gesture];*/
    _tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self geDataFromUri];
    [self.tableView reloadData];
    [[self.view viewWithTag:12] stopAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - custom
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

-(void)searchSpeaker:(NSString *)textSearch{
    
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/speakers"];
    NSString *post = [NSString stringWithFormat:@"postValues"];

    
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
                                                         speakersArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&erorr];
                                                         
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

#pragma mark - Table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [speakersArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpeakerCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if ([speakersArray count] > 0) {
        NSDictionary *obj = [speakersArray objectAtIndex:indexPath.row];
        NSString *str = [obj objectForKey:@"conferencista"];
        cell.textLabel.text=str;
        cell.imageView.image=[UIImage imageNamed:@"user.png"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    DetailSpeakerViewController *pdfController = [storyboard instantiateViewControllerWithIdentifier:@"DetailSpeakView"];
    NSDictionary *obj = [speakersArray objectAtIndex:indexPath.row];
    
    pdfController.lbl_name.text = [obj objectForKey:@"conferencista"];
    pdfController.lbl_city.text = [obj objectForKey:@"ciudad"];
    pdfController.lbl_country.text = [obj objectForKey:@"pais"];
    pdfController.lbl_eventName.text = [obj objectForKey:@"agenda"];
    pdfController.lbl_eventDetail.text = [obj objectForKey:@"detalle"];
    NSLog(@"entro");
    
    [self.navigationController pushViewController:pdfController animated:YES];
}

#pragma mark - SearchBar Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    [self searchSpeaker:searchBar.text];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        [searchBar resignFirstResponder];
        [self searchSpeaker:searchText];
    }
}

@end
