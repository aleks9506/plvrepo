//
//  RegistryViewController.m
//  PLV
//
//  Created by Carlos Burgueño on 10/10/16.
//  Copyright © 2016 Carlos Burgueño. All rights reserved.
//

#import "RegistryViewController.h"
#import "Reachability.h"

@interface RegistryViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>

@end


NSMutableArray *pickerDataSource;
NSString *flag;
NSString *docType;

@implementation RegistryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    flag = @"0";
    [self defaultDataPicker];
    //hide keyboard ontouch
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
#pragma mark - Custom Methods

-(void)defaultDataPicker{
    pickerDataSource = [[NSMutableArray alloc]initWithObjects:@"Tipo de documento",@"Cedula",@"Pasaporte", nil];
    flag = @"0";
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

-(void)sendDataToRegistry{
    
    NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/create"];
    NSString *post = [NSString stringWithFormat:@"user=%@&pass=%@&nombres=%@&apellidos=%@&telefono=%@&email=%@&pais=%@&ciudad=%@&organizacion=%@&tipo_documento=%@&numero_documento=%@",_txtMail.text,_txtpassword.text,_txtname.text,_txtlastname.text,@"",_txtMail.text,_txt_country.text,@"",@"",docType,_txt_documentation.text];
    
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
                                                         NSString *codigo = [dataResult objectForKey:@"codigo"];
                                                         NSLog(@"%@",dataResult);
                                                         switch ([codigo intValue]) {
                                                             case 300:
                                                                    {
                                                                        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Alerta" message:@"Usuario Ya Registrado" preferredStyle:UIAlertControllerStyleAlert];
                                                                        
                                                                        UIAlertAction* yesButton = [UIAlertAction
                                                                                                    actionWithTitle:@"Aceptar"
                                                                                                    style:UIAlertActionStyleDefault
                                                                                                    handler:^(UIAlertAction * action) {
                                                                                                        //Handle your yes please button action here
                                                                                                    }];
                                                                        [alert addAction:yesButton];
                                                                        [self presentViewController:alert animated:YES completion:nil];
                                                                    }
                                                            break;
                                                             case 200:{
                                                                 UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Gracias" message:@"Registro Exitoso" preferredStyle:UIAlertControllerStyleAlert];
                                                                 
                                                                 UIAlertAction* yesButton = [UIAlertAction
                                                                                             actionWithTitle:@"Aceptar"
                                                                                             style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * action) {
                                                                                                 //Handle your yes please button action here
                                                                                             }];
                                                                 [alert addAction:yesButton];
                                                                 [self presentViewController:alert animated:YES completion:nil];
                                                                 
                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                             }
                                                                 
                                                             default:
                                                             {
                                                                 UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Lo Sentimos" message:@"Ha ocurrido un error durante el registro" preferredStyle:UIAlertControllerStyleAlert];
                                                                 
                                                                 UIAlertAction* yesButton = [UIAlertAction
                                                                                             actionWithTitle:@"Aceptar"
                                                                                             style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * action) {
                                                                                                 //Handle your yes please button action here
                                                                                             }];
                                                                 [alert addAction:yesButton];
                                                                 [self presentViewController:alert animated:YES completion:nil];
                                                             }
                                                                 break;
                                                         }
                                                         
                                                     } );
                                  }];
    
    [task resume];
}

-(void)getCountries{
    
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
        NSString *url_string = [NSString stringWithFormat: @"http://plv.procesos-iq.com/phrapi/api/countrys"];
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        pickerDataSource = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        flag = @"1";
    }
}

-(void)hideKeyboard{
    [self.view endEditing:YES];
}

- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SendData:(id)sender {
    
    if ([docType isEqualToString:@""] || [_txt_documentation.text isEqualToString:@""] || [_txtname.text isEqualToString:@""] || [_txtlastname.text isEqualToString:@""] || [_txt_country.text isEqualToString:@""] || [_txtMail.text isEqualToString:@""] || [_txtpassword.text isEqualToString:@""] ) {
        
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Por favor complete el formulario para continuar con el registro" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Aceptar"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
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
            [self sendDataToRegistry];
        }
    }
}

#pragma mark - _pickerView Delegate & dataSource Methods
// The number of columns of data

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerDataSource count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if ([flag isEqualToString:@"0"]) {
        return pickerDataSource[row];
    }else{
        NSDictionary *item = [pickerDataSource objectAtIndex:row];
        return [item objectForKey:@"nombre"];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([flag isEqualToString:@"0"]) {
        [_txt_docType setText:pickerDataSource[row]];
        
        switch (row) {
            case 1:
                docType = @"CED";
                break;
            case 2:
                docType = @"PAS";
                break;
            default:
                docType = @"";
                break;
        }
    }else{
        NSMutableDictionary *item = [pickerDataSource objectAtIndex:row];
        [_txt_country setText:[item objectForKey:@"nombre"]];
    }
    [self.view endEditing:YES];
}

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag ==3) {
        [self.view setFrame:CGRectMake(0,0,[self.view frame].size.width,[self.view frame].size.height)];
    }
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag ==3) {
        
        [self.view setFrame:CGRectMake(0,(100-([self.view frame].size.height/2)),[self.view frame].size.width,[self.view frame].size.height)];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    UIPickerView *picker = [[UIPickerView alloc] init];
    [picker setDelegate:self];
    [picker setDataSource:self];
    
    if (textField.tag ==1) {
        [self defaultDataPicker];
        [picker reloadAllComponents];
        textField.inputView = picker;
    }else if (textField.tag == 2)
    {
        [self getCountries];
        [picker reloadAllComponents];
        textField.inputView = picker;
    }
    
}

@end
