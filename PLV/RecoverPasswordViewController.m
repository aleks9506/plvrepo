//
//  RecoverPasswordViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 10/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "RecoverPasswordViewController.h"
#import "Reachability.h"

@interface RecoverPasswordViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@end

@implementation RecoverPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //hide keyboard ontouch
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidekeyboar)];
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

- (IBAction)changePassword:(id)sender {
    [self hidekeyboar];
    
    if ([_txtUser.text isEqualToString:@""] || [_txtPass.text isEqualToString:@""] || [_txtConfirmPass.text isEqualToString:@""])  {
        //datos incompletos
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Favor de ingresar sus datos" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        if ([_txtPass.text isEqual:_txtConfirmPass.text]) {
            
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
                [self sendPasswordChange:_txtUser.text password:_txtPass.text];
            }
            //metodo cambiar password
        }else{
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Las Contraseñas no coindicen" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Aceptar"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
}

- (IBAction)Cancel:(id)sender {
    
    [self hidekeyboar];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma textField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma Custom Methods

-(void)hidekeyboar{
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

-(void)sendPasswordChange:(NSString *)user password:(NSString *)pass{
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/recuperarpass"];
    NSString *post = [NSString stringWithFormat:@"user=%@&pass=%@",user,pass];
    
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
                                                         //NSError *erorr;
                                                         // parse returned data
                                                         /*NSMutableDictionary *StringData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&erorr];
                                                         
                                                         */
                                                         UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Confirmacion" message:@"La contraseña ha sido cambiada exitosamente!" preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction* yesButton = [UIAlertAction
                                                                                     actionWithTitle:@"Aceptar"
                                                                                     style:UIAlertActionStyleDefault
                                                                                     handler:^(UIAlertAction * action) {
                                                                                         //Handle your yes please button action here
                                                                                     }];
                                                         [alert addAction:yesButton];
                                                         
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                     } );
                                  }];
    [task resume];
}

                                                     
                                                     
@end
