//
//  LoginViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 08/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "LoginViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Reachability.h"

@interface LoginViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@end
NSDictionary *UserData;

@implementation LoginViewController

- (NSPersistentContainer *)persistentContainer {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)hideKeyboard{
    [self.view endEditing:YES];
}

- (IBAction)btn_Login:(id)sender {
    
    if ([_txtMail.text isEqualToString:@""] || [_txt_password.text isEqualToString:@""]) {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Favor de ingresar sus datos" preferredStyle:UIAlertControllerStyleAlert];
        
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
            [self geDataFromUri:_txtMail.text pass:_txt_password.text];
        }
        
    }
    
    
}

-(void)geDataFromUri:(NSString *)user pass:(NSString *)password{
    
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/login"];
    NSString *post = [NSString stringWithFormat:@"user=%@&pass=%@",user,password];
    
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
                                                         UserData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&erorr];
                                                         NSString *codigo = [UserData objectForKey:@"codigo"];
                                                         switch ([codigo integerValue]) {
                                                             case 200:
                                                             {
                                                                 NSDictionary *data = [UserData objectForKey:@"data"];
                                                                 NSManagedObjectContext *context = [self persistentContainer].viewContext;
                                                                  // Create a new managed object
                                                                  NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"UserEntity" inManagedObjectContext:context];
                                                                  [user setValue:[data objectForKey:@"nombre"] forKey:@"name"];
                                                                  [user setValue:[data objectForKey:@"apellidos"] forKey:@"lastname"];
                                                                  [user setValue:[data objectForKey:@"id"] forKey:@"idUser"];
                                                                  [user setValue:[data objectForKey:@"photo"] forKey:@"photo"];
                                                                  
                                                                  NSError *error = nil;
                                                                  // Save the object to persistent store
                                                                  if (![context save:&error]) {
                                                                  NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                                                                  }
                                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                             }
                                                                 break;
                                                             case 300:
                                                             {
                                                                 UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"Los datos ingresados no son validos." preferredStyle:UIAlertControllerStyleAlert];
                                                                 
                                                                 UIAlertAction* yesButton = [UIAlertAction
                                                                                             actionWithTitle:@"Aceptar"
                                                                                             style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * action) {
                                                                                                 //Handle your yes please button action here
                                                                                             }];
                                                                 [alert addAction:yesButton];
                                                                 
                                                                 [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                                                             }
                                                                 break;
                                                             default:
                                                             {
                                                                 UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"Ha Ocurrido un Error" preferredStyle:UIAlertControllerStyleAlert];
                                                                 
                                                                 UIAlertAction* yesButton = [UIAlertAction
                                                                                             actionWithTitle:@"Aceptar"
                                                                                             style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * action) {
                                                                                                 //Handle your yes please button action here
                                                                                             }];
                                                                 [alert addAction:yesButton];
                                                                 
                                                                 [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                                                             }
                                                                 break;
                                                         }
                                                         
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

//textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
