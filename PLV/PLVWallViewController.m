//
//  PLVWallViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 01/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "PLVWallViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Reachability.h"

#import "postTableViewCell.h"
#import "PostCellWithoutImageTableViewCell.h"

@interface PLVWallViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

NSMutableArray *post;
NSString *base64imge;
NSString *userloginid;

@implementation PLVWallViewController

- (NSPersistentContainer *)persistentContainer {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self isUserLogin];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Menu button function
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    CGRect frameRect = _txt_postContent.frame;
    frameRect.size.height = 110; // <-- Specify the height you want here.
    _txt_postContent.frame = frameRect;
    base64imge = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

-(void)getWallPLV{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/publicaciones"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    post = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void)isUserLogin{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *context = [self persistentContainer].viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:context];
    [request setEntity:description];
    
    NSArray *arrayUser = [context executeFetchRequest:request error:nil];
   
    if ([arrayUser count] != 0) {
        
         NSManagedObject *userData = [arrayUser objectAtIndex:0];
         userloginid = [userData valueForKey:@"idUser"];
        
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
            [self getWallPLV];
            [_tableView reloadData];
        }
        
    }else
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        LoginViewController *controller  = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

-(void)post{
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/publish"];
    NSString *post = [NSString stringWithFormat:@"imagen64=%@&id_user=%@&texto=%@",base64imge,userloginid,_txt_postContent.text];
    post = [post stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
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
                                                         NSDictionary *dataResult = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&erorr];
                                                         NSLog(@"%@",dataResult);
                                                     } );
                                  }];
    
    [task resume];
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

- (IBAction)sendPost:(id)sender {
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
        if ([_txt_postContent.text isEqualToString:@""] && [base64imge isEqualToString:@""]) {
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Publicacion sin ningun tipo de contenido" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Aceptar"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }else
        {
            [self post];
            [self getWallPLV];
            [_tableView reloadData];
        }
    }
}

- (IBAction)selectImage:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


#pragma mark - Table view data source and Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [post count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([post count]>0) {
        NSDictionary *item = [post objectAtIndex:indexPath.row];
        
        if ([[item objectForKey:@"image"] isEqualToString:@""]) {
            PostCellWithoutImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellWithoutImage" forIndexPath:indexPath];
            cell.lbl_username.text =[item objectForKey:@"publicador"];
            cell.lbl_postContent.text = [item objectForKey:@"text"];
            
            return cell;
            
        }else
        {
            postTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCellImage" forIndexPath:indexPath];
            cell.lbl_name.text =[item objectForKey:@"publicador"];
            cell.lbl_postContent.text = [item objectForKey:@"text"];
            
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://plv.procesos-iq.com/%@",[item objectForKey:@"image"]]]];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    // WARNING: is the cell still using the same data by this point??
                    cell.img_post.image = [UIImage imageWithData: data];
                });

            });
            return cell;
        }
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.textLabel.text = @"sin publicaciones para mostrar";
        }
        return cell;
    }
}

/*


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - picker Controller Delegate
// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *selectedImage =[info valueForKey:UIImagePickerControllerOriginalImage];
    double compresRatio =1;
    NSData *imgData=[[NSData alloc] initWithData:UIImageJPEGRepresentation(selectedImage, compresRatio)];
    while ([imgData length] > 500000) {
        compresRatio = compresRatio * 0.5;
        imgData = UIImageJPEGRepresentation(selectedImage, compresRatio);
    }
    selectedImage = [[UIImage alloc] initWithData:imgData];
    
    base64imge=[imgData  base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
