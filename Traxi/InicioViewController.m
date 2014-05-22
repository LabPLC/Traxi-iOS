//
//  InicioViewController.m
//  Traxi
//
//  Created by Carlos Castellanos on 20/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "InicioViewController.h"
#import "AppDelegate.h"
#import "DetallesViewController.h"
@interface InicioViewController ()

@end

@implementation InicioViewController
{
    UIImage *foto;
    AppDelegate *delegate;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)cambiarFocus{
     [_numeros becomeFirstResponder];
}
- (void)viewDidLoad
{
    
    
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cambiarFocus) name:@"cambiar" object:nil];
   [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [_letra becomeFirstResponder];
    //_imagen.hidden=TRUE;
    
    _letra.tag=0;
    _numeros.tag=1;
    [_letra addTarget:self
                  action:@selector(letraChange)
        forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)letraChange{
     [_numeros becomeFirstResponder];
    NSLog(@"letra cabio");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Monitoramos lo que se introduce en los text de modo que se forme un número de placa valida
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    //Verifica los numeros de la placa
    if (textField.tag==1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 5));
    }
    else{
        //Verifica las letras de la placa
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"abABmM"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
       
        return (([string isEqualToString:filtered])&&(newLength <= 1));
      
        
        
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
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
    //_imagen.hidden=FALSE;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //foto = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    foto=[self convertToGreyscale:chosenImage];
    
    _imagen.image=foto;
    /*   Enviar foto para OCR
     Metodo POST
     URL: "http://codigo.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=identificaplaca"
     add foto (foto de la placa, esta debe estar en escala a grises)*/
    
    NSData *imageData2 = UIImageJPEGRepresentation(foto, 1.0);
    
    NSLog(@"Tamaño del archivo %i",[imageData2 length]);
    
    
    NSString *urlString = @"http://codigo.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=identificaplaca";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"foto\"; filename=\"imageniPhoneTaxi.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData2]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [request setHTTPBody:body ];
    /*******************************************************
     Recibe respuesta del servidor y la pasa a un array
     *******************************************************/
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",returnString);
    UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"msj" message:returnString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alerta show];

    //[self escanear:nil];
    [_letra becomeFirstResponder];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (UIImage *) convertToGreyscale:(UIImage *)i {
    
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    
    int colors = kGreen | kBlue | kRed;
    int m_width = i.size.width;
    int m_height = i.size.height;
    
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [i CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count=0;
            if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
            if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
            if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
            m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1);
    
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4]=0;
        int val=m_imageData[i];
        result[i*4+1]=val;
        result[i*4+2]=val;
        result[i*4+3]=val;
    }
    
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    
    free(m_imageData);
    
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    
    return resultUIImage;
}

-(IBAction)verificar:(id)sender
{
 
    
    if ([_letra.text length]== 1 && [_numeros.text length]==5) {
        
        if ([_letra.text isEqualToString:@"a"] || [_letra.text isEqualToString:@"A"] || [_letra.text isEqualToString:@"B"] || [_letra.text isEqualToString:@"b"] || [_letra.text isEqualToString:@"M"] || [_letra.text isEqualToString:@"m"] )
        {
            NSString *placas= [NSString stringWithFormat:@"%@%@",_letra.text,_numeros.text];
            delegate.placa=placas;
            
          
            [self llamada_asincrona];
            NSLog(@"presiono boton");
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Por favor introduce un número de placa valida" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Por favor introduce un número de placa valida" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

-(void)llamada_asincrona{
     NSString *urlString = [NSString stringWithFormat:@"http://datos.labplc.mx/movilidad/taxis/%@.json",delegate.placa];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        if ([data length] >0  )
        {
            
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([dato isEqualToString:@"null"]) {
               
               
                [self detalles];
                
                
            }
            else{
                NSMutableString * miCadena = [NSMutableString stringWithString: dato];
                NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
                
                NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
                consulta = [jsonObject objectForKey:@"Taxi"];
                NSArray *resultado=[consulta objectForKey:@"concesion"];
                if([resultado count]==1)
                {
                    delegate.registrado=@"Este vehículo no es regular.";
                    delegate.marca=nil;
                    delegate.submarca=nil;
                    delegate.anio=nil;
                    
                    [self detalles];
                }
                else{
                    
                    
                    delegate.registrado=@"Este vehículo es regular.";
                    delegate.marca=[[consulta objectForKey:@"concesion"] objectForKey:@"marca"];
                    delegate.submarca=[[consulta objectForKey:@"concesion"] objectForKey:@"submarca"];
                    delegate.anio=[[consulta objectForKey:@"concesion"] objectForKey:@"anio"];
                    [self detalles];
                }
            }
        }
        else{
            // respuesta = nil;
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No se pudo realizar la petición, intentalo de nuevo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alert show];
            
          
            //alert=nil;
            
        }
        
        
    });
    
}

-(void)detalles{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://datos.labplc.mx/movilidad/vehiculos/%@.json",delegate.placa];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        NSString *dato = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if ([dato isEqualToString:@"null"]) {
            
            NSLog(@"No encontramos información sobre este taxi");
            
        }
        
        else{
            
            NSMutableString * respuesta = [NSMutableString stringWithString: dato];
            NSData *data_respuesta = [respuesta dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data_respuesta options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
            consulta = [jsonObject objectForKey:@"consulta"];
            delegate.infracciones=[consulta objectForKey:@"infracciones"];
            delegate.tenencias=[consulta objectForKey:@"tenencias"];
            delegate.verificaciones=[consulta objectForKey:@"verificaciones"];
            
            DetallesViewController *detalles;//=[[DescripcionViewController alloc]init];
            
            detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"detalles"];
         
           // DetallesViewController *detalles = [[DetallesViewController alloc] init];
            [self.navigationController pushViewController:detalles animated:YES];
            

           // NSLog(@"el taxi debe los años %@",[delegate.tenencias objectForKey:@"adeudos"]);
            
        }
        
    });
}


@end
