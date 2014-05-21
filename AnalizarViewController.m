//
//  AnalizarViewController.m
//  Traxi
//
//  Created by Carlos Castellanos on 04/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "AnalizarViewController.h"
#import "resizeImage.h"
#define DegreesToRadians(x) ((x) * M_PI / 180.0)
@interface AnalizarViewController ()

@end

@implementation AnalizarViewController
{
    UITapGestureRecognizer* tapVista;
     UITapGestureRecognizer* tapCamara;
    UIImageView *otra;
    UIImage *imageToResize;
}
@synthesize stillImageOutput;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    otra=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:otra];
    [super viewDidLoad];
    [self initializeCamera];
    _captura.hidden=NO;
    tapVista      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(esconderTeclado)];
    tapCamara      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(esconderTeclado)];
    [self.view addGestureRecognizer:tapVista];
    [_camara addGestureRecognizer:tapCamara];
    
    
    
 
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//AVCaptureSession to show live video feed in view
- (void) initializeCamera {
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
	session.sessionPreset = AVCaptureSessionPresetPhoto;
	
	AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
	captureVideoPreviewLayer.frame = self.camara.bounds;
	[self.camara.layer addSublayer:captureVideoPreviewLayer];
	
    UIView *view = [self camara];
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    [captureVideoPreviewLayer setFrame:bounds];
    
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *frontCamera;
    AVCaptureDevice *backCamera;
    
    for (AVCaptureDevice *device in devices) {
        
        NSLog(@"Device name: %@", [device localizedName]);
        
        if ([device hasMediaType:AVMediaTypeVideo]) {
            
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                backCamera = device;
            }
            else {
                NSLog(@"Device position : front");
                frontCamera = device;
            }
        }
    }
    
 
    
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
        if (!input) {
            NSLog(@"ERROR: trying to open camera: %@", error);
        }
        [session addInput:input];
 	
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];
    
	[session startRunning];
}




- (IBAction)snapImage:(id)sender {
    if (!haveImage) {
        _captura.image = nil; //remove old image from view
        _captura.hidden=YES; //show the captured image view
        _camara.hidden = NO; //hide the live video feed
        [self capImage];
    }
    else {
        _captura.hidden = YES;
        _captura.hidden=YES;
        haveImage = NO;
    }
}

- (void) capImage { //method to capture image from AVCaptureSession video feed
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (imageSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
           // [self processImage:[UIImage imageWithData:imageData]];
            otra.image=[self convertToGreyscale:[UIImage imageWithData:imageData]];
            //_captura.image=[UIImage imageWithData:imageData];
            _captura.image=[self convertToGreyscale:[UIImage imageWithData:imageData]];
            
            
         /*   Enviar foto para OCR
            Metodo POST
        URL: "http://codigo.labplc.mx/~mikesaurio/taxi.php?act=pasajero&type=identificaplaca"
            add foto (foto de la placa, esta debe estar en escala a grises)*/

            NSData *imageData2 = UIImageJPEGRepresentation(_captura.image, 1.0);
            
            NSLog(@"Tamaño del archivo %i",[imageData length]);
          
            
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
            
           
        }
    }];
    
}


- (void) processImage:(UIImage *)image { //process captured image, crop, resize and rotate
    haveImage = YES;
    
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) { //Device is ipad
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(768, 1022));
        [image drawInRect: CGRectMake(0, 0, 768, 1022)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 130, 768, 768);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        //or use the UIImage wherever you like
        
        [_captura setImage:[UIImage imageWithCGImage:imageRef]];
        
        CGImageRelease(imageRef);
        
    }else{ //Device is iphone
        // Resize image
        UIGraphicsBeginImageContext(CGSizeMake(320, 426));
        [image drawInRect: CGRectMake(0, 0, 320, 426)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect cropRect = CGRectMake(0, 55, 320, 320);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        
        [_captura setImage:[UIImage imageWithCGImage:imageRef]];
        
        CGImageRelease(imageRef);
    }
    
    //adjust image orientation based on device orientation
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"landscape left image");
        
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        _captura.transform = CGAffineTransformMakeRotation(DegreesToRadians(-90));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        NSLog(@"landscape right");
        
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        _captura.transform = CGAffineTransformMakeRotation(DegreesToRadians(90));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"upside down");
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        _captura.transform = CGAffineTransformMakeRotation(DegreesToRadians(180));
        [UIView commitAnimations];
        
    }
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        NSLog(@"upside upright");
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.5];
        _captura.transform = CGAffineTransformMakeRotation(DegreesToRadians(0));
        [UIView commitAnimations];
    }
}






-(void)esconderTeclado{
    
    [self.view endEditing:YES];
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




//crop image button pressed
- (IBAction)cropImage:(id)sender {
    _section.backgroundColor=[UIColor redColor];
    //animate new view onto screen
   /* [UIView animateWithDuration:0.3
                     animations:^{
                         croppedView.frame = CGRectMake(0, 0, 320, 460);
                     }];*/
    
    
    [self cropImageMethod];
}

- (void) cropImageMethod {
    //get top corner coordinate of crop frame
    float topEdgePosition = CGRectGetMinY(_section.frame);
    
    //create UIIMage instance to hold cropped result
    UIImage *croppedImage;
    
    //crop image to selected bounds
    CGRect croppedRect;
    croppedRect = CGRectMake(350, topEdgePosition, 320, 200);
    CGImageRef tmp = CGImageCreateWithImageInRect([_captura.image CGImage], croppedRect);
    croppedImage = [UIImage imageWithCGImage:tmp];
    CGImageRelease(tmp);
    
    //convert cropped image into NSData object
    NSData *CroppedImageData = UIImageJPEGRepresentation(croppedImage, 0);
    NSData *imageData = UIImageJPEGRepresentation(_captura.image, 0);
    
    //get number of bytes in NSData
    NSInteger imageToCropDataSize = imageData.length;
    
    NSLog(@"original size %ld Bytes", (long)imageToCropDataSize);
    
    imageToResize = [UIImage imageWithData:CroppedImageData];
    [self resizeImage];
}


//resizeImage for storage
- (void) resizeImage {
    
    //call resize image class
    resizeImage *imageResize = [[resizeImage alloc]init];
    [imageResize resizeImage:imageToResize width:320 height:200];
    NSData *resizedImageData = [imageResize thumbnailImageData];
    
    NSInteger resizedImageDataSize = resizedImageData.length;
    
    _captura.image = [UIImage imageWithData:resizedImageData];
    NSLog(@"resized size %d Bytes", resizedImageDataSize);
    
}
//Pan gesture recognizer action
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    switch (recognizer.state) {
            
        case UIGestureRecognizerStateChanged: {
            
            CGPoint translation = [recognizer translationInView:self.view];
            
            //allow dragging only in Y coordinates by only updating the Y coordinate with translation position
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y + translation.y);
            
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
            
            
            //get the top edge coordinate for the top left corner of crop frame
            float topEdgePosition = CGRectGetMinY(_section.frame);
            
            //get the bottom edge coordinate for bottom left corner of crop frame
            float bottomEdgePosition = CGRectGetMaxY(_section.frame);
            
            //if the top edge coordinate is less than or equal to 53
            if (topEdgePosition <= 33) {
                
                //draw drag view in max top position
                
                _section.frame = CGRectMake(0, 33, 320, 200);
                
            }
            
            //if bottom edge coordinate is greater than or equal to 480
            
            if (bottomEdgePosition >=460) {
                
                //draw drag view in max bottom position
                _section.frame = CGRectMake(0, 260, 320, 200);
            }
            
        }
            
        default:
            
            break;
            
            
    }
    
    
}


@end
