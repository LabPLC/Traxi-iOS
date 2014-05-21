//
//  ViewController.m
//  Traxi
//  @rockarloz
//  Created by Carlos Castellanos on 23/04/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import "AnalizarViewController.h"
@interface ViewController () {
    ABAddressBookRef addressBookRef;
    UITapGestureRecognizer* tapVista;
    UITapGestureRecognizer* tapText;
     UITapGestureRecognizer* tapFoto;
}@end

@implementation ViewController

- (IBAction)showPicker:(id)sender
{
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}
- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    _correo1.text = name;
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
   _numero1.text = phone;
    CFRelease(phoneNumbers);
}

-(IBAction)registrar:(id)sender
{
/*
 Dar De alta usuario
 Metodo Post
 URL: "http://datos.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=addpost"
 add nombre (nombre del usuario o NickName)
 add correo (correo del usuario)
 add telemer (telefono del contacto de emergencia)
 add os      (Sistema operativo 1 IOS. 2 Android)//estatico
 add correoemer	(correo del contacto de emergencia)
 add telemer2 (telefono 2 del contacto de emergencia)
 add correoemer2	(correo 2 del contacto de emergencia)
 add foto (foto del perfil) */
    
    
    
    
 
    
    NSData *imageData = UIImageJPEGRepresentation(_foto.image, 1.0);
    
    NSLog(@"Tamaño del archivo %i",[imageData length]);
    
    //  NSURL *url = [NSURL URLWithString:@"http://lionteamsoft.comli.com/subir.php"];
    /*  NSString *postData= [NSString stringWithFormat:@"usr_servicio=%@&passwd_servicio=%@&nombre=%@&apaterno=%@&amaterno=%@&correo=%@&telefono=%@&denuncia=%@&delegacion=%@&tipo_dispositivo=4&a=a",usr_servicio,passwd_servicio,nombre,apaterno,amaterno,correo,telefono,denuncia,delegacion];*/
    
	NSString *urlString = @"http://datos.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=addpost";
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	
    NSString *boundary = @"---------------------------14737809831466499882746641449";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nombre\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_nombre.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"correo\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_correo.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *os=@"1";
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"telemer\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_numero1.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"os\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[os dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"correoemer\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_correo1.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"telemer2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_numero2.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"correoemer2\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_correo2.text dataUsingEncoding:NSUTF8StringEncoding]];

    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"foto\"; filename=\"imageniPhone.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

	[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [request setHTTPBody:body ];
    /*******************************************************
     Recibe respuesta del servidor y la pasa a un array
     *******************************************************/
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSLog(@"%@",returnString);

    NSMutableString * miCadena = [NSMutableString stringWithString: returnString];
    NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
    consulta = [jsonObject objectForKey:@"message"];
    NSLog(@"%@",[consulta objectForKey:@"id"]);


    AnalizarViewController *analizar;
    analizar = [[self storyboard] instantiateViewControllerWithIdentifier:@"analizar"];
   /* if ([delegate.alto intValue] < 568)
                                      {
                                          detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion2"];
                                          
                                      }
                                      
                                      else
                                      {
                                          
                                          detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion"];
                                          
                                      }
                                      
                                      detalles.evento=[eventos objectAtIndex:indexPath.row];*/
                                      analizar.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                                      // [self.navigationController pushViewController:detalles animated:YES];
                                      
                                      
                                      [self presentViewController:analizar animated:YES completion:NULL];

 
    

}

- (void)tomarFoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;

    picker.showsCameraControls = YES;
    picker.navigationBarHidden = YES;
    picker.toolbarHidden = YES;
    
    CGRect f = picker.view.bounds;
    f.size.height -= picker.navigationBar.bounds.size.height;
    CGFloat barHeight = (f.size.height - f.size.width) / 2;
    UIGraphicsBeginImageContext(f.size);
    [[UIColor colorWithWhite:10 alpha:.5] set];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
    UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);
    UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 320)];
    [overlayIV setUserInteractionEnabled:NO];
    
    overlayIV.image = overlayImage;//[UIImage imageNamed:(@"otros.png")];//overlayImage;
    
    //[picker.cameraOverlayView addSubview:overlayIV];
    UIView *vista=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 95)];
    vista.backgroundColor=[UIColor blackColor];
    picker.cameraOverlayView=vista;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.foto.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)esconderTeclado{

[self.view endEditing:YES];
}
- (void)viewDidLoad
{
    
      [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]]; 
    
tapVista      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(esconderTeclado)];
tapFoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tomarFoto)];
tapText      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alzarTeclado)];
    [self.foto_aux addGestureRecognizer:tapFoto];
    [self.view addGestureRecognizer:tapVista];
    [self.correo2 addGestureRecognizer:tapText];
    [_numero2 addTarget:self
                        action:@selector(alzarTeclado)
              forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    

}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
 /*   CGRect frame;
    frame.origin.y=-10;
    self.view.frame=frame;*/
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
 /*   CGRect frame;
    frame.origin.y=0;
    self.view.frame=frame;*/
}
-(void)alzarTeclado{

    NSLog(@"levantar vista");
}


@end
