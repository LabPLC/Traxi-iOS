//
//  AnalizarViewController.h
//  Traxi
//
//  Created by Carlos Castellanos on 04/05/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AnalizarViewController : UIViewController{

    BOOL haveImage;
}
@property (weak, nonatomic) IBOutlet UIView *camara;

@property (retain, nonatomic) IBOutlet UIImageView *captura;
@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
- (IBAction)snapImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *section;
- (IBAction)cropImage:(id)sender ;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
